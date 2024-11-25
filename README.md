# Introduction
Explore the data job market! Here we are focusing on data analyst roles. This project highlights top-paying data analyst roles, in-demand skills, and where demand meets high salary in data analytics. Check out the SQL queries behind it all: [project_sql folder](/project_sql/)
# Background
Driven by the need to navigate the data analyst job market more effectively, this project was created to identify top-paying roles and in-demand skills, making it easier for others to find optimal opportunities.

The data, sourced from DataNerds, offers rich insights into job titles, salaries, locations, and essential skills, providing a comprehensive view of the market landscape.
### The questions I wanted to answer through my SQL queries were:
1.	What is the top-paying jobs for my role?
2.	What are the skills required for these top-paying roles?
3.	What are the most in-demand skills for my role?
4.	What are the top skills based on salary for my role?
5.	What are the most optimal skills to learn?

# Tools Used
For this deep dive into the data analyst job market, I leveraged the following key tools:

- **SQL**: The backbone of the analysis, enabling efficient querying to uncover critical insights.

- **PostgreSQL**: A robust database management system, perfect for handling and organizing job posting data.

- **Visual Studio Code**: My go-to platform for writing and executing SQL queries and managing the database seamlessly.

- **Git & GitHub**: Essential for version control, collaboration, and sharing SQL scripts and analysis while maintaining project transparency.
# The Analysis
Each query in this project was designed to address a specific aspect of the data analyst job market. Here's how I approached each question to extract meaningful insights:
### 1. Top Paying Data Analyst Jobs
To pinpoint the highest-paying roles, I filtered data analyst positions by average yearly salary and location, with a focus on opportunities that were remote and in Denver, CO. This query sheds light on lucrative opportunities in the field.
```sql
SELECT
    job_id,
    job_title,  
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere'AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;  

--Denver, CO
SELECT
    job_id,
    job_title,  
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Denver, CO' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top 10 data anlyst jobs in 2023:
- **Salary Range:**
Salaries range from $184,000 to $650,000, with an average of $264,506.15. This reflects roles from entry-level to senior leadership, showcasing strong earning potential for data analysts.

- **Employers:**
The dataset features 9 unique employers, including prominent names like Meta, AT&T, and Pinterest, demonstrating demand across various industries.

- **Job Titles:**
There are 10 unique job titles, such as Data Analyst, Director of Analytics, and Associate Director of Data Insights, highlighting opportunities from entry-level to senior leadership roles.

![Top Paying Roles](project_sql\assets\Top_10_jobs_per_salary.png)
*Bar graph visualizing the salary for the top 10 salaries for data analyts; ChatGPT generated from my SQL query results*

## 2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing the skills employers value for the high-compensation roles.

```sql
WITH top_paying_jobs AS (

    SELECT
        job_id,
        job_title,  
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- **SQL:** leads the list with 8 mentions, essential for data management and querying.
- **Python:** follows closely with 7 mentions, key for data analysis and automation.
- **Tableau:** 6 mentions, important for data visualization.
- **R:** 4 mentions, remains a valuable skill for statistical analysis.
- **Snowflake:** 3 mentions, reflecting demand for cloud-based data warehousing.

![Skills for Roles](project_sql\assets\Skill_count.png)
*Bar graph visualizing the top 10 skills for data analyts; ChatGPT generated from my SQL query results*

## 3. In Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand. 
```sql
SELECT
    skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC   
LIMIT 5;	
```


**SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and data manipulation.
Python, Tableau and Power BI are essential programming and visualization tools important for technical skills in data storytelling and decision support.

![In-Demand Skills](project_sql\assets\Top_In_Demand_Skills.png)
*Table of the top 5 skills in data analyt job postings.

## 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are highest paying.
```sql
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
```
Here's a breakdown of the results for top paying skills for Data Analysts:

- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysis skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's hgh valuation of data processing and predictive modeling capabilities.

- **Software Development & Deployment Proficiency: Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between datat analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.


- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that could proficiency significantly boosts earning potential in data analytics.

![Top Skills](project_sql\assets\Top_Skills.png)
*Table of the average salary for the top 25 paying skills for data analysts.

## 5. Most Optimal Skills to Learn

combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have hgh salaries, offering a strtegic focus for skill development.
```sql
SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT (skills_job_dim.job_id) AS demand_count,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND job_work_from_home = True
        AND salary_year_avg IS NOT NULL    
    GROUP BY
        skills_dim.skill_id
    HAVING
        COUNT(skills_job_dim.job_id) >10
    ORDER BY
        avg_salary DESC,
        demand_count DESC
    LIMIT 25;     
```
![Optimal Skills by Salary](project_sql\assets\Optimal_Skills_By_Salary.png)
*Table of the most optimal skills for data analysts sorted by salary.

Here's a breakdown of the most optimal skills for Data Analysts in 2023:

-**High-Demand Programming Languages:** Python and R stand out aned their average salaries are around $101,397 for Python and $100,499 for R.
-** Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high aveagr salaries.
-** Business Intelligence and Visualization Tools: Tableau and Looker, with average salaries around $99,288 and $103,795 for deriving actionable insights from data.
-** Database Technologies:** The demande for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salares from $97,789 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise. 

# What I Learned

For this project I've turbocharged my SQL toolkit with advanced SQL commands:

-**Complex Query Aggregations:** Mastering the art of advanced SQL, merging tables like a pro including WITH clauses.
-**Data Aggregation:** Got comfortable GROUP BY, COUNT () and AVG functions to summarize data.
-**Analytical:** Leveled up my ral-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

### Insights
From the analysis, several general insights emerged:
1. **Top-Paying Data Analyst Jobs:** The highest paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000.
2.**Skills for Top Paying Jobs:** High paying dtata analyst jobs require advanced proficiency in SQL, suggesting it's a criticial skill for earning a top salary.
3.**Most In-Demand Skills:** SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4.**Skills with Higher Salaries:** Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indications a premium on niche expertise.
5.**Optimal Skills for Job Market Vale:** SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to lean to maimize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills.  This exploration highlights the importance of continuous learning and adaptation to emerging trnds in the field of data analytics.