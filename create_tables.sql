SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Hike;
DROP TABLE IF EXISTS Tag;
DROP TABLE IF EXISTS HikeTag;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS User;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Hike (
    hike_id INT AUTO_INCREMENT UNIQUE NOT NULL,
    name VARCHAR(64) NOT NULL,
    location VARCHAR(256),
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    description VARCHAR(512),
    PRIMARY KEY (hike_id)
);

CREATE TABLE Tag (
    tag_id INT AUTO_INCREMENT UNIQUE NOT NULL,
    name VARCHAR(64) UNIQUE NOT NULL,
    PRIMARY KEY (tag_id)
);

CREATE TABLE HikeTag (
    hike_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (hike_id,tag_id),
    FOREIGN KEY (hike_id) REFERENCES Hike (hike_id),
    FOREIGN KEY (tag_id) REFERENCES Tag (tag_id)
);


CREATE TABLE User (
    user_id INT AUTO_INCREMENT UNIQUE NOT NULL,
    username VARCHAR(64) UNIQUE NOT NULL,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    PRIMARY KEY (user_id)
);


CREATE TABLE Review (
    review_id INT AUTO_INCREMENT UNIQUE NOT NULL,
    hike_id INT NOT NULL,
    user_id INT NOT NULL,
    stars TINYINT CHECK (stars BETWEEN 1 AND 5),
    review_text VARCHAR(1024),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (review_id),
    FOREIGN KEY (hike_id) REFERENCES Hike (hike_id),
    FOREIGN KEY (user_id) REFERENCES User (user_id)
);