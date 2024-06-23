# SQL_Project_Data_Job_Analysis
This comprehensive analysis brings forward insights from the 2023 Data Analyst Jobs 
# Introduction

📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.
🔍 SQL queries? Check them out here: [SQL_Project_Data_Job_Analysis]() 

# Background

Driven to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others' work to find optimal jobs.

Data hails from Mr. Luke Barousse's [SQL Course](https://www.lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

## The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

**SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.

**PostgreSQL:** The chosen database management system, ideal for handling the job posting data.

**Pg Admin 4:** My go-to for database management and executing SQL queries.

**GitHub:** Essential for sharing my SQL scripts and analysis.

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

## 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

``` sql
SELECT
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
	name AS company_name
FROM
	jobs
LEFT JOIN companies ON jobs.company_id = companies.company_id
WHERE
	salary_year_avg IS NOT NULL
	AND job_location = 'Anywhere'
    AND job_title_short = 'Data Analyst'
ORDER BY
	salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:

**Wide Salary Range**: Top 10 paying data analyst roles span from $152,625 to $650,000, indicating significant salary potential in the field.

**Diverse Employers**: Big Companies are offering high salaries, showing a broad interest across different industries.

**Job Title Variety**: There's a high diversity in job titles, from Data Analyst to Principal Data Analyst, reflecting varied roles and specializations within data analytics.

![Q1](https://github.com/Ankan2508/SQL_Project_Data_Job_Analysis/assets/140300290/5f818080-dddd-455a-9a94-bfd437b66214)


## 2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH TopDataAnalystJobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
		name AS company_name
    FROM
        jobs
	LEFT JOIN companies ON jobs.company_id = companies.company_id
    WHERE
        salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
        AND job_title_short = 'Data Analyst'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT 
	tda.*,
	skills
FROM
	TopDataAnalystJobs tda
JOIN job_skill js ON tda.job_id = js.job_id
JOIN skills ON js.skill_id = skills.skill_id
ORDER BY
	salary_year_avg DESC;
```
Insights

**Most In-Demand Skills:**

SQL is the most in-demand skill, appearing in 7 out of the 10 top-paying data analyst job postings.
Tableau is the second most mentioned skill, appearing 4 times.

**Programming Languages:**

Python is a highly sought-after programming language, with 3 mentions.
Other programming languages like Java, R, Scala, and C++ also appear but less frequently.

**Data Tools:**

Visualization tools like Tableau, Looker, and Power BI are commonly required.
Data storage and processing tools such as Hadoop, Snowflake, Redshift, and Databricks are also valued.

**General Tools and Platforms:**

Tools like Excel and Git are essential.

**Collaboration tools** like Atlassian, Jira, and Confluence are also mentioned, indicating the importance of teamwork and project management skills.

![Q2_image](https://github.com/Ankan2508/SQL_Project_Data_Job_Analysis/assets/140300290/81cb765d-8214-4cc7-a8d2-70da7d623e79)

# 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql

SELECT 
	skills.skills,
	COUNT(j.job_id) AS no_of_postings
FROM jobs j
JOIN job_skill js ON j.job_id = js.job_id
JOIN skills ON js.skill_id = skills.skill_id
WHERE 
	job_title_short = 'Data Analyst' AND
	job_work_from_home = 1
GROUP BY
	skills
ORDER BY
	no_of_postings DESC
LIMIT 5;

```
Here's the breakdown of the most demanded skills for data analysts in 2023:

**SQL** and **Excel** remain fundamental, emphasizing the need for **strong foundational skills** in **data processing** and **spreadsheet manipulation**.

**Programming and Visualization Tool**s like **Python, R and Tableau** are essential, pointing towards the increasing importance of technical skills in **data storytelling and decision support**.

# 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql

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

```

Here's a breakdown of the results for top paying skills for Data Analysts:
### High Demand for Big Data & ML Skills: 
  
Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.

### Software Development & Deployment Proficiency: 
  
Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.

### Cloud Computing Expertise: 

Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

# 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

### Approach 1 using Q3 and Q4

```sql
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

```

### Approach 2

### rewriting this same query more concisely

```sql

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

```
Here's a breakdown of the most optimal skills for Data Analysts in 2023: 

### High-Demand Programming Languages: 

**Python and R** stand out for their **high demand**, with demand counts of 241 and 152 respectively. Despite their high demand, their average salaries are around $101,181 for Python and $100,353 for R, indicating that **proficiency in these languages is highly valued but also widely available**.

### Cloud Tools and Technologies: 

Skills in specialized technologies such as **Snowflake, Azure, AWS, and BigQuery** show **significant demand with relatively high average salaries**, pointing towards the **growing importance of cloud platforms and big data technologies** in data analysis.

### Business Intelligence and Visualization Tools: 

**Tableau and Looker**, with demand counts of 238 and 50 respectively, and average salaries around $98,705 and $103,169, highlight the **critical role of data visualization and business intelligence** in deriving actionable insights from data.

### Database Technologies: 

The demand for skills in **traditional and NoSQL databases (Oracle, SQL, NoSQL)** with average salaries ranging from $96,802 to $101,414, reflects the **enduring need for data storage, retrieval, and management expertise**. **SQL** has the **highest demand count** of 411 for Data Analyst roles.

# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

🧩 **Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.

📊 **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.

💡 **Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

## Insights

From the analysis, several general insights emerged:

### Top-Paying Data Analyst Jobs: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!

### Skills for Top-Paying Jobs: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.

### Most In-Demand Skills: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.

### Skills with Higher Salaries: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.

### Optimal Skills for Job Market Value: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

# Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
































