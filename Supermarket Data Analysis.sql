-- This is a supermarket data analysis project.The dataset is from kaggle(supermarket.csv)
-- The aim of this project is to perform an exploratory data analysis using MYSQL, by answering the 10 questions listed below.


create database eda_supermarket;

-- 1. Display the first 10 rows from the dataset
select * from supermarket limit 10;

-- 2. Display the last 10 rows from the dataset
select * from supermarket order by 'Invoice ID' desc limit 10;

-- 3. Display random 10 rows from the dataset
select * from supermarket order by rand() limit 10;

-- 4. Display count, min, max, avg, and std values for the total column in the dataset
select count('Total'),
min('Total'),
max('Total'),
avg('Total'),
std('Total')
from supermarket;

-- 5. Find the number of missing values in the Quantity column
select count(*) from supermarket where Quantity is null;
-- my findings: There are no null values in the Quantity column

-- 6. Count the number of occurences of in the Gender column
select Gender,count(Gender) from supermarket group by Gender;
-- myfindings: There are more females than males

-- 7. Find the most frequent city
select city,count(*) from supermarket group by city
order by count(*) desc limit 1;
-- myfindings: Yangon city has the highest purchase

-- 8. Find the sum of quantity in all the branches
select 'Branch',sum(Quantity) from supermarket
group by 'Branch' order by sum(Quantity);
-- myfindings: the sum of quantity in all branches in 5510

-- 9. Display the daily sales by day of week
select * from supermarket;
update supermarket set date = str_to_date(Date,'%m/%d/%Y');
select * from supermarket;
select dayofweek(date),sum(Total) from supermarket group by dayofweek(date)
order by sum(Total) desc;

-- 10. Which s the highest rating?
select Rating from supermarket
order by Rating desc;
-- myfindings: the highest rating is 10

