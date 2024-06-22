/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
	skills,
	ROUND(AVG(CAST(salary_year_avg as INT)),0) AS avg_salary
FROM
	jobs j
JOIN job_skill js ON j.job_id = js.job_id
JOIN skills ON js.skill_id = skills.skill_id
WHERE 
	job_title_short = 'Data Analyst'
	AND salary_year_avg IS NOT NULL
	AND job_work_from_home = 1
GROUP BY
	skills
ORDER BY
	avg_salary DESC
LIMIT 25;

/*
Here's a breakdown of the results for top paying skills for Data Analysts:
- High Demand for Big Data & ML Skills: 
  Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), 
  reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- Software Development & Deployment Proficiency: 
  Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate 
  automation and efficient data pipeline management.
- Cloud Computing Expertise: 
  Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, 
  suggesting that cloud proficiency significantly boosts earning potential in data analytics.