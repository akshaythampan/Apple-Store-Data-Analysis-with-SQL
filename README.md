# Apple-Store-Data-Analysis-with-SQL

This repository contains SQL queries to analyze and visualize data from the Apple Store dataset. The dataset comprises information about various mobile apps available on the Apple App Store. The SQL queries provided in this document illustrate how to perform data manipulation, exploration, and visualization using SQL. The dataset is stored in multiple tables named appleStore_description1, appleStore_description2, appleStore_description3, and appleStore_description4. Due to size limitations of the target SQL platform (SQLite Online), these tables are combined into a single table named AppleStore_combine.

## Table of Contents

- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [Creating AppleStore_combine](#creating-applestore_combine)
- [Data Exploration and Visualization](#data-exploration-and-visualization)
  - [Checking Number of Rows](#checking-number-of-rows)
  - [Checking for NULL Values](#checking-for-null-values)
  - [Filtering Rows with NULL Values](#filtering-rows-with-null-values)
  - [Top Genres by Number of Apps](#top-genres-by-number-of-apps)
  - [Apps with Highest Price and User Ratings](#apps-with-highest-price-and-user-ratings)
  - [Average User Ratings by App Description Length](#average-user-ratings-by-app-description-length)
  - [Highest-Rated App(s) Within Each Genre](#highest-rated-apps-within-each-genre)
  - [Distribution of App Prices Within Each Genre](#distribution-of-app-prices-within-each-genre)

## Introduction

This repository showcases SQL queries designed to extract insightful information from the Apple Store dataset using SQL. The queries span a wide array of analysis and visualization scenarios, providing a comprehensive view of the dataset.

## Getting Started

To execute the SQL queries, you need access to a relational database management system (RDBMS) such as MySQL, PostgreSQL, SQLite, or Microsoft SQL Server. You can run these queries using your preferred SQL client or directly within your RDBMS environment.

## Creating AppleStore_combine

The following SQL code combines data from multiple tables using the `UNION ALL` operator to create a new table named `AppleStore_combine`.

```sql
CREATE TABLE AppleStore_combine AS
    SELECT * FROM appleStore_description1
    UNION ALL
    SELECT * FROM appleStore_description2
    UNION ALL
    SELECT * FROM appleStore_description3
    UNION ALL
    SELECT * FROM appleStore_description4;
```

## Data Exploration and Visualization

### Checking Number of Rows

To check the number of rows in a table, you can use the `COUNT` function.

```sql
SELECT COUNT(id) FROM AppleStore_combine;
SELECT COUNT(DISTINCT id) AS Uniqueids FROM AppleStore;
```

### Checking for NULL Values

The following queries help identify the presence of NULL values in specific columns.

```sql
SELECT * FROM AppleStore AS missingvalue
WHERE user_rating IS NULL
   OR prime_genre IS NULL;

SELECT * FROM AppleStore_combine
WHERE track_name IS NULL OR app_desc IS NULL;
```

### Filtering Rows with NULL Values

To retrieve all rows from the `AppleStore_combine` table where either the `track_name` or the `app_desc` column contains NULL values:

```sql
SELECT * FROM AppleStore_combine 
WHERE track_name IS NULL OR app_desc IS NULL;
```

### Top Genres by Number of Apps

To show the number of apps in descending order based on the `prime_genre` column:

```sql
SELECT prime_genre, COUNT(*) AS num_of_apps
FROM AppleStore
GROUP BY prime_genre
ORDER BY num_of_apps DESC;
```

### Apps with Highest Price and User Ratings

To display apps with the highest and lowest prices:

```sql
-- Highest Price
SELECT track_name, price
FROM AppleStore
WHERE price = (SELECT MAX(price) FROM AppleStore);

-- Lowest Price
SELECT track_name, price
FROM AppleStore
WHERE price = (SELECT MIN(price) FROM AppleStore);
```

### Average User Ratings by App Description Length

To calculate the average user rating for apps categorized by the length of their app descriptions:

```sql
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
```

### Highest-Rated App(s) Within Each Genre

To identify the highest-rated app(s) within each `prime_genre`:

```sql
SELECT prime_genre, MAX(user_rating) AS max_rating
FROM AppleStore
GROUP BY prime_genre;
```

### Distribution of App Prices Within Each Genre

To visualize the distribution of app prices within each `prime_genre`:

```sql
SELECT prime_genre, price, COUNT(*) AS num_of_apps
FROM AppleStore
WHERE price > 0
GROUP BY prime_genre, price
ORDER BY prime_genre,

 price;
```

---

Feel free to run these SQL queries in your preferred RDBMS environment to analyze and visualize the Apple Store dataset. Customize and modify the queries as needed to suit your analysis requirements. Also, there are many more queries in the SQLite.sql file. feel free to check them out.

---


## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---
