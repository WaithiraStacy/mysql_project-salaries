-- This is a medical insurance project. The dataset is from Kaggle(insurance.csv).
-- It has the following columns;
-- PatientID : Integer Value.
-- age: age of primary beneficiary
-- sex: gender of primary beneficiary (male or female)
-- bmi: body mass index of primary beneficiary
-- children: number of children covered by health insurance / number of dependents
-- smoker: whether the primary beneficiary is a smoker or not (yes or no)
-- region: the beneficiary's residential area in the US (northeast, southeast, southwest, or northwest)
-- charges: individual medical costs billed by health insurance

create database insurance;

-- 1. select all columns for all patients
select * from insurance_data;

-- 2. Display the average bloodpressure for patients in each region
select region,avg(bloodpressure) as avg_bloodpressure from insurance_data
group by region;

-- 3. select the maximum and minimum age in the table
select min(age) as min_age, max(age) as max_age from insurance_data;

-- 4. Select the patientID, age, and region for patients with age between 18 and 25
select patientID,age,region from insurance_data where age between 18 and 25;

-- 5. select the number of diabetic patients in each region
select region,count(PatientID) from insurance_data where diabetic = "Yes"
group by region;

-- 6. What is the average age for patients who are both diabetic and smokers?
select avg(age) as avg_age from insurance_data where diabetic = "yes" and smoker = "yes";

-- 7. Retrieve all patients who have a BMI greater than the average BMI of all patients who are diabetic
select * from insurance_data where diabetic = "yes" and bmi > (select avg(bmi) from insurance_data where diabetic = "yes");

-- 8. Select the average bmi for patients in each age group
select
     case when age < 18 then "Under 18"
     when age between 18 and 30 then "18-30"
     when age between 31 and 50 then "31-50"
     else "over 50"
     end as age_group,
     round(avg(bmi),2) as avg_bmi
     from insurance_data
     group by age_group;
     
     -- 9. Retrieve the total blood pressure for each patient, along with the average bloodpressure across all patients
     select PatientID,sum(bloodpressure) over (partition by PatientID) as total_bloodpressure,avg(bloodpressure) over () as avg_bloodpressure from insurance_data;
     
     -- 10. Retrieve the last 5 patients with the lowest claim amount, along with their respective claim amounts and the total claim amount for all patients
     select PatientID, claim,sum(claim) over () as total_claim from insurance_data
     order by claim asc limit 5;
     
     -- 11. Retrieve the rank of each patient based on their age
     select * , rank() over(order by age) from insurance_data;
     