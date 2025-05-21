
/*Question: What are the most in-demand skills for remote data analyst roles?
- Identify the top 5 in-demand skills specifically for data analyst jobs.
- Focus only on job postings that are work-from-home.
- Why? Retrieves the top 5 skills with the highest demand in remote data analyst roles, 
providing insights into valuable skills for job seekers targeting remote positions.
*/


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



