# Part 1: Restaurant Finder
### 1. Create the Table
``` 
CREATE TABLE restaurants(
    id INTEGER PRIMARY KEY,
    Category TEXT,
    Price_Tier TEXT,
    Neighborhood TEXT,
    Opening_Time TIME,
    Closing_Time TIME,
    Average_Rating FLOAT,
    Good_for_kids BOOLEAN);
```
### 2. Data Files
Here is the [link](https://github.com/dbdesign-assignments-spring2023/sql-crud-carinasun930/blob/main/data/restaurants.csv)
### 3. Import File
``` 
.mode csv
.import C:\\Users\\HONOR\\webClass\\restaurants.csv restaurants
```
### 4. Queries
``` 
--1. Find all cheap restaurants in a particular neighborhood (pick any neighborhood as an example).

select * from restaurants where Neighborhood = "Chelsea" AND Price_Tier = "cheap";

--2.Find all restaurants in a particular genre (pick any genre as an example) with 3 stars or more, ordered by the number of stars in descending order.

select * from restaurants where Category = "Italian" AND Average_Rating >= 3.0 order by Average_Rating desc;

--3. Find all restaurants that are open now (see hint below).

SELECT * from restaurants where Opening_Time <= strftime('%H:%M', 'now') AND Closing_Time >= strftime('%H:%M', 'now');

--4.Leave a review for a restaurant (pick any restaurant as an example).

alter table restaurants add column Reviews;
UPDATE restaurants SET Reviews = "Not bad" where id = 15;

  
--5.Delete all restaurants that are not good for kids.

DELETE from restaurants where Good_for_kids = False;

  
--6. Find the number of restaurants in each NYC neighborhood.

SELECT Neighborhood, COUNT(*) as Number_of_Restaurants
FROM restaurants
GROUP BY Neighborhood;
```

# 2. Social Media App
### 1. Create the Table
``` 
CREATE TABLE posts (
    post_id INTEGER PRIMARY KEY,
    post_type TEXT,
    user_id INTEGER,
    recipient_id INTEGER NULL,
    content TEXT,
    create_time TIME);

CREATE TABLE users(
    user_id INTEGER PRIMARY KEY,
    username TEXT,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL);
```
### 2. Data Files
Here is the [link](https://github.com/dbdesign-assignments-spring2023/sql-crud-carinasun930/blob/main/data/users.csv)to users. And this is the [link](https://github.com/dbdesign-assignments-spring2023/sql-crud-carinasun930/blob/main/data/posts.csv) to posts.
### 3. Import File
``` 
.mode csv
-- import users

.import C:\\Users\\HONOR\\sql-crud-carinasun930\\data\\users.csv users

.mode csv
-- import posts

.import C:\\Users\\HONOR\\sql-crud-carinasun930\\data\\posts.csv posts
```
### 4. Queries
##### 1.  Register a new User.
``` 
INSERT INTO users (user_id, username, password,email) VALUES (1001, 'carina', 'balabla','as13537@nyu.edu');
```
##### 2.  Create a new Message sent by a particular User to a particular User (pick any two Users for example).
``` 
INSERT INTO posts (post_id,post_type, user_id, recipient_id, content, create_time) VALUES (1001,'message', 262, 222, 'chenqieyaogaofaxiguifeisitong huiluanhougong zuiburongzhu', '2/18/2023 7:05');
```
##### 3.  Create a new Story by a particular User (pick any User for example).
``` 
INSERT INTO posts (post_id, post_type, user_id, recipient_id, content, create_time) VALUES (1002,'story', 966, NULL, 'shitashitajiushita', '2/18/2023 7:03');
```
##### 4. Show the 10 most recent visible Messages and Stories, in order of recency.
``` 
SELECT * FROM posts ORDER BY create_time DESC LIMIT 10;
```
##### 5.Show the 10 most recent visible Messages sent by a particular User to a particular User (pick any two Users for example), in order of recency.
``` 
SELECT *
FROM posts
WHERE post_type = 'message'
  AND user_id = 869
  AND recipient_id = 561
ORDER BY create_time DESC
LIMIT 10;
```
##### 6. Make all Stories that are more than 24 hours old invisible.
``` 
SELECT *
FROM posts
WHERE post_type = 'message'
   OR (post_type = 'story' AND julianday('now') - julianday(create_time)<24);
```
##### 7.Show all invisible Messages and Stories, in order of recency.

``` 
SELECT *
FROM posts
WHERE post_type = 'message'
   OR (post_type = 'story' AND julianday('now') - julianday(create_time)>24)
ORDER BY create_time DESC;
```

##### 8. Show the number of posts by each User.
``` 
SELECT user_id, COUNT(*) AS numb_posts
FROM posts
GROUP BY user_id;
```
##### 9.Show the post text and email address of all posts and the User who made them within the last 24 hours.
``` 
SELECT p.content, u.email, u.username
FROM posts p
INNER JOIN users u ON p.user_id = u.user_id
WHERE JULIANDAY('now') - JULIANDAY(p.create_time)<24;
```
##### 10. Show the email addresses of all Users who have not posted anything yet.
``` 
SELECT email
FROM users
LEFT JOIN posts
ON users.user_id = posts.user_id
WHERE posts.post_id IS NULL;
```