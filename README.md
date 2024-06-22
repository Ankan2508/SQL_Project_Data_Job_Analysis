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
