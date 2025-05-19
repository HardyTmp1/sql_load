/*
Question: What are the highest-paying skills for remote Data Analyst roles?
- Analyze the average salary for each skill associated with Data Analyst positions.  
- Focus only on jobs with:
  - A specified salary  
  - A remote location ('Anywhere')  
- Include how often each skill appears across job postings to provide context.
- Why this matters: Identifying the most financially rewarding skills 
helps prioritize which tools and technologies to learn next.
*/


select
    round(avg(jpf.salary_year_avg),2) as Avg_salary,
    sd.skills as Skills,
    count(*) as postings_count
from 
    job_postings_fact as jpf
Inner join skills_job_dim as sjd On jpf.job_id = sjd.job_id 
Inner join skills_dim as sd On sjd.skill_id = sd.skill_id 
where
    jpf.job_title_short = 'Data Analyst' and 
    jpf.salary_year_avg is not Null and 
    jpf.job_location = 'Anywhere'
Group by 
    Skills
Order by 
    avg_salary desc
Limit 25

/*Here is the break down of the results for top paying skills associated with Data Analyst
Niche tools like PySpark and Bitbucket offer top pay (>$180K) but are rarely required.
Essential data tools like Pandas, Jupyter, and NumPy are in higher demand with solid salaries (~$140–150K).
Cloud and big data skills (Databricks, GCP) are increasingly valuable for data analysts in modern data stacks.
DevOps-adjacent tools (Airflow, GitLab, Jenkins) boost salaries, especially in data pipeline or MLOps roles.
Rare tech skills pay more, but core analytics tools are safer bets for consistent job opportunities

[
  {
    "avg_salary": "208172.25",
    "skills": "pyspark",
    "postings_count": "2"
  },
  {
    "avg_salary": "189154.50",
    "skills": "bitbucket",
    "postings_count": "2"
  },
  {
    "avg_salary": "160515.00",
    "skills": "couchbase",
    "postings_count": "1"
  },
  {
    "avg_salary": "160515.00",
    "skills": "watson",
    "postings_count": "1"
  },
  {
    "avg_salary": "155485.50",
    "skills": "datarobot",
    "postings_count": "1"
  },
  {
    "avg_salary": "154500.00",
    "skills": "gitlab",
    "postings_count": "3"
  },
  {
    "avg_salary": "153750.00",
    "skills": "swift",
    "postings_count": "2"
  },
  {
    "avg_salary": "152776.50",
    "skills": "jupyter",
    "postings_count": "3"
  },
  {
    "avg_salary": "151821.33",
    "skills": "pandas",
    "postings_count": "9"
  },
  {
    "avg_salary": "145000.00",
    "skills": "elasticsearch",
    "postings_count": "1"
  },
  {
    "avg_salary": "145000.00",
    "skills": "golang",
    "postings_count": "1"
  },
  {
    "avg_salary": "143512.50",
    "skills": "numpy",
    "postings_count": "5"
  },
  {
    "avg_salary": "141906.60",
    "skills": "databricks",
    "postings_count": "10"
  },
  {
    "avg_salary": "136507.50",
    "skills": "linux",
    "postings_count": "2"
  },
  {
    "avg_salary": "132500.00",
    "skills": "kubernetes",
    "postings_count": "2"
  },
  {
    "avg_salary": "131161.80",
    "skills": "atlassian",
    "postings_count": "5"
  },
  {
    "avg_salary": "127000.00",
    "skills": "twilio",
    "postings_count": "1"
  },
  {
    "avg_salary": "126103.00",
    "skills": "airflow",
    "postings_count": "5"
  },
  {
    "avg_salary": "125781.25",
    "skills": "scikit-learn",
    "postings_count": "2"
  },
  {
    "avg_salary": "125436.33",
    "skills": "jenkins",
    "postings_count": "3"
  },
  {
    "avg_salary": "125000.00",
    "skills": "notion",
    "postings_count": "1"
  },
  {
    "avg_salary": "124903.00",
    "skills": "scala",
    "postings_count": "5"
  },
  {
    "avg_salary": "123878.75",
    "skills": "postgresql",
    "postings_count": "4"
  },
  {
    "avg_salary": "122500.00",
    "skills": "gcp",
    "postings_count": "3"
  },
  {
    "avg_salary": "121619.25",
    "skills": "microstrategy",
    "postings_count": "2"
  }
]
*/


