USE netflixDB;

-- 1. List all users subscribed to the Premium plan:

SELECT 
name, email, plan

FROM users
WHERE plan='Premium';


-- 2. Retrieve all movies in the Drama genre with a rating higher than 8.5:

SELECT 
title, genre, rating
FROM movies
WHERE genre='Drama'
HAVING rating > 8.5;


-- 3. Find the average rating of all movies released after 2015:

SELECT 
AVG(rating) AS Avg_rating
FROM movies
WHERE release_year >2015;

-- 4. List the names of users who have watched the movie Stranger Things along with their completion percentage:

SELECT 
U.name,
M.title,
W.completion_percentage

FROM users U 
LEFT JOIN watchhistory W ON U.user_id = W.user_id
RIGHT JOIN movies M ON W.movie_id = M.movie_id
WHERE M.title='Stranger Things';


-- 5. Find the name of the user(s) who rated a movie the highest among all reviews:

SELECT 
U.name AS Name_of_the_User,
U.email,
R.rating AS Highest_Rated

FROM users U 
RIGHT JOIN reviews R ON U.user_id = R.user_id
ORDER BY Highest_Rated DESC
LIMIT 1;


-- 6. Calculate the number of movies watched by each user and sort by the highest count:

SELECT 
U.name AS User_Name,
count(W.user_id) AS No_of_movies_Watched

FROM users U 
LEFT JOIN watchhistory W ON U.user_id = W.user_id
GROUP BY U.user_id
ORDER BY No_of_movies_Watched DESC;


-- 7.List all movies watched by John Doe, including their genre, rating, and his completion percentage:

SELECT
M.title AS Movie_Title, M.genre, M.rating, W.completion_percentage

FROM movies M
LEFT JOIN Watchhistory W ON M.movie_id = W.movie_id
RIGHT JOIN users U ON W.user_id = U.user_id
WHERE U.name='John Doe';


-- 8.Update the movie's rating for Stranger Things:

SET SQL_SAFE_UPDATES=0;

UPDATE movies
SET rating= 8.9
WHERE title='Stranger Things';


-- 9.Remove all reviews for movies with a rating below 4.0:

DELETE FROM reviews
WHERE rating < 4.0;


-- 10. Fetch all users who have reviewed a movie but have not watched it completely (completion percentage < 100):

SELECT 
U.name, M.title, R.review_text

FROM users U 
RIGHT JOIN watchHistory W ON U.user_id = W.user_id
LEFT JOIN movies M ON W.movie_id= M.movie_id
RIGHT JOIN  reviews R ON U.user_id = R.user_id AND R.movie_id= M.movie_id
WHERE (W.completion_percentage IS NULL OR W.completion_percentage <100);


-- 11. List all movies watched by John Doe along with their genre and his completion percentage:

SELECT
M.title AS Moivies,
M.genre,
W.completion_percentage

FROM movies M
LEFT JOIN watchHistory W ON W.movie_id = M.movie_id 
RIGHT JOIN users U ON U.user_id = W.user_id
WHERE U.name='John Doe';


-- 12.Retrieve all users who have reviewed the movie Stranger Things, including their review text and rating:

SELECT 
U.name AS user,
R.review_text,
R.rating

FROM users U 
LEFT JOIN reviews R ON U.user_id=R.user_id
LEFT JOIN movies M ON R.movie_id=M.movie_id
WHERE title='Stranger Things';


-- 13. Fetch the watch history of all users, including their name, email, movie title, genre, watched date, and completion percentage:

SELECT 
U.name, U.email, M.title AS Movie_Title, M.genre, W.watched_date, W.completion_percentage

FROM users U 
RIGHT JOIN watchHistory W ON U.user_id=W.user_id
LEFT JOIN movies M ON W.movie_id=M.movie_id; 


-- 14.List all movies along with the total number of reviews and average rating for each movie, including only movies with at least two reviews:

SELECT 
M.title, count(R.review_text) AS Total_no_of_Review, avg(R.rating) AS Avg_Rating

FROM movies M
RIGHT JOIN reviews R ON M.movie_id=R.movie_id
GROUP BY M.movie_id
HAVING Total_no_of_Review >1;