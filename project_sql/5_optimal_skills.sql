
/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
 offering strategic insights for career development in data analysis
 */



WITH demand_skills as (
    SELECT 
        sd.skill_id, 
        sd.skills,
        count(*) as frequency
    FROM 
        skills_job_dim as S
    INNER JOIN job_postings_fact as j
        on S.job_id = j.job_id
    INNER JOIN skills_dim sd 
        on S.skill_id = sd.skill_id
    WHERE 
        j.job_work_from_home = 'True' and 
        j.job_title_short = 'Data Analyst'
    GROUP BY
        sd.skill_id
), average_salary as (
    SELECT
        sd.skill_id,
        round(avg(jpf.salary_year_avg),2) as Avg_salary,
        sd.skills as Skills
    FROM 
        job_postings_fact as jpf
    INNER JOIN skills_job_dim as sjd On jpf.job_id = sjd.job_id 
    INNER JOIN skills_dim as sd On sjd.skill_id = sd.skill_id 
    WHERE
        jpf.job_title_short = 'Data Analyst' and 
        jpf.salary_year_avg is not Null and 
        jpf.job_location = 'Anywhere'
    GROUP BY
        sd.skill_id
)

SELECT 
    demand_skills.skill_id,
    demand_skills.skills,
    frequency,
    average_salary.avg_salary
FROM 
    demand_skills 
FULL OUTER JOIN average_salary 
ON demand_skills.skill_id = average_salary.skill_id 
WHERE
    avg_salary is not NULL and 
    avg_salary > 130000 and 
    frequency > 3
ORDER BY 
    avg_salary DESC,
    frequency DESC
LIMIT 15


--REWRITING THIS QUERY

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




