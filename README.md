# INTRODUCTION 
 📊This project explores the most optimal skills for Data Analysts by analyzing job postings, salary data, and remote work availability. Using SQL, I examined which technical skills🚀 are both in high demand and associated with high-paying remote positions💸. The goal is to identify strategic skills📈 for career growth in data analytics🎩 by intersecting market demand and financial incentives.

 SQL queries ? You can take a look of it here : [first_project folder](/sql_load/first_project/)

# BACKGROUND
The data analytics job market is evolving rapidly🚀, with employers increasingly seeking candidates proficient in a variety of technical tools and platforms👨🏻‍💻. However, not all skills are equally valuable in terms of salary or job availability—especially in a remote work setting🎯.

## The questions I wanted to answer through my SQL queries were : 

1. What are the top-paying Data Analyst job postings available for remote work?
2. Which skills are required for the top-paying Data Analyst positions?
3. What are the most in-demand skills for remote Data Analyst roles?
4. Which skills offer the highest average salaries for remote Data Analyst positions?
5. What are the most optimal skills to learn for remote Data Analyst careers (high demand + high salary)?
 



# TOOLS I USED 
For my deep dive into Data Analyst job market, I have used so many powerful skills including :

- **SQL :** I used SQL as the main language for querying and analyzing the job data. It allowed me to filter, join, group, and aggregate large datasets to uncover trends in salaries and skills.🔥
- **PostgreSQL :** PostgreSQL was the database system I used to store and manage structured job posting data. Its reliability and support for complex queries made it ideal for handling multi-table joins and subqueries.⚙️
- **Visual Studio Code :** VS Code provided a fast, customizable editor with SQL extensions (autocomplete, linting, snippets). This made writing, formatting, and testing multiple SQL scripts far more productive.🎯
- **Git & Github :** I relied on Git for version control to track every change in my SQL files. Hosting on GitHub enabled easy collaboration, issue-tracking, and a clear history of how my analysis evolved.🔍


# THE ANALYSIS
This project centers around analyzing the remote job market for Data Analyst roles using SQL. My goal was to identify not just the highest-paying roles, but also the most in-demand and valuable skills associated with those jobs.
### 1.Highest-Paying Jobs 💸

This query lists the top 10 highest-paying remote Data Analyst jobs with available salary data and basic job details.
```sql
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
```
- **Selection**
Retrieves key job details like job title, location, schedule, salary, posting date, and company name.

- **Filtering**
Focuses only on remote (job_location = 'Anywhere') Data Analyst roles that include a salary.

- **Join**
Combines job data with company names using a LEFT JOIN on the company_dim table.

- **Sorting & Limiting**
Orders jobs by highest salary first and limits the result to the top 10 entries.

![Top Paying Data Analyst Jobs](/assets/Top_10_Data_Analyst_Job_Salaries.jpg)
This bar chart shows the top 10 highest-paying remote Data Analyst jobs. Companies like Mantys, Meta, and AT&T offer the highest salaries, with the top reaching $650,000 per year.

### 2. Highest-Paying Job Skills 💲
This SQL query identifies the top 10 highest-paying Data Analyst jobs (with available salary data) from job postings, then retrieves and lists the associated skills required for each of those jobs.
```sql
With top_paying_job as (
    select
        job_id, 
        job_title,
        salary_year_avg,
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
)
select 
    tpj.*,
    skills
from top_paying_job as tpj
Inner join skills_job_dim as sjd On tpj.job_id = sjd.job_id
Inner join skills_dim as sd On sjd.skill_id = sd.skill_id 
order by salary_year_avg DESC
```
This query retrieves the top 10 highest-paying Data Analyst jobs available anywhere, along with their average salaries and company names. It then joins with skill-related tables to list the key skills required for each job. This helps identify which companies offer the best salaries and what skills are in demand for those roles.


### Top 10 Highest-Paying Data Analyst Jobs and Their Skills

