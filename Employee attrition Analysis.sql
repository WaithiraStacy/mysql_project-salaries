create database employee_attrition;

-- 1. Write an SQL Query to show the number employees in the Sales department
select count(*)
from `wa_fn-usec_-hr-employee-attrition`
where Department = 'Sales';
-- myfindings: 446

-- 2. Which department has the least monthly income with a percentage salary hike more than 15%
select department,
        min(MonthlyIncome)
from `wa_fn-usec_-hr-employee-attrition`
where PercentSalaryHike > 15 
group by department
order by min(MonthlyIncome);
-- myfindings: Sales

-- 3. Identify the total number of male and female whose marital status is single and havent received promotion in the last 5 years
select Gender,count(EmployeeNumber)
from `wa_fn-usec_-hr-employee-attrition`
where MaritalStatus = 'Single'
and YearsSinceLastPromotion = 5
group by Gender;
-- myfindings: Male = 5, Female = 6

-- 4. Find the number of employees with minimum perfomance rating and no promotion for the last 3 years
select count(*)
from `wa_fn-usec_-hr-employee-attrition`
where PerformanceRating = (select min(PerformanceRating) from `wa_fn-usec_-hr-employee-attrition`)
and YearsSinceLastPromotion >= 3;
-- myfindings: 311

-- 5. Who has maximum percentage salary hikes
select YearsAtCompany, PerformanceRating, YearsSinceLastPromotion,
max(PercentSalaryHike)
from `wa_fn-usec_-hr-employee-attrition`
group by YearsAtCompany, PerformanceRating, YearsSinceLastPromotion
order by max(PercentSalaryHike) desc;
