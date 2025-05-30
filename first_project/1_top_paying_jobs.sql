
/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment opportunities
*/


select distinct 
    job_id, 
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name 
from 
    job_postings_fact 
Left join company_dim
On job_postings_fact.company_id = company_dim.company_id 
where 
    job_title_short = 'Data Analyst' and
    job_location = 'Anywhere' and 
    salary_year_avg is not NULL
Order by 
    salary_year_avg DESC
Limit 10



