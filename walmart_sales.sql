-- prep DB
CREATE DATABASE IF NOT EXISTS walmartdatasales;

-- Creattable 
CREATE TABLE IF NOT EXISTS sales(
       invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
   branch VARCHAR(5) NOT NULL,
   city VARCHAR(30) NOT NULL,
   customer_type VARCHAR(30) NOT NULL,
   gender VARCHAR(10) NOT NULL,
   product_line VARCHAR(100) NOT NULL,
   unit_price DECIMAL(10,2) NOT NULL,
   quantity INT NOT NULL,
   tax_pct FLOAT(6,4) NOT NULL,
   total DECIMAL(12, 4) NOT NULL,
   date DATETIME NOT NULL,
   time TIME NOT NULL,
   payment VARCHAR(15) NOT NULL,
   cogs DECIMAL(10,2) NOT NULL,
   gross_margin_pct FLOAT(11,9),
   gross_income DECIMAL(12, 4),
   rating FLOAT(2, 1)
);

-- checking data
select 
* 
FROM sales;

-- data wrangling --


SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;


ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

SELECT
date,
DAYNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

SELECT
date,
MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);


SELECT
    date,
    CASE 
        WHEN MONTH(date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(date) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(date) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Fall'
    END AS season
FROM sales;

ALTER TABLE sales ADD COLUMN season VARCHAR(10);
UPDATE sales
SET season = CASE 
    WHEN MONTH(date) IN (12, 1, 2) THEN 'Winter'
    WHEN MONTH(date) IN (3, 4, 5) THEN 'Spring'
    WHEN MONTH(date) IN (6, 7, 8) THEN 'Summer'
    ELSE 'Fall'
END;

SELECT DISTINCT month_name
FROM sales
ORDER BY month_name;

SELECT DISTINCT season
FROM sales
ORDER BY season;

SELECT DISTINCT date
FROM sales
ORDER BY date;


-- Add the week_event column to the sales table

ALTER TABLE sales ADD COLUMN week_event VARCHAR(50);

UPDATE sales
SET week_event = CASE 
    WHEN date BETWEEN '2019-01-01' AND '2019-01-07' THEN TRUE
    WHEN date BETWEEN '2019-02-10' AND '2019-02-14' THEN TRUE
    WHEN date BETWEEN '2019-02-06' AND '2019-02-12' THEN TRUE
    WHEN date BETWEEN '2019-03-01' AND '2019-03-15' THEN TRUE
    ELSE FALSE
END;
-- checking data
select
  * 
from sales;

SHOW COLUMNS FROM sales;


-- -------------------- EDA -- ------------------------
-- General --

-- How many unique cities does the data have?
SELECT 
DISTINCT city
FROM sales;

-- In which city is each branch?
SELECT 
DISTINCT city,
branch
FROM sales;

-- How many unique product lines does the data have?
SELECT
DISTINCT product_line
FROM sales;


-- Time-based Analysis --
-- Which time of day has the highest average sales?

SELECT time_of_day, AVG(total) AS avg_sales
FROM sales
GROUP BY time_of_day
ORDER BY avg_sales DESC;

-- How do sales vary by day of the week?
SELECT day_name, SUM(total) AS total_sales
FROM sales
GROUP BY day_name
ORDER BY FIELD(day_name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Which month generates the most sales?
SELECT month_name, SUM(total) AS total_sales
FROM sales
GROUP BY month_name
ORDER BY FIELD(month_name, 'January', 'February', 'March');

-- Which season generates the most sales?
SELECT season, SUM(total) AS total_sales
FROM sales
GROUP BY season
ORDER BY total_sales DESC;

-- How do sales vary on holidays compared to non-holidays?
SELECT week_event, AVG(total) AS avg_sales
FROM sales
GROUP BY week_event;

-- Sales Performance --

-- How does the payment method affect total sales?
SELECT payment, SUM(total) AS total_sales
FROM sales
GROUP BY payment
ORDER BY total_sales DESC;

-- What is the average sale per transaction by branch?
SELECT branch, AVG(total) AS avg_sales
FROM sales
GROUP BY branch
ORDER BY avg_sales DESC;

-- What month had the largest COGS?
SELECT
month_name AS month,
SUM(cogs) AS cogs
FROM sales
GROUP BY month_name 
ORDER BY cogs;

-- What is the city with the largest revenue?
SELECT
branch,
city,
SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue;

-- What is the total revenue by month
SELECT
month_name AS month,
SUM(total) AS total_revenue
FROM sales
GROUP BY month_name 
ORDER BY total_revenue;

-- How do product lines affect total sales?
SELECT product_line, SUM(total) AS total_sales
FROM sales
GROUP BY product_line
ORDER BY total_sales DESC;

-- Number of sales made in each time of the day per weekday 
SELECT
time_of_day,
COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT
customer_type,
SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue;

-- Which city has the largest tax/VAT percent?
SELECT
city,
ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM sales
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
customer_type,
AVG(tax_pct) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;

-- Customer Insights --

-- What is the average rating by time of day?
SELECT time_of_day, AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which gender contributes more to total sales?
SELECT gender, SUM(total) AS total_sales
FROM sales
GROUP BY gender
ORDER BY total_sales DESC;

-- What is the gender distribution per branch?
SELECT
gender,
COUNT(*) as gender_cnt
FROM sales
WHERE branch = "A"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Which time of the day do customers give most ratings per branch?
SELECT 
    time_of_day, AVG(rating) AS avg_rating
FROM
    sales
WHERE
    branch = 'C'
GROUP BY time_of_day
ORDER BY avg_rating DESC;
-- Branch A and C are doing well in ratings, branch B needs to do a 
-- little more to get better ratings.

-- Which day fo the week has the best avg ratings?
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;
-- Mon, Tue and Friday are the top best days for good ratings
-- why is that the case, how many sales are made on these days?
SELECT
day_name,
COUNT(*) AS number_of_sales
FROM sales
WHERE day_name IN ('Tuesday', 'Friday', 'Monday')
GROUP BY day_name;

-- Which day of the week has the best average ratings per branch?
SELECT 
day_name,
COUNT(day_name) total_sales
FROM sales
WHERE branch = "B"
GROUP BY day_name
ORDER BY total_sales DESC;

-- Which product lines are most popular among different customer types?
SELECT customer_type, product_line, SUM(quantity) AS total_quantity
FROM sales
GROUP BY customer_type, product_line
ORDER BY customer_type, total_quantity DESC;


-- Product --

-- Which product lines have the highest gross income?
SELECT product_line, SUM(gross_income) AS total_gross_income
FROM sales
GROUP BY product_line
ORDER BY total_gross_income DESC;

-- How does the quantity sold vary by product line?
SELECT product_line, SUM(quantity) AS total_quantity
FROM sales
GROUP BY product_line
ORDER BY product_line, total_quantity DESC;

-- What is the most selling product line
SELECT
SUM(quantity) as qty,
product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

-- What product line had the largest revenue?
SELECT
product_line,
SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What product line had the largest VAT?
SELECT
product_line,
AVG(tax_pct) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;


-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales
-- wich products qulifay with good or bad preformance?
SELECT 
	AVG(quantity) AS avg_qnty
FROM sales;

SELECT
	product_line,
	CASE
		WHEN AVG(quantity) > 5.5 THEN "Good"
        ELSE "Bad"
    END AS remark
FROM sales
GROUP BY product_line;


-- Which branch sold more products than average product sold?
SELECT 
branch, 
SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);


-- What is the most common product line by gender
SELECT
gender,
product_line,
COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating of each product line
SELECT
ROUND(AVG(rating), 2) as avg_rating,
product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- Payment Analysis --

-- Which payment methods are most used by customers during different times of the day?
SELECT time_of_day, payment, COUNT(*) AS payment_count
FROM sales
GROUP BY time_of_day, payment
ORDER BY time_of_day, payment_count DESC;

-- How does the total sales vary with different payment methods over different days of the week?
SELECT day_name, payment, SUM(total) AS total_sales
FROM sales
GROUP BY day_name, payment
ORDER BY FIELD(day_name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'), total_sales DESC;