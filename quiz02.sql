--Quiz02
--Q1
SELECT
    emp.employee_id,
    emp.first_name,
    dept.department_name,
    man.first_name
FROM
    employees emp
    JOIN employees man ON emp.manager_id = man.employee_id
    JOIN departments dept ON emp.department_id = dept.department_id
ORDER BY
    emp.employee_id;
    
--Q2

SELECT
    reg.region_name,
    con.country_name
FROM
    regions reg
    JOIN countries con ON reg.region_id = con.region_id
ORDER BY
    reg.region_name DESC,
    con.country_name DESC;
    
--Q3

SELECT
    dept.department_id,
    dept.department_name,
    man.first_name,
    loc.city,
    con.country_name,
    reg.region_name
FROM
    departments dept
    JOIN locations loc ON dept.location_id = loc.location_id
    JOIN countries con ON loc.country_id = con.country_id
    JOIN regions reg ON con.region_id = reg.region_id
    JOIN employees man ON dept.manager_id = man.employee_id
ORDER BY
    dept.department_id ASC;
    
--Q4

SELECT
    *
FROM
    jobs
WHERE
    job_title = 'Public Accountant';

SELECT
    employee_id
FROM
    job_history
WHERE
    job_id IN (
        SELECT
            job_id
        FROM
            jobs
        WHERE
            job_title = 'Public Accountant'
    );

SELECT
    employee_id,
    concat(first_name,concat(' ',last_name) )
FROM
    employees
WHERE
    employee_id IN (
        SELECT
            employee_id
        FROM
            job_history
        WHERE
            job_id IN (
                SELECT
                    job_id
                FROM
                    jobs
                WHERE
                    job_title = 'Public Accountant'
            )
    );
    
--Q5

SELECT
    employee_id,
    first_name,
    last_name,
    department_name
FROM
    employees emp
    JOIN departments dept ON emp.department_id = dept.department_id
ORDER BY
    last_name ASC;
    
--Q6

SELECT
    emp.employee_id,
    emp.last_name,
    emp.hire_date
FROM
    employees emp
    JOIN employees man ON emp.manager_id = man.employee_id
WHERE
    emp.hire_date < man.hire_date
ORDER BY
    emp.employee_id;