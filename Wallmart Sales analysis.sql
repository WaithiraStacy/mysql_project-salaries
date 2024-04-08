-- WALLMART SALES DATA ANALYSIS
-- Create database salesdatawalmart
CREATE DATABASE IF NOT EXISTS salesdatawalmart;

-- Create table wmsales
CREATE TABLE IF NOT EXISTS wmsales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT NOT NULL,
    gross_income DECIMAL(12, 4),
    rating FLOAT NOT NULL
);

-- Feature Engineering to generate some new columns(time_of day, day_name, month_name)
-- time_of_day

SELECT
     time,
     (CASE
     WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
     WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
     ELSE "Evening"
 END
     )AS time_of_date
FROM wmsales;

ALTER TABLE wmsales ADD COLUMN time_of_day  VARCHAR(20);

UPDATE wmsales
SET time_of_day = (
    CASE
        WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
 END
); 

-- day name
SELECT
     date,
     DAYNAME(date) AS day_name
FROM wmsales;

ALTER TABLE wmsales ADD COLUMN day_name VARCHAR(10);

UPDATE wmsales
SET day_name = DAYNAME(date);

-- month_name

SELECT
    date,
    MONTHNAME(date)
FROM wmsales;

ALTER TABLE wmsales ADD COLUMN month_name VARCHAR(10);

UPDATE wmsales
SET month_name = MONTHNAME(date);

-- Generic questions
-- 1.How many unique cities does the data have?
SELECT
    DISTINCT city
FROM wmsales;

-- ANSWER: Yangon, Naypyitaw, Mandalay

-- 2.In which city is each branch?
SELECT
    DISTINCT branch
FROM wmsales;

SELECT
    DISTINCT city,
    branch
FROM wmsales;

-- ANSWER: branch A:Yangon, branch C:Naypyitaw, branch B:Mandalay

-- Product questions
-- 1. How many unique product lines does the data have?
SELECT
    COUNT(DISTINCT product_line)
FROM wmsales;

-- ANSWER: 6

-- 2. What is the most common payment method?
SELECT
    payment_method,
    COUNT(payment_method) AS cnt
FROM wmsales
GROUP BY payment_method
ORDER BY cnt DESC;

-- ANSWER: Ewallet

-- 3. What is the most selling product line?
SELECT
    product_line,
    COUNT(product_line) AS cnt
FROM wmsales
GROUP BY product_line
ORDER BY cnt DESC;

-- ANSWER: Fashion accessories

-- 4. What is the total revenue by month?
SELECT
    month_name AS month,
    SUM(total) AS total_revenue
FROM wmsales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- ANSWER: January = 116291.8680, March =109455.5070, February = 97219.3740

-- 5. Which month had the largest COGS?
SELECT
    month_name AS month,
    SUM(cogs) AS cogs
FROM wmsales
GROUP BY month_name
ORDER BY cogs DESC;

-- ANSWER: January

-- 6. Which product line had the largest revenue?
SELECT
    product_line,
    SUM(total) AS total_revenue
FROM wmsales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- ANSWER: Food and beverages

-- 7. What is the city with largest revenue?
SELECT
    branch,
    city,
    SUM(total) AS total_revenue
FROM wmsales
GROUP BY city, branch
ORDER BY total_revenue DESC;

-- ANSWER: Naypyitaw

-- 8. What product line had the largest VAT?
SELECT
    product_line,
    AVG(VAT) AS avg_tax
FROM wmsales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- ANSWER: Home and lifestyle

-- 9. Which branch sold more products than average product sold?
SELECT
     branch,
     SUM(quantity) AS qty
FROM wmsales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM wmsales);

-- ANSWER: A 

-- 10. What is the most common product line by gender?
SELECT
    gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM wmsales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- ANSWER: Female = Fashion accessories

-- 11. What is the average rating of each product line?
SELECT
	ROUND(AVG(rating), 2) AS avg_rating,
    product_line
FROM wmsales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- Sales questions
-- 1. Number of sales made in each time of the day per weekday
SELECT 
     time_of_day,
     COUNT(*) AS total_sales
FROM wmsales
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- 2. Which of the customer types brings the most revenue?
SELECT
    customer_type,
    SUM(total) AS total_rev
FROM wmsales
GROUP BY customer_type
ORDER BY total_rev DESC;

-- ANSWER: Member

-- 3. Which City has the largest tax percent/VAT (Value Added Tax)?
SELECT 
     city,
     AVG(VAT) AS VAT
FROM wmsales
GROUP BY city
ORDER BY VAT DESC;

-- ANSWER: Naypyitaw

-- 4. Which customer type pays the most VAT?
SELECT 
     customer_type,
     AVG(VAT) AS VAT
FROM wmsales
GROUP BY customer_type
ORDER BY VAT DESC;

-- ANSWER: Member

-- Customer questions
-- 1. How many unique customer types does the data have?
SELECT
   COUNT(DISTINCT customer_type)
     FROM wmsales;
     
-- ANSWER: 2

-- 2. How many unique payment methods does the data have?
SELECT
   COUNT(DISTINCT payment_method)
     FROM wmsales;
     
-- ANSWER: 3

-- 3. What is the most common customer type?
SELECT
    DISTINCT customer_type
     FROM wmsales;
     
-- ANSWER: Normal

-- 4. Which customer type buys the most?
SELECT
     customer_type,
     COUNT(*) AS cstm_cnt
FROM wmsales
GROUP BY customer_type;

-- ANSWER: Member

-- 5. What is the gender of most of the customers?
SELECT
     gender,
     COUNT(*) as gender_cnt
FROM wmsales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- ANSWER: Female

-- 6. What is the gender distribution per branch?
SELECT
     gender,
     COUNT(*) as gender_cnt
FROM wmsales
WHERE branch = "B"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- 7 Which time of the day do customers give most ratings?
SELECT
     time_of_day,
     AVG(rating) AS avg_rating
FROM wmsales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- ANSWER: Afternoon

--  8. Which time of the day do customers give most ratings per branch?
SELECT
     time_of_day,
     AVG(rating) AS avg_rating
FROM wmsales
WHERE branch = "A"
GROUP BY time_of_day 
ORDER BY avg_rating DESC;

-- ANSWER: branch A :Afternoon, branch B :Morning, brnach C : Evening

-- 9. Which day of the week has the best avg ratings?
SELECT
     day_name,
     AVG(rating) AS avg_rating
FROM wmsales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- ANSWER: Monday

-- 10. Which day of the week has the best average ratings per branch?
SELECT
     day_name,
     AVG(rating) AS avg_rating
FROM wmsales
WHERE branch = "C"
GROUP BY day_name
ORDER BY avg_rating DESC;

-- ANSWER: branch A: Friday, branch B : Monday, branch C : Friday





     
	


