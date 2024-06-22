-- Query 1:

/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

-- Approach 1:

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

-- Approach 2:

WITH TopDataAnalystJobs AS (
    SELECT
        job_id,
        company_id,
        salary_year_avg
    FROM
        jobs
    WHERE
        salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
        AND job_title_short = 'Data Analyst'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT 
	j.job_id,
	j.job_title,
	j.job_location,
	j.job_schedule_type,
    tda.salary_year_avg,
	j.job_posted_date,
	c.name AS company_name
FROM
    companies c
JOIN 
    TopDataAnalystJobs tda ON c.company_id = tda.company_id
JOIN
    jobs j ON tda.job_id = j.job_id
ORDER BY
    tda.salary_year_avg DESC;
	
/*Here's the breakdown of the top data analyst jobs in 2023:

Wide Salary Range: Top 10 paying data analyst roles span from $152,625 to $650,000, indicating significant salary potential in the field.
Diverse Employers: Big Companies are offering high salaries, showing a broad interest across different industries.
Job Title Variety: There's a high diversity in job titles, from Data Analyst to Principal Data Analyst, reflecting varied roles and specializations within data analytics.	