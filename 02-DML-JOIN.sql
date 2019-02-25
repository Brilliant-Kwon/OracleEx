--------------------
--JOIN
--------------------
DESC employees;

DESC departments;

SELECT
    first_name,
    department_name
FROM
    employees,
    departments;

SELECT
    *
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;

SELECT
    emp.first_name,
    emp.last_name,
    dept.department_id,
    dept.department_name
FROM
    employees emp,
    departments dept
WHERE
    emp.department_id = dept.department_id;
    
--------------------------
-- INNER JOIN
--------------------------

SELECT
    emp.first_name,
    emp.department_id,
    dept.department_id,
    dept.department_name
FROM
    employees emp,
    departments dept
WHERE
    emp.department_id = dept.department_id; -- 106명

SELECT
    *
FROM
    employees; --107명

SELECT
    *
FROM
    employees
WHERE
    department_id IS NULL; -- 문제의 1명
    
-- ANSI SQL

SELECT
    emp.first_name,
    dept.department_name
FROM
    employees emp
    JOIN departments dept USING ( department_id );


-----------------
--OUTER JOIN
---------------

--LEFT OUTER JOIN

SELECT
    emp.first_name,
    emp.department_id,
    dept.department_id,
    dept.department_name
FROM
    employees emp,
    departments dept
WHERE
    emp.department_id = dept.department_id (+);
    
--ANSI SQL

SELECT
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM
    employees emp
    LEFT OUTER JOIN departments dept ON emp.department_id = dept.department_id;
    
---------------------
--RIGHT OUTER JOIN
---------------------

SELECT
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM
    employees emp,
    departments dept
WHERE
    emp.department_id (+) = dept.department_id;
    
--ANSI

SELECT
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM
    employees emp
    RIGHT OUTER JOIN departments dept ON emp.department_id = dept.department_id;
    
----------------------------
--FULL OUTER JOIN
----------------------------
--※안됨 -> ANSI를 사용할 것

SELECT
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM
    employees emp,
    departments dept
WHERE
    emp.department_id (+) = dept.department_id (+);
    
--ANSI

SELECT
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM
    employees emp
    FULL OUTER JOIN departments dept ON emp.department_id = dept.department_id;

-------------------
--SELF JOIN
---------------------

SELECT
    *
FROM
    employees; --총 107명의 직원

SELECT
    emp.employee_id,
    emp.first_name,
    emp.last_name,
    man.first_name,
    man.last_name
FROM
    employees emp,
    employees man
WHERE
    emp.manager_id = man.employee_id; -- 106명의 직원

SELECT
    emp.employee_id,
    emp.first_name,
    emp.last_name,
    man.first_name,
    man.last_name
FROM
    employees emp
    JOIN employees man ON emp.manager_id = man.employee_id; --사장빼고 106명
    
--사장 포함 시켜보기
--OUTER JOIN 사용

SELECT
    emp.employee_id,
    emp.first_name,
    emp.last_name,
    man.first_name,
    man.last_name
FROM
    employees emp
    LEFT OUTER JOIN employees man ON emp.manager_id = man.employee_id; -- 사장 포함 107명
    
    
    