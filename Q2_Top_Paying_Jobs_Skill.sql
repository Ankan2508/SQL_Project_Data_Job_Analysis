/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/

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
	
/*
Insights

Most In-Demand Skills:

SQL is the most in-demand skill, appearing in 7 out of the 10 top-paying data analyst job postings.
Tableau is the second most mentioned skill, appearing 4 times.

Programming Languages:

Python is a highly sought-after programming language, with 3 mentions.
Other programming languages like Java, R, Scala, and C++ also appear but less frequently.

Data Tools:

Visualization tools like Tableau, Looker, and Power BI are commonly required.
Data storage and processing tools such as Hadoop, Snowflake, Redshift, and Databricks are also valued.

General Tools and Platforms:

Tools like Excel and Git are essential.

Collaboration tools like Atlassian, Jira, and Confluence are also mentioned, indicating the importance of teamwork and project management skills.
*/