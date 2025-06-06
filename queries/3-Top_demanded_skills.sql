select 
    skills,
   COUNT(distinct skills_job_dim.job_id) as demand_count
from 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
     job_title_short= 'Data Analyst'  AND
     job_work_from_home= TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 10


