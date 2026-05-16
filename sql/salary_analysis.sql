CREATE DATABASE sample;
use sample;
desc employee;
select * from employee;
SELECT 
    education_level,
    ROUND(AVG(Monthly_Salary), 2) AS avg_salary
FROM employee
GROUP BY education_level
ORDER BY avg_salary desc;

SELECT 
    education_level,
    ROUND(AVG(experience_years), 1) AS avg_experience,
    ROUND(AVG(Monthly_Salary), 2) AS avg_salary
FROM employee
GROUP BY education_level
ORDER BY avg_salary DESC;

SELECT
    education_level,
    experience_level,
    ROUND(AVG(Monthly_Salary), 2) AS avg_salary
FROM (
    SELECT
        education_level,
        CASE
            WHEN experience_years <= 3 THEN 'Low'
            WHEN experience_years BETWEEN 4 AND 8 THEN 'Medium'
            ELSE 'High'
        END AS experience_level,
        Monthly_Salary
    FROM employee
) t
GROUP BY education_level, experience_level
ORDER BY
    FIELD(education_level,
          'High School',
          'Bachelor',
          'Master',
          'PhD'),
    FIELD(experience_level,
          'Low',
          'Medium',
          'High');
SELECT FIELD('PhD', 'High School', 'Bachelor', 'Master', 'PhD');
SELECT
    department,
    experience_level,
    ROUND(AVG(Monthly_Salary), 2) AS avg_salary
FROM (
    SELECT
         department,
        CASE
            WHEN experience_years <= 3 THEN 'Low'
            WHEN experience_years BETWEEN 4 AND 8 THEN 'Medium'
            ELSE 'High'
        END AS experience_level,
        Monthly_Salary
    FROM employee
) t
GROUP BY department,experience_level
ORDER BY
	field(department,'IT','HR','Marketing','Operation','Finance'),
	FIELD(experience_level,'Low','Medium','High');

SELECT department,
       ROUND(AVG(Monthly_salary),2) AS avg_salary
FROM employee
GROUP BY department;

SELECT CASE
WHEN experience_years <= 3 THEN 'Low'
WHEN experience_years BETWEEN 4 AND 8 THEN 'Medium'
ELSE 'High'
END AS experience_level,
ROUND(AVG(Monthly_Salary),2) AS avg_salary
FROM employee
GROUP BY experience_level
ORDER BY 
FIELD(experience_level,'Low','Medium','High'); 

SELECT education_level,ROUND(AVG(Monthly_Salary),2) AS avg_salary
FROM employee
GROUP BY education_level
ORDER BY 
FIELD(education_level,'High School','Bachelor','Master','PhD'); 

SELECT education_level,
CASE
WHEN experience_years <= 3 THEN 'Low'
WHEN experience_years BETWEEN 4 AND 8 THEN 'Medium'
ELSE 'High'
END AS experience_level,
department,
ROUND(AVG(Monthly_Salary),2) AS avg_salary
FROM employee
GROUP BY 
education_level,experience_level,department;   

SELECT department,
       MIN(Monthly_Salary) AS min_salary,
       MAX(Monthly_Salary) AS max_salary,
       ROUND(AVG(Monthly_Salary),2) AS avg_salary
FROM employee
GROUP BY department;

SELECT gender,
       ROUND(AVG(Monthly_Salary),2) AS avg_salary
FROM employee
GROUP BY gender;

SELECT gender,department,
       ROUND(AVG(Monthly_Salary),2) AS avg_salary
FROM employee
GROUP BY gender,department;

SELECT
  CASE
WHEN experience_years <= 3 THEN 'Low'
WHEN experience_years BETWEEN 4 AND 8 THEN 'Medium'
ELSE 'High'
END AS experience_level,
  AVG(monthly_salary) -
  LAG(AVG(monthly_salary)) OVER (ORDER BY FIELD(experience_level,'Low','Medium','High')) AS salary_growth
FROM employee
GROUP BY experience_level;

SELECT
  department,
  MAX(monthly_salary) - MIN(monthly_salary) AS salary_gap
FROM employee
GROUP BY department;
