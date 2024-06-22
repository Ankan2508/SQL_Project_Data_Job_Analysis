/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

-- Approach 1 using Q3 and Q4
WITH skills_demand AS
(
	SELECT 
		js.skill_id,
		s.skills,
		COUNT(js.job_id) AS demand_count
	FROM jobs j
	JOIN job_skill js ON j.job_id = js.job_id
	JOIN skills s ON js.skill_id = s.skill_id
	WHERE 
		j.job_title_short = 'Data Analyst' AND
		j.job_work_from_home = 1
	GROUP BY
		js.skill_id,
		s.skills
),

average_salary AS
(
	SELECT
		js.skill_id,
		ROUND(AVG(CAST(salary_year_avg as INT)),0) AS avg_salary
	FROM
		jobs j
	JOIN job_skill js ON j.job_id = js.job_id
	JOIN skills s ON js.skill_id = s.skill_id
	WHERE 
		job_title_short = 'Data Analyst'
		AND salary_year_avg IS NOT NULL
		AND job_work_from_home = 1
	GROUP BY
		js.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN  average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE  
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

-- Approach 2
-- rewriting this same query more concisely

SELECT 
    s.skill_id,
    s.skills,
    COUNT(js.job_id) AS demand_count,
    ROUND(AVG(CAST(salary_year_avg as INT)),0) AS avg_salary
FROM jobs j
INNER JOIN job_skill js ON j.job_id = js.job_id
INNER JOIN skills s ON js.skill_id = s.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = 1 
GROUP BY
    s.skill_id
HAVING
    COUNT(js.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/*
Here's a breakdown of the most optimal skills for Data Analysts in 2023: 
High-Demand Programming Languages: 
Python and R stand out for their high demand, with demand counts of 241 and 152 respectively. Despite their high demand, their average salaries are around $101,181 for Python 
and $100,353 for R, indicating that proficiency in these languages is highly valued but also widely available.
Cloud Tools and Technologies: 
Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, 
pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
Business Intelligence and Visualization Tools: 
Tableau and Looker, with demand counts of 238 and 50 respectively, and average salaries around $98,705 and $103,169, highlight the critical role of data visualization 
and business intelligence in deriving actionable insights from data.
Database Technologies: 
The demand for skills in traditional and NoSQL databases (Oracle, SQL, NoSQL) with average salaries ranging from $96,802 to $101,414, 
reflects the enduring need for data storage, retrieval, and management expertise. SQL has the highest demand count of 411 for Data Analyst roles.
*/

