CREATE TABLE posts (
    post_id INTEGER PRIMARY KEY,
    post_type TEXT,
    user_id INTEGER,
    recipient_id INTEGER NULL,
    content TEXT,
    create_time TIME);



.mode csv

-- import posts
.import C:\\Users\\HONOR\\sql-crud-carinasun930\\data\\posts.csv posts1

CREATE TABLE users(
    user_id INTEGER PRIMARY KEY,
    username TEXT,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL);

.mode csv

-- import users
.import C:\\Users\\HONOR\\sql-crud-carinasun930\\data\\users.csv users



--Register a new User.
INSERT INTO users (user_id, username, password,email) VALUES (1001, 'carina', 'balabla','as13537@nyu.edu');

--Create a new Message sent by a particular User to a particular User (pick any two Users for example).
INSERT INTO posts (post_id,post_type, user_id, recipient_id, content, create_time) VALUES (1001,'message', 262, 222, 'chenqieyaogaofaxiguifeisitong huiluanhougong zuiburongzhu', '2/18/2023 7:05');
       
--Create a new Story by a particular User (pick any User for example).
INSERT INTO posts (post_id, post_type, user_id, recipient_id, content, create_time) VALUES (1002,'story', 966, NULL, 'shitashitajiushita', '2/18/2023 7:03');
SELECT * FROM posts1;
--Show the 10 most recent visible Messages and Stories, in order of recency.
SELECT * FROM posts ORDER BY create_time DESC LIMIT 10;

SELECT * FROM users;
--Show the 10 most recent visible Messages sent by a particular User to a particular User (pick any two Users for example), in order of recency.

SELECT *
FROM posts
WHERE post_type = 'message' 
  AND user_id = 869 
  AND recipient_id = 561
ORDER BY create_time DESC
LIMIT 10;

--Make all Stories that are more than 24 hours old invisible.
SELECT *
FROM posts
WHERE post_type = 'message' OR (post_type = 'story' AND julianday('now') - julianday(create_time)<24);

--Show all invisible Messages and Stories, in order of recency.
SELECT *
FROM posts
WHERE post_type = 'message'
   OR (post_type = 'story' AND julianday('now') - julianday(create_time)>24) 
ORDER BY create_time DESC



--Show the number of posts by each User.

SELECT user_id, COUNT(*) AS numb_posts
FROM posts
GROUP BY user_id;

--Show the post text and email address of all posts and the User who made them within the last 24 hours.
SELECT p.content, u.email, u.username
FROM posts p
INNER JOIN users u ON p.user_id = u.user_id
WHERE JULIANDAY('now') - JULIANDAY(p.create_time)<24 AND p.post_type = 'story';

--Show the email addresses of all Users who have not posted anything yet.
SELECT email
FROM users
LEFT JOIN posts
ON users.user_id = posts.user_id
WHERE posts.post_id IS NULL;




