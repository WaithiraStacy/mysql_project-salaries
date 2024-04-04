-- The dataset is a csv file from Kaggle(Salaries.csv)

create database data_s;
-- Use data_s
-- DATA ANALYSIS QUESTIONS TO ANSWER
-- 1. Show all columns and rows in the table
select * from salaries;

-- 2.Show only the EmployeeName and BasePay
select Employeename,Basepay from salaries;

-- 3. Show the number of employees in the table
select count(*) from salaries;

-- 4. Show the unique Agencies in the table
select distinct Agency from salaries;

-- 5. Show the job title and totalpay for all the employees with totalpay greater than 200000
select JobTitle,TotalPay from salaries
where TotalPay > 250000;

-- 6. Show the average totalpay for all employees
select AVG(TotalPay) as "Avg TotalPay" from salaries;

-- 7. Show the least 10 paid employees
select EmployeeName,TotalPay from salaries
order by TotalPay
limit 10;

-- 8. Show the average of Basepay, Overtimepay and Totalpay for each employee
select EmployeeName, (BasePay + OvertimePay + TotalPay)/3 as avg_of_bp_op_totalpay from salaries;

-- 9. Show all employees who have the word "CAPTAIN" IN THEIR Job title
select EmployeeName,JobTitle from salaries
where JobTitle LIKE '%CAPTAIN%';

-- 10. Show all employees with a Jobtitle not equal to "CAPTAIN"
select EmployeeName,JobTitle from salaries
where JobTitle <>'CAPTAIN';

-- 11. Show all employees with an overtimepay between 70,000 and 100,000
select * from salaries
where OvertimePay between 70000 and 100000;

-- 12. Show all employees with overtime pay less than 80,000 or other pay greater than 90,000
select * from salaries
where OvertimePay <80000 or OtherPay > 90000;

-- 13. Show all employees with a total pay between 200,000 and 230,000 and a job title containing the word "Manager"
select * from salaries
where TotalPay between 200000 and 230000
and JobTitle LIKE "%Manager%";

-- 14. Show all employees ordered by their base pay in ascending order
select * from salaries
order by BasePay asc;

-- 15. Show all job titles with an average overtime pay of at least 100000 and order them by the average overtime pay in descending order
select JobTitle, AVG(OvertimePay) as "avgbasepay" from salaries
group by JobTitle
having avg(OvertimePay) >=100000
order by avgbasepay desc;

-- 16. Delete column notes
select * from salaries;
alter table salaries
drop column Notes;
select * from salaries;

-- 17. Update the overtime pay of all employees with job title containing "CAPTAIN" by incrrasing it by 10%
update salaries
set OvertimePay = OvertimePay = 1.1
where JobTitle like "%CAPTAIN%";
select * from salaries;














