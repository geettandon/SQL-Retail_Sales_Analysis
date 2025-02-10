-- SQL Retail Sales Analysis
-- Create TABLE 
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (

	transactions_id INT PRIMARY KEY,
	sale_date	DATE,
	sale_time	TIME,
	customer_id	INT,
	gender	VARCHAR(20),
	age		INT,
	category VARCHAR(20),
	quantity		INT,	
	price_per_unit INT,
	cogs		DECIMAL(10,2),
	total_sale	INT
);

-- Query the table
SELECT *
FROM retail_sales
LIMIT 5;

-- Count record
SELECT COUNT(1)
FROM retail_sales;

-- Data Cleaning
-- Check if columns have null values
SELECT *
FROM retail_sales
WHERE transactions_id IS NULL
OR sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantity IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale IS NULL;


-- Delete records where Null values except in age
DELETE FROM retail_sales
WHERE transactions_id IS NULL
OR sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR gender IS NULL
OR category IS NULL
OR quantity IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale IS NULL;

-- Filling Null values in age column with mean
UPDATE retail_sales
SET age = (SELECT AVG(age) FROM retail_sales)
WHERE age IS NULL;
WHERE age IS NULL;

-- Data Exploration

-- Number of Transactions
SELECT COUNT(1) AS Count_of_sales
FROM retail_sales;

-- How many Customers ordered from us
SELECT COUNT(DISTINCT(customer_id)) AS Customer_count
FROM retail_sales;

-- Gender distribution
SELECT gender,
	COUNT(1) AS number_of_people,
	ROUND(CAST(COUNT(1) AS NUMERIC) / (SELECT COUNT(1) FROM retail_sales), 2) * 100  AS percent_of_transactions
FROM retail_sales
GROUP BY gender;

-- Number of Categories
SELECT category,
	COUNT(1) AS number_of_category,
	ROUND(CAST(COUNT(1) AS NUMERIC) / (SELECT COUNT(1) FROM retail_sales), 2) * 100  AS percent_of_transactions
FROM retail_sales
GROUP BY category;

-- Distribution of age
SELECT MIN(age) AS minimum_age,
	ROUND(AVG(age), 0) AS average_age,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY age) AS Median_age,
	MAX(age) AS maximum_age
FROM retail_sales;

-- Distribution of quantity
SELECT MIN(quantity) AS minimum_quantity,
	ROUND(AVG(quantity), 0) AS average_quantity,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY quantity) AS Median_quantity,
	MAX(quantity) AS maximum_quantity
FROM retail_sales;

-- Distribution of price_per_unit
SELECT MIN(price_per_unit) AS minimum_price_per_unit,
	ROUND(AVG(price_per_unit), 0) AS average_price_per_unit,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price_per_unit) AS Median_price_per_unit,
	MAX(price_per_unit) AS maximum_price_per_unit
FROM retail_sales;

-- Distribution of cogs
SELECT MIN(cogs) AS minimum_cogs,
	ROUND(AVG(cogs), 0) AS average_cogs,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY cogs) AS Median_cogs,
	MAX(cogs) AS maximum_cogs
FROM retail_sales;

-- Distribution of total_sale
SELECT MIN(total_sale) AS minimum_total_sale,
	ROUND(AVG(total_sale), 0) AS average_total_sale,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_sale) AS Median_total_sale,
	MAX(total_sale) AS maximum_total_sale
FROM retail_sales;

-- Data Analysis and Business Problems

-- Q1. Write a SQL Query to retrieve all columns for sales made on '2022-11-05'.
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is at least or more than 4 in the month of Nov-2022.
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND quantity >= 4
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,
	SUM(total_sale) AS total_sales,
	COUNT(1) AS number_of_transactions
FROM retail_sales
GROUP BY category;

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age)) AS average_age_of_customers
FROM retail_sales
WHERE category = 'Beauty';

-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q6. Write a SQL query to find the total number of transactions (transaction_id) 
-- made by each gender in each category.
SELECT gender,
	category,
	COUNT(1) AS total_number_of_transactions
FROM retail_sales
GROUP BY gender, category
ORDER BY category ASC, gender ASC;

-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT TO_CHAR(sale_date, 'MM') AS month,
	ROUND(AVG(total_sale), 2) AS Average_sale
FROM retail_sales
GROUP BY month
ORDER BY month;

-- Best Month in each year.
WITH CTE AS (
	SELECT EXTRACT(YEAR FROM sale_date) AS year,
		EXTRACT(MONTH FROM sale_date) AS month,
		AVG(total_sale) AS avg_total_sales,
		ROW_NUMBER() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
	FROM retail_sales
	GROUP BY year, month 
	)

SELECT year, month, ROUND(avg_total_sales, 2) AS average_total_sales
FROM CTE
WHERE rank = 1;

-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales.
SELECT customer_id,
	SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,
	COUNT(DISTINCT(customer_id)) AS unique_customer
FROM retail_sales
GROUP BY category;

-- Q10. Write a SQL query to create each shift and number of orders 
-- (Example Morning <12, Afternoon Between 12 & 17, Evening >17).
SELECT shift,
	COUNT(1) AS number_of_orders
FROM (
	SELECT *,
		CASE
			WHEN EXTRACT(Hour FROM sale_time) < 12 THEN 'Morning'
			WHEN EXTRACT(Hour FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS shift
	FROM retail_sales) AS t1
GROUP BY shift;


-- Findings
-- 1. Orders came from 155 customers.
-- 2. Data has higher number of female customers than male customers with data showing 51% to 49% respectively.
-- 3. Most number of order comes of clothing products, however Electronics brings highest sales, suggesting higher average order value.
-- 4. We have 18 year and 64 year old customers with most in their early forties.
-- 5. Maximum quantity ordered across orders is 4.
-- 6. Average sales value is 457.
-- 7. Females bought more Beauty Category products, whereas Males bought more Clothing and Electronics products. Females buying most beauty products have average age of 40.
-- 8. Highest Average Sales in 2022 came in July and in 2023, from February.
-- 9. Highest Sales came from Customer with id 3 with substantial difference from other customers.
-- 10. Clothing category had most unique customers as buyers.
-- 11. Most orders came in the Evening shift which after 1800 hours or 6 PM.