create database layoffs;

-- 1. What is the minimum number of layoffs?
select min(total_layoffs)
from layoffs.tech_layoffs;

-- 2.Display public industries in ascending order
select * from layoffs.tech_layoffs
where status = 'Public'
order by industry;

-- 3. Display industrys and their total layoffs.
select industry, sum(total_layoffs)
from layoffs.tech_layoffs
group by industry;

-- 4. Which locations did not have layoffs
select headquarter_location, sum(total_layoffs)
from layoffs.tech_layoffs
group by headquarter_location
order by 2 asc;

-- 5. Which company had the highest number of layoffs?
select ï»¿company, sum(total_layoffs)
from layoffs.tech_layoffs
group by ï»¿company
order by 2 desc;

