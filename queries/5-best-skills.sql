SELECT
      skills_dim.skill_id,
      skills_dim.skills,
      round(COUNT(skills_job_dim.job_id),0) AS skills_demand,
      AVG(job_postings_fact.salary_year_avg) AS average_salary
FROM
    job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE

GROUP BY
    skills_dim.skill_id

HAVING 
    COUNT(skills_job_dim.job_id)>10
ORDER BY 
    average_salary DESC,
    skills_demand DESC
LIMIT 20;
    

