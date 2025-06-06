# -Data-Analyst-Job-Market-Analysis-using-SQL
This project analyzes real-world data analyst job postings using SQL to uncover insights about salary trends, in-demand skills, optimal tools to learn, job types, and more. It is designed to help aspiring data analysts make informed decisions and build a strong career roadmap.
# 📊 Data Analyst Job Market Analysis using SQL

## 🚀 Project Overview

This project analyzes real-world data analyst job postings using **SQL** to uncover insights about salary trends, in-demand skills, optimal tools to learn, job types, and more. It is designed to help aspiring data analysts make informed decisions and build a strong career roadmap.

## 🛠 Tools Used

* **SQL (PostgreSQL)** – Data querying and analysis
* **Tableau** – Data visualization
* **CSV** – Exporting and organizing query outputs

## 📁 Project Structure

```
📁 data-analyst-sql-project/
├── README.md                  # Project documentation
├── queries/                   # SQL query scripts
├── data_output/               # Exported CSV files
├── charts/                    # Data visualizations
└── notebooks/                 # Optional notes or Jupyter notebooks
```

> 🔹 Note: GitHub doesn't allow empty folders, so add a `placeholder.txt` file if needed to create folders.

---

## 🔍 Key Questions & Insights

### 1️⃣ What are the top-paying data analyst jobs?

**SQL Query:**

```sql
SELECT
  job_id,
  job_title,
  job_location,
  job_via,
  job_schedule_type,
  salary_year_avg,
  job_posted_date,
  name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
  AND job_location = 'Anywhere'
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

**Insights:**

* 💼 All top jobs are senior-level (Director, Principal, Associate Director).
* ⚠️ \$650K salary job is a clear outlier, likely including equity or error.
* 🌎 All roles are remote, but reserved for high-experience positions.
* 🔁 "SmartAsset" appears multiple times — potential growth signal.

### 2️⃣ What skills are required for these top-paying jobs?

**SQL Query:**

```sql
WITH top_paying_jobs AS (
  SELECT job_id, job_title, salary_year_avg, name AS company_name
  FROM job_postings_fact
  LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
  WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
  ORDER BY salary_year_avg DESC
  LIMIT 10
)
SELECT top_paying_jobs.*, skills AS skill_name
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```

**Insights:**

* 💰 Top-paying tools: Jupyter, PowerPoint, Databricks, PySpark (\$255K+)
* 🧠 Core tools: SQL, Python, R — foundational and well-compensated
* 📈 Strong presence of cloud and data tools like Azure, AWS, Snowflake

### 3️⃣ What skills are most in demand for data analysts?

**SQL Query:**

```sql
SELECT
  skills,
  COUNT(DISTINCT skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
  AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```

**Insights:**

* ✅ SQL leads with 7,291 job postings
* 📊 Excel, Python, Tableau, Power BI round out the top 5 skills

### 4️⃣ Which skills are associated with higher salaries?

**SQL Query:**

```sql
SELECT
  skills,
  ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
  AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY average_salary DESC
LIMIT 20;
```

**Insights:**

* 🔥 Highest pay: PySpark (\$208K), Jupyter (\$153K), GitLab (\$155K)
* ⚙️ ML libraries (Pandas, NumPy, Scikit-learn) are highly valued
* ☁️ DevOps and cloud skills like Kubernetes, Jenkins, Linux increase salary

### 5️⃣ What are the most optimal skills to learn?

**SQL Query:**

```sql
SELECT
  skills_dim.skill_id,
  skills_dim.skills,
  ROUND(COUNT(skills_job_dim.job_id), 0) AS skills_demand,
  AVG(job_postings_fact.salary_year_avg) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
  AND salary_year_avg IS NOT NULL
  AND job_work_from_home = TRUE
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY average_salary DESC, skills_demand DESC
LIMIT 20;
```

**Insights:**

* 🚀 Best investment: Go, Snowflake, Azure, BigQuery, Looker
* ✅ Core tools like Python, SQL, Tableau offer best balance of salary + demand

### 6️⃣ What locations offer the best salaries for data analysts?

**SQL Query:**

```sql
SELECT 
  job_location,
  COUNT(job_id) AS total_jobs,
  ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
  AND salary_year_avg IS NOT NULL
GROUP BY job_location
HAVING COUNT(job_id) >= 10
ORDER BY average_salary DESC
LIMIT 20;
```

**Insights:**

* 🌉 California dominates: San Jose, San Francisco, LA pay top dollar
* 🌍 Global highlights: Lisbon, Amsterdam, Athens, and Hyderabad cross \$100K
* 🏢 DC metro cities (Arlington, Bethesda) also pay well

### 7️⃣ How common are remote vs. onsite jobs?

**SQL Query:**

```sql
SELECT
  job_work_from_home,
  COUNT(*) AS total_jobs,
  ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
  AND salary_year_avg IS NOT NULL
GROUP BY job_work_from_home;
```

**Insights:**

* 🏢 Onsite jobs dominate: 4,859 postings
* 🏠 Remote jobs are only \~11% but pay slightly better (\$94,770 vs \$93,765)

### 8️⃣ What are the most common job titles for data analysts?

**SQL Query:**

```sql
SELECT
  job_title,
  COUNT(*) AS total_postings
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY job_title
ORDER BY total_postings DESC
LIMIT 10;
```

**Insights:**

* 💼 “Data Analyst” is most common (1,315 postings)
* 📊 Business, Financial, Marketing Analyst roles are popular variations
* 🧑‍💼 Highest salary: Data Architect (\$156K)
* 🧑‍🎓 Junior Analyst is the main entry-level role

---

## ✅ Conclusion

This project highlights:

* Which roles and skills lead to the highest salaries
* How remote vs. onsite roles differ
* Which tools and technologies are most in demand

Perfect for job seekers and professionals looking to optimize their career path in the data analytics field.
