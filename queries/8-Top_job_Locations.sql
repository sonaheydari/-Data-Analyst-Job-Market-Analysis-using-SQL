SELECT 
    job_location,
    COUNT(job_id) AS total_jobs,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY 
    job_location
HAVING 
    COUNT(job_id) >= 10
ORDER BY 
    average_salary DESC
LIMIT 20;

