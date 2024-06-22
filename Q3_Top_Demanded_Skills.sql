/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

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

/*
Here's the breakdown of the most demanded skills for data analysts in 2023:

-- SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
-- Programming and Visualization Tools like Python, R and Tableau are essential, pointing towards the increasing importance of technical skills 
   in data storytelling and decision support.
*/