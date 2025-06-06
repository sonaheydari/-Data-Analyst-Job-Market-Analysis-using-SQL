SELECT 
   round(AVG(salary_year_avg) , 0) as average_salary,
    job_title,
    COUNT(*) AS total_postings
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg is NOT NULL
GROUP BY 
    job_title
ORDER BY 
    total_postings DESC
LIMIT 10;
