-- What is the overall attrition rate?
SELECT
  COUNT(*) AS headcount,
  SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS attritions,
  CAST(SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS attrition_rate -- Attrotion rate is 0.16.
FROM dbo.HR_Analytics;



-- Query above has attrition rate as a decimal. Query below will show it as a percentage instead.
SELECT
  COUNT(*) AS headcount,
  SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS attritions,
  ROUND(100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate_pct -- Attrition rate is 16 %.
FROM dbo.HR_Analytics;



--What is the attrition rate by department?
SELECT
  Department,
  COUNT(*) AS headcount,
  SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS attritions,
  ROUND(100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate_pct
FROM dbo.HR_Analytics
GROUP BY Department
ORDER BY attrition_rate_pct DESC;
/*By department here are the following attrition rates:
Sales has a 20.67 %
Human Resources 19.05 %
Research & Development 13.75 %
*/


-- What is the attrition rate by JobRole (filtering for smaller groups.
SELECT
  JobRole,
  COUNT(*) AS headcount,
  SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS attritions,
  ROUND(100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate_pct
FROM dbo.HR_Analytics
GROUP BY JobRole
HAVING COUNT(*) >= 20
ORDER BY attrition_rate_pct DESC;
/* Here is the attrition rate for each department
Sales representaive: 39.29 %
Laboratory Technician: 23.75 %
Human resources: 23.08 %
Sales executive: 17.63 %
Research scientist: 16.04 %
Healthcare representative: 6.82 %
Manufacutring Director: 6.8 %
Manager: 4.9 %
*/


-- What is  the impact on Overtime?
SELECT
  OverTime,
  COUNT(*) AS headcount,
  ROUND(100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate_pct
FROM dbo.HR_Analytics
GROUP BY OverTime
ORDER BY attrition_rate_pct DESC;
/*
Employees with overtime has a 30.62 attrition rate.
Employees with no overtime has a 10.36 attrition rate.