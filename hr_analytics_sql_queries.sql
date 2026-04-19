use hr_analytics;
select * from employee_attrition limit 10;

# Q1.What is the overall attrition rate?

select 
(sum(case when attrition='Yes' then 1 end)*100/count(*)) as attrition_rate 
from employee_attrition;


#Q2. wht is the attrition rate by Department?

select  
department,(sum(case when attrition='Yes' then 1 else 0 end))as attrition_count,
(sum(case when attrition='Yes' then 1 end)*100/count(*)) as attrition_rate 
from employee_attrition
group by department;


# Q3.Find the average, minimum, and maximum monthly income for each department?

select department,avg(monthly_income),max(monthly_income),min(monthly_income)
from  employee_attrition
group by department;


#Q4. wht is the attrition rate by age group?

SELECT
age_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
    AS attrition_count,
    ROUND(100.0 *
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
    / COUNT(*), 2) AS attrition_rate
FROM employee_attrition
GROUP BY age_group
ORDER BY attrition_rate DESC;


#Q5.Write an SQL query to find the top 5 job roles with the highest attrition rate?

select 
job_role,
(sum(case when attrition='Yes' then 1 end)*100/count(*)) as attrition_rate 
from employee_attrition
group by job_role
order by attrition_rate desc
limit 5;

#Q6.Write an SQL query to analyze salary distribution based on attrition ?

SELECT
    attrition,
    ROUND(AVG(monthly_income), 2) AS avg_salary,
    ROUND(MIN(monthly_income), 2) AS min_salary,
    ROUND(MAX(monthly_income), 2) AS max_salary,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY attrition;

# Q7.How does salary slab affect attrition?

select salary_slab,
sum(case when attrition='Yes' then 1 else 0 end)as attrition_count,
(sum(case when attrition='Yes' then 1 else 0 end)*100/count(*))as attrition_rate
from employee_attrition
group by salary_slab;

#Q8.Does overtime lead to more attrition?

select over_time,
sum(case when attrition='Yes' then 1 else 0 end)as attrition_count,
(sum(case when attrition='Yes' then 1 else 0 end)*100/count(*))as attrition_rate
from employee_attrition
group by over_time;

#Q9.What are the Top 3 Job Roles with Highest Attrition per Department?

select * from(select department,job_role,
row_number()over(partition by department order by sum(case when attrition='Yes' then 1 else 0 end)*100/count(*)desc)as dept_rank
from employee_attrition
group by department,job_role)as ranked
where dept_Rank<=3;



# Q10.What is the average monthly income by job role and attrition status?

select job_role, attrition,avg(monthly_income)as avg_sal from employee_attrition
group by job_role,attrition;

