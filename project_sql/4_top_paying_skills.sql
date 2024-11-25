/*
Answer: What are the top skills based on salary?
-Look at the avg salary associated with each skill for Data Analyst positions
-Focuses on roles with specified salaries, regardless of location
-Why? It reveals how different skills impact salary levels for Data Analysts and
    helps identify the most financially rewarding skills to acquire or improve
*/


SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    avg_salary DESC   
LIMIT 25;

/*
Quick Insights into Top-Paying Skills for Data Analysts
High-Tech Tools and Platforms Dominate:

Skills like PySpark (avg. salary $208,172), Databricks ($141,907), and Couchbase ($160,515) highlight the demand for big data processing and modern data platforms.
Programming and Frameworks:

Languages and libraries such as Swift ($153,750), Golang ($145,000), and NumPy ($143,513) reflect a trend towards multi-functional programming expertise.
Python libraries like Pandas ($151,821) and Scikit-learn ($125,781) emphasize the relevance of machine learning and data manipulation.
Cloud and DevOps Skills:

Tools like Kubernetes ($132,500), Airflow ($126,103), and GCP ($122,500) underline the importance of cloud orchestration and workflow automation.
BI and Visualization:

MicroStrategy ($121,619) and other business intelligence tools are featured, showing their critical role in turning data into insights.
Collaboration and Version Control:

Skills like GitLab ($154,500), Jupyter ($152,777), and Bitbucket ($189,155) emphasize the increasing demand for collaborative and version-controlled workflows.
General Trends:
Big Data & Cloud: High salaries are linked to expertise in handling and orchestrating massive data systems.
Specialized Tools: Mastery of niche tools like Watson and DataRobot is well-compensated.
Cross-Disciplinary Skills: Combining programming, data engineering, and machine learning expertise drives top salaries.
*/