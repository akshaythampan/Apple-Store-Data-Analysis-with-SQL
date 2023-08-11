#to combine data from multiple tables using UNION ALL

CREATE TABLE AppleStore_combine AS

    SELECT * FROM appleStore_description1
    UNION ALL
    SELECT * FROM appleStore_description2
    UNION ALL
    SELECT * FROM appleStore_description3
    UNION ALL
    SELECT * FROM appleStore_description4
    
    
#To check the number of rows in a table

select COUNT(id) from AppleStore_combine;
select COUNT(DISTINCT id) as Uniqueids from AppleStore;


#To check for the presence of NULL values in a table

SELECT *
FROM AppleStore as missingvalue
WHERE user_rating IS NULL
   OR prime_genre IS NULL;


#he query will retrieve all rows from the AppleStore_combine table where either the track_name or the app_desc column contains NULL values.

SELECT * FROM AppleStore_combine 
WHERE track_name IS NULL OR app_desc IS NULL;


#To show the number of apps in descending order based on the prime_genre from the applestore table,

SELECT prime_genre, COUNT(*) AS num_of_apps
FROM AppleStore
GROUP BY prime_genre
ORDER BY num_of_apps DESC;


#To show the price in descending order along with the track name and user rating columns from the AppleStore table

SELECT track_name, user_rating, price
FROM AppleStore
ORDER BY price DESC;


#To see the minimum, average, and maximum user ratings from the user_rating column in the AppleStore table

SELECT MIN(user_rating) AS min_rating,
       AVG(user_rating) AS avg_rating,
       MAX(user_rating) AS max_rating
FROM AppleStore;


#To check whether paid apps have more user ratings than free apps

SELECT
    CASE WHEN price > 0 THEN 'Paid' ELSE 'Free' END AS app_type,
    COUNT(*) AS num_apps,
    AVG(user_rating) AS avg_rating
FROM
    AppleStore
GROUP BY
    app_type
ORDER BY
    app_type;


#To find the average user rating for apps having different language categories based on the lang_num column from the AppleStore table

SELECT
    CASE 
        WHEN lang_num < 10 THEN 'Less than 10'
        WHEN lang_num >= 10 AND lang_num <= 30 THEN '10-30'
        ELSE 'More than 30'
    END AS language_category,
    AVG(user_rating) AS avg_rating
FROM
    AppleStore
GROUP BY
    language_category
ORDER BY
    language_category;

    
#To find the average rating for each prime_genre in descending order 

SELECT prime_genre, AVG(user_rating) AS avg_rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY avg_rating DESC;

    
#To see if there is any connection between app description length and user rating

SELECT prime_genre, AVG(user_rating) AS avg_rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY avg_rating DESC;

# to calculate the average user rating for apps in the AppleStore database, categorized by the length of their app descriptions

SELECT
    CASE
        WHEN LENGTH(app_desc) >= 100 THEN 'Long'
        WHEN LENGTH(app_desc) >= 50 THEN 'Medium'
        ELSE 'Short'
    END AS description_length_category,
    AVG(user_rating) AS avg_rating
FROM
    AppleStore AS a
JOIN
    AppleStore_combine AS ac ON a.track_name = ac.track_name
GROUP BY
    description_length_category
ORDER BY
    description_length_category;
    
#To identify the highest-rated app(s) within each prime_genre.

SELECT prime_genre, MAX(user_rating) AS max_rating
FROM AppleStore
GROUP BY prime_genre;

#To Find the apps with the highest and lowest prices.

-- Highest Price
SELECT track_name, price
FROM AppleStore
WHERE price = (SELECT MAX(price) FROM AppleStore);

-- Lowest Price
SELECT track_name, price
FROM AppleStore
WHERE price = (SELECT MIN(price) FROM AppleStore);

#To Analyze the average user rating based on different price tiers.

SELECT
    CASE
        WHEN price > 0 THEN 'Paid'
        ELSE 'Free'
    END AS price_tier,
    AVG(user_rating) AS avg_rating
FROM AppleStore
GROUP BY price_tier;

#To Explore the relationship between app size and user ratings

SELECT
    CASE
        WHEN size_bytes < 1000000 THEN 'Small'
        WHEN size_bytes < 5000000 THEN 'Medium'
        ELSE 'Large'
    END AS app_size_category,
    AVG(user_rating) AS avg_rating
FROM AppleStore
GROUP BY app_size_category;

#To SELECT prime_genre, price, COUNT(*) AS num_of_apps
FROM AppleStore
WHERE price > 0
GROUP BY prime_genre, price
ORDER BY prime_genre, price;

#To Visualize the distribution of app prices within each genre.

SELECT prime_genre, price, COUNT(*) AS num_of_apps
FROM AppleStore
WHERE price > 0
GROUP BY prime_genre, price
ORDER BY prime_genre, price;