| Company Name     | Average Salary ($) | Key Skills                   |
|------------------|--------------------|------------------------------|
| Mantys           | 650,000            | Python, SQL, Tableau         |
| Meta             | 336,500            | Data Visualization, R, SQL   |
| AT&T             | 255,829            | Excel, SQL, Power BI         |
| ...              | ...                | ...   


### 3.In-demand skills 🎩
This query identifies the top 5 most in-demand skills for remote Data Analyst jobs. It counts how frequently each skill appears in job postings that are fully remote, then lists the most common ones along with their names.



```sql
with remote_jobs as (
select 
    skill_id, 
    count(*) as frequency
from 
    skills_job_dim as S
Inner join job_postings_fact as j
    on S.job_id = j.job_id
Where 
    j.job_work_from_home = 'True' and 
    j.job_title_short = 'Data Analyst'
group by 
    s.skill_id 
)
select 
    rj.skill_id,
    s2.skills,
    rj.frequency 
from 
    skills_dim as s2 
Inner join remote_jobs as rj 
ON s2.skill_id = rj.skill_id 
Order by frequency DESC
Limit 5;
```
🔍 Query Breakdown:

- Filter for Remote Data Analyst Jobs:
The query focuses only on job postings where job_work_from_home = 'True' and the role is a Data Analyst.

- Count Skill Frequency:
It counts how many times each skill appears across all those remote job postings.

- Group by Skill ID:
The skills are grouped by skill_id to calculate the total frequency for each skill.

- Join to Get Skill Names:
The query joins with the skills_dim table to convert each skill_id into its human-readable skill name.

- Sort and Limit to Top 5:
Finally, it sorts the skills by frequency (most to least) and shows the top 5 most in-demand skills for remote Data Analyst roles.

![Demanded Skills](/assets/In-demand_skills.jpg)
| Skill         | Frequency |
|---------------|-----------|
| SQL           | 250       |
| Python        | 220       |
| Excel         | 190       |
| Tableau       | 160       |
| Power BI      | 140       |

The table and pie chart below highlight the five most in-demand skills for remote Data Analyst positions, based on job posting data.

- **The table** presents the exact frequency of each skill, showing how often it appeared in job listings.

- **The pie chart** provides a visual representation of each skill’s share, making it easy to see which skills are most commonly required at a glance.

These insights help job seekers understand which technical skills are most valued in remote data analyst roles.


### 4.Highest-Paying Skills Overall💰
In this part of the analysis, I aimed to uncover which specific skills are associated with the highest average salaries for remote Data Analyst roles.
```sql
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
Limit 25;
```
Based on my analysis of remote data analyst job postings with specified salaries, here are three important takeaways about the highest-paying skills:

1️⃣ **Specialized Tools Attract Top Salaries**
Technologies like Apache Airflow, Spark, and Snowflake consistently rank among the top-paying skills. These tools are often used in complex data workflows, and companies are willing to pay more for analysts who can manage large-scale, automated data pipelines.

2️⃣ **Strong Programming Foundations Pay Off**
Core skills like Python, SQL, and R are not only widely required but also linked to higher average salaries. This confirms that solid programming knowledge is essential for unlocking well-compensated data analyst roles.

3️⃣ **Data Engineering Skills Boost Earning Potential**
Skills such as ETL, AWS, and BigQuery—traditionally associated with data engineering—frequently appear in high-paying roles. This suggests that data analysts who can bridge into engineering tasks are especially valuable in the job market.

![Top 10 Highest-paying skills](/assets\Top_10_highest_paying_jobs.jpg)
The chart highlights that Pyspark is associated with the highest average salary among the top 10 skills for remote data analyst roles, followed by Bitbucket and Couchbase/Watson. Elasticsearch has the lowest average salary among the top 10 listed.

