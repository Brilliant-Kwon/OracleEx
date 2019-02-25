--Quiz03
--Q1
SELECT
    MAX(salary) AS "최고임금",
    MIN(salary) AS "최저임금",
    MAX(salary) - MIN(salary) AS "최고임금-최저임금"
FROM
    employees;
    
--Q2

SELECT
    TO_CHAR(MAX(hire_date),'YYYY-MM-DD')
FROM
    employees;
    
--Q3

SELECT
    department_id,
    round(AVG(salary),2),
    MAX(salary),
    MIN(salary)
FROM
    employees
GROUP BY
    department_id
ORDER BY
    department_id DESC;
    
--Q4

SELECT
    job_id,
    round(AVG(salary),2),
    MAX(salary),
    MIN(salary)
FROM
    employees
GROUP BY
    job_id
ORDER BY
    job_id DESC;
    
--Q5

SELECT
    TO_CHAR(MIN(hire_date),'YYYY-MM-DD')
FROM
    employees;

--Q6

SELECT
    department_id,
    round(AVG(salary),2),
    MIN(salary),
    round(AVG(salary),2) - MIN(salary) AS 차액
FROM
    employees
GROUP BY
    department_id
HAVING
    round(AVG(salary),2) - MIN(salary) < 2000
ORDER BY
    round(AVG(salary),2) - MIN(salary) DESC;
    
--Q7

SELECT
    job_title,
    round(AVG(salary),2) - MIN(salary)
FROM
    employees emp join jobs jo on emp.job_id = jo.job_id
GROUP BY
    job_title
ORDER BY
    round(AVG(salary),2) - MIN(salary) DESC;