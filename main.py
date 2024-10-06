import openai
import json
import mysql.connector

zero_shot = ("Hello, today you will be my personal assistant. I need help with an SQL task. I will give you my table data and a question, and I want you to formulate a SQL query that will return the correct rows. Please do not include any commentary, correction, and anything that is not pertinent SQL. \n\n","I have a list of rows returned from an SQL query generated in response to a natural language question. Please interpret the results in a friendly complete sentence. \n\n", "Zero Shot")
one_shot = (zero_shot[0] + "Here is an example: \n\n Tables: \n\n \n\n Question: How many unique customers made a purchase last month? Answer: ```sql SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM `Order` WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);```\n\n", zero_shot[1] + "Here is an example:\n\n Question: What are the customer IDs and names of all customers? \n\nData:Customer ID | Name\n1 | Alice Johnson\n2 | Bob Smith\n3 | Charlie Brown\n\nAnswer: Alice, Bob, and Charlie all purchased cars last month.\n\n", "One Shot")

prompts = [zero_shot, one_shot]
questions = [
    "How many hikes do you have information on?",
    "What hike do you think is the funnest?",
    "What is the most popular type of hike?",
    "I am 75 years old. I can't walk very far. What hike would you recommend?",
    "What hikes do you have in information on in Europe?",
    "What are the names of the two hikes have the most in common?",
    "Who would you say gives the most informative reviews?",
    "Is there a user that is super active on this platform?"
]
def create_database():
    with open('config.json') as f:
        config = json.load(f)['mysql_config']
        conn = None
        try:
            conn = mysql.connector.connect(
                host=config['host'],
                user=config['user'],
                password=config['password']
            )
            if conn.is_connected():
                print('Connected to MySQL server')
                cursor = conn.cursor()
                cursor.execute('CREATE DATABASE aisql;')
                print("created successfully")

        except mysql.connector.Error as e:
            print(f"Error: {e}")

        finally:
            if conn and conn.is_connected():
                cursor.close()
                conn.close()
                print('Connection closed.')

def get_connection():
    with open('config.json') as f:
        config = json.load(f)['mysql_config']
        try:
            connection = mysql.connector.connect(
                host=config['host'],
                user=config['user'],
                password=config['password'],
                database=config['database']
            )
            if connection.is_connected():
                print("Successfully connected to the database")
                return connection
        except mysql.connector.Error as e:
            print(f"Error: {e}")
            return None

def run_sql_file(connection, file):
    cursor = connection.cursor()
    with open(file, 'r') as sql:
        sql_commands = sql.read().split(';')
        for command in sql_commands:
            command = command.strip()
            if command:
                try:
                    cursor.execute(command)
                    connection.commit()
                except mysql.connector.Error as e:
                    print(f"Error executing command: {command}\n{e}")
    cursor.close()

def execute_sql(connection, sql):
    cursor = connection.cursor()
    ret = ""

    queries = sql.split(';')
    for query in queries:
        query = query.strip()
        if query:
            try:
                cursor.execute(query)
                column_headers = [i[0] for i in cursor.description]
                ret += " | ".join(column_headers) + '\n'
                result = cursor.fetchall()
                for row in result:
                    ret += " ".join(map(str, row)) + '\n'
            except mysql.connector.Error as e:
                print(e)
    cursor.close()
    return ret

def send_prompt(prompt, question, connection, client):
    table_data = None
    print(question)
    with open('create_tables.sql', 'r') as file:
        table_data = file.read()

    intro = "Here is my table data:\n" + table_data + "\n"

    completion = client.chat.completions.create(
        model="gpt-4o",
        messages=[
            { "role": "system", "content": intro + prompt[0] + question },
        ]
    )

    sql = completion.choices[0].message.content
    sql = sql.split('```sql')[1]
    sql = sql.split('```')[0]

    print(sql)

    result_string = execute_sql(connection, sql)

    print(result_string)

    outro = "Here is the question: \n\n" + question + "Here are my results \n\n" + result_string + "\n\nNow give me a personable response."

    completion = client.chat.completions.create(
        model="gpt-4o",
        messages=[
            { "role": "user", "content": prompt[1] + outro },
        ]
    )

    print(completion.choices[0].message.content)
    print()

def main():

    with open('config.json') as f:
        config = json.load(f)
        openai.api_key = config['openaiKey']
        openAiClient = openai.OpenAI(
            api_key=config["openaiKey"],
            organization=config["orgId"]
        )
    create_database()
    connection = get_connection()

    run_sql_file(connection, 'create_tables.sql')
    run_sql_file(connection, 'fill_tables.sql')

    for prompt in prompts:
        print("Prompting Strategy: " + prompt[2])
        for question in questions:
            send_prompt(prompt, question, connection, openAiClient)

if __name__ == "__main__":
    main()