### 5.Optimal Skills✨
This query finds the top 15 skills most associated with high-paying remote Data Analyst jobs. It filters for skills linked to jobs that are remote, offer salary data, and have an average salary over $130,000. Only skills that appear in more than 3 such job postings are included. The results are sorted by highest average salary.



```sql
SELECT
    sd.skill_id,
    sd.skills,
    COUNT(CASE 
            WHEN j.salary_year_avg IS NOT NULL 
            AND j.job_location = 'Anywhere' 
            THEN NULL ELSE 1 
          END) AS frequency,
    ROUND(AVG(CASE 
            WHEN j.salary_year_avg IS NOT NULL 
            AND j.job_location = 'Anywhere' 
            THEN j.salary_year_avg 
          END), 2) AS avg_salary
FROM
    job_postings_fact j
INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
INNER JOIN skills_dim sd ON sj.skill_id = sd.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    AND j.job_work_from_home = 'True'
GROUP BY
    sd.skill_id, sd.skills
HAVING
    COUNT(sj.skill_id) - COUNT(CASE 
         WHEN j.salary_year_avg IS NOT NULL 
         AND j.job_location = 'Anywhere' 
         THEN 1 
        END) > 3
    AND AVG(CASE 
            WHEN j.salary_year_avg IS NOT NULL 
            AND j.job_location = 'Anywhere' 
            THEN j.salary_year_avg 
           END) > 130000
ORDER BY
    avg_salary DESC,
    frequency DESC
LIMIT 15;
```
### 💼High-Paying Remote Data Analyst Skills
This query identifies the top 15 in-demand skills for remote Data Analyst jobs that are associated with high average salaries. It filters and ranks skills based on the following criteria:

- ✅ Job is remote and the role is Data Analyst.

- 💵 Includes only jobs with salary data and location set to "Anywhere".

- 📈 Each skill appears in more than 3 qualifying job postings.

- 💲 The average salary for each skill is over $130,000.

### For each skill, the query returns:

- The skill name

- Its frequency (how often it appears in relevant jobs)

- The average salary for jobs requiring that skill

The results are sorted by highest average salary first, then by skill frequency—helping highlight which high-paying skills are both lucrative and relatively common.


# WHAT I LEARNED

As my first end-to-end data analysis project, this experience has been incredibly valuable in helping me build both technical and analytical foundations. Throughout the process, I gained several key insights:

- **Practical SQL Proficiency:** I significantly improved my ability to write complex SQL queries using JOIN, GROUP BY, filtering conditions, and aggregation to extract meaningful insights from relational data.

- **Real-World Data Interpretation:** Analyzing job market data helped me understand how to approach unstructured information and translate it into actionable findings—especially in the context of salary trends and in-demand skills.

- **Tool Integration in a Workflow:** I became familiar with using professional tools like PostgreSQL, Visual Studio Code, and Git/GitHub. Learning how these tools interact in a typical data workflow gave me confidence to handle larger, more advanced projects in the future.

- **Analytical Thinking and Problem Solving:** One of the most important takeaways was learning how to structure a data project from scratch—defining a question, isolating the necessary data, analyzing it with purpose, and presenting the results clearly.

- **Awareness of Industry-Relevant Skills:** This analysis revealed which tools and technologies are most valued in the job market. It gave me a clearer roadmap for what to prioritize in my learning journey moving forward.

# CONCLUSION 

This project served as a practical introduction to real-world data analysis using SQL. By exploring job postings for remote Data Analyst roles, I was able to identify the highest-paying technical skills and uncover trends that are valuable for anyone entering the data field.

Through this process, I not only enhanced my SQL abilities but also learned how to extract insights that are meaningful and relevant to career planning. The findings offer a data-driven perspective on which tools, languages, and platforms are most financially rewarding for analysts.

Although this was my first full project, it laid a solid foundation for more advanced work in data analysis, and it helped me better understand both the technical and strategic thinking required in real data roles. I look forward to applying what I've learned in future projects and continuing to develop my skills



