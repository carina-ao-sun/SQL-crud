CREATE TABLE restaurants(
    id INTEGER PRIMARY KEY,
    Category TEXT,
    Price_Tier TEXT,
    Neighborhood TEXT,
    Opening_Time TIME,
    Closing_Time TIME,
    Average_Rating FLOAT,
    Good_for_kids BOOLEAN);

.mode csv
.import C:\\Users\\HONOR\\webClass\\restaurants.csv restaurants

SELECT * FROM restaurants;

--Find all cheap restaurants in a particular neighborhood (pick any neighborhood as an example).
select * from restaurants where Neighborhood = "Chelsea" AND Price_Tier = "cheap";

--Find all restaurants in a particular genre (pick any genre as an example) with 3 stars or more, ordered by the number of stars in descending order.
select * from restaurants where Category = "Italian" AND Average_Rating >= 3.0 order by Average_Rating desc;

--Find all restaurants that are open now (see hint below).
SELECT strftime('%H:%M', 'now');
SELECT * from restaurants where Opening_Time <= strftime('%H:%M', 'now') AND Closing_Time >= strftime('%H:%M', 'now');

--Leave a review for a restaurant (pick any restaurant as an example).
alter table restaurants add column Reviews;
UPDATE restaurants SET Reviews = "Not bad" where id = 15;

--Delete all restaurants that are not good for kids.
DELETE from restaurants where Good_for_kids = False;

--Find the number of restaurants in each NYC neighborhood.
SELECT Neighborhood, COUNT(*) as Number_of_Restaurants
FROM restaurants
GROUP BY Neighborhood;



