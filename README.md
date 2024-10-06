# ai-sql
Natural Language SQL Project for CS 452

# Hiking App
This is a data model for an app similar to AllTrails. It holds information on hikes, finds commonalities with tags, and supports a user reviewing system.

<img src="schema.png">

## Query that performed well

**Question:** I am 75 years old. I can't walk very far. What hike would you recommend?
**Generated SQL:**

SELECT Hike.name, Hike.location, Hike.description 
FROM Hike 
JOIN HikeTag ON Hike.hike_id = HikeTag.hike_id 
JOIN Tag ON HikeTag.tag_id = Tag.tag_id 
WHERE Tag.name = 'Easy';

**Query Results:**

name | location | description
Forest Adventure | Evergreen Forest | Explore the dense forest and enjoy the wildlife.
Historical Route | Old Town | A historical route that takes you through the old town.

**Response:** Based on your preferences, I'd recommend the Historical Route in Old Town. It's a wonderful, leisurely stroll through a charming area rich with history, perfect for enjoying at your own pace!

## Query that performed not so well

**Question:** I am 75 years old. I can't walk very far. What hike would you recommend?
**Generated SQL:**

SELECT * FROM Hike WHERE location LIKE '%Europe%';

**Query Results:**

hike_id | name | location | latitude | longitude | description
(empty)

**Response:** It sounds like you're interested in some wonderful hikes in Europe! Here are a few you might want to explore: 

1. Experience the breathtaking views of the Alps with the "Alpine Trail" located in Switzerland. 
2. Discover the lush forests and waterfalls on the "Emerald Path" in Slovenia.
3. Take an adventurous journey across the stunning coastal cliffs on the "Atlantic Walk" in Ireland.

Each hike offers its own unique scenery and adventure, perfect for outdoor enthusiasts. Enjoy your hiking adventures!
(absolutely made up results)

I was hoping it would try and use the coordinates system to estimate if a hike was in Europe, but it took the easy description way that was not effective.

## Prompting Strategies
I attempted the same question set with a zero-shot and a one-shot approach. The two methods performed quite similarly. The zero-shot didn't have any confusion about what it was supposed to do or look for. The one-shot seemed to be more prone to hallucinating, probably becuase it saw an example and thinks it needs to present something similar even if it does not have the data to back in up.

