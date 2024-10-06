INSERT INTO Tag (name) VALUES
('Nature'),
('Adventure'),
('Family'),
('Scenic'),
('Difficult'),
('Easy'),
('Wildlife'),
('Beach'),
('Mountains'),
('Forest'),
('Urban'),
('Historical'),
('Waterfall'),
('Desert'),
('Camping'),
('Photography');

INSERT INTO User (username, first_name, last_name) VALUES
('user1', 'John', 'Doe'),
('user2', 'Jane', 'Smith'),
('user3', 'Alice', 'Johnson'),
('user4', 'Bob', 'Brown'),
('user5', 'Charlie', 'Davis'),
('user6', 'Diana', 'Wilson'),
('user7', 'Ethan', 'Moore'),
('user8', 'Fiona', 'Taylor'),
('user9', 'George', 'Anderson'),
('user10', 'Hannah', 'Thomas');

INSERT INTO Hike (name, location, latitude, longitude, description) VALUES
('Mountain Trail', 'Mountain National Park', 34.123456, -117.123456, 'A challenging hike with stunning mountain views.'),
('Lakeside Stroll', 'Lakeview Park', 34.234567, -117.234567, 'An easy hike perfect for families by the lakeside.'),
('Forest Adventure', 'Evergreen Forest', 34.345678, -117.345678, 'Explore the dense forest and enjoy the wildlife.'),
('Beach Walk', 'Sunny Beach', 34.456789, -117.456789, 'A relaxing walk along the beach with scenic views.'),
('Desert Escape', 'Sunny Desert', 34.567890, -117.567890, 'A unique hiking experience through the desert landscapes.'),
('Canyon Hike', 'Grand Canyon', 34.678901, -117.678901, 'An unforgettable experience hiking in the Grand Canyon.'),
('Waterfall Trek', 'Mystic Falls', 34.789012, -117.789012, 'Hike to the breathtaking waterfall in the heart of the forest.'),
('Historical Route', 'Old Town', 34.890123, -117.890123, 'A historical route that takes you through the old town.'),
('Scenic Lookout', 'Mountain Peak', 34.901234, -117.901234, 'A scenic lookout with panoramic views of the area.'),
('Wildflower Trail', 'Spring Meadow', 34.012345, -117.012345, 'A beautiful trail filled with wildflowers in the spring.');

INSERT INTO HikeTag (hike_id, tag_id) VALUES
(1, 1), (1, 3), (1, 5),
(2, 2), (2, 4), (2, 7),
(3, 1), (3, 6), (3, 8),
(4, 2), (4, 5), (4, 10),
(5, 2), (5, 11), (5, 12),
(6, 1), (6, 4), (6, 8),
(7, 3), (7, 5), (7, 9),
(8, 6), (8, 12), (8, 14),
(9, 13), (9, 1), (9, 3),
(10, 4), (10, 5), (10, 11);

INSERT INTO Review (hike_id, user_id, stars, review_text) VALUES
(1, 1, 5, 'Amazing views! Highly recommend this hike.'),
(1, 2, 4, 'Great hike but a bit crowded.'),
(2, 3, 3, 'Nice walk, but nothing special.'),
(2, 4, 4, 'Perfect for a family outing!'),
(3, 5, 5, 'An unforgettable experience!'),
(4, 6, 2, 'Not challenging enough for my taste.'),
(5, 7, 5, 'Loved every moment, especially the wildlife!'),
(6, 8, 5, 'Breathtaking views! A must-do!'),
(7, 9, 4, 'Beautiful coastal views but very windy.'),
(8, 10, 5, 'Incredible trek, the summit is worth it!'),
(9, 1, 3, 'Great scenery but the trail was poorly marked.'),
(10, 2, 5, 'A tropical paradise! Perfect for a day hike.'),
(1, 3, 4, 'The waterfalls were stunning, worth the hike!'),
(2, 4, 5, 'A challenging trek with rewarding views at the top!'),
(3, 5, 3, 'A historical route, but the trail was too long.'),
(4, 6, 4, 'Beautiful hike along the beach, great for families!'),
(5, 7, 5, 'An incredible experience hiking through fjords!'),
(6, 8, 4, 'Amazing cultural experience, rich in history.'),
(7, 9, 5, 'The wildflower fields were in full bloom!'),
(8, 10, 3, 'Good trail but not well-maintained.'),
(9, 1, 5, 'A peaceful escape from the city, highly recommend!'),
(10, 2, 5, 'The views of the mountain lakes are breathtaking!');