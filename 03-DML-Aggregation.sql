---------------------------
--
--------------------------

--count : ���� ����
SELECT
    COUNT(*)
FROM
    employees; -- �� 107��

SELECT
    COUNT(manager_id)
FROM
    employees; -- �Ŵ����� �ִ� ��� 106��

--�հ�� ��� : SUM, AVG
--������� �޿��� ����

SELECT
    SUM(salary)
FROM
    employees;
    
--������� �޿��� ���    

SELECT
    AVG(salary)
FROM
    employees;
    
--����� Ŀ�̼� ������ ���ġ�� ��?    

SELECT
    AVG(commission_pct)
FROM
    employees;
    
--NULL���� �ִ� ���, ���迡�� ����

SELECT
    AVG(nvl(commission_pct,0) )
FROM
    employees;
    
--MIN, MAX, AVG, MEDIAN    

SELECT
    MAX(salary),
    MIN(salary),
    round(AVG(salary),2),
    MEDIAN(salary)
FROM
    employees;
    
--GROUP BY

SELECT
    department_id,
    AVG(salary)
FROM
    employees
GROUP BY
    department_id
ORDER BY
    department_id ASC;

--��� �޿��� 7000�̻��� �μ� ���
--Error �߻�

SELECT
    department_id,
    AVG(salary)
FROM
    employees
WHERE
    AVG(salary) >= 7000
GROUP BY
    department_id;

SELECT
    department_id,
    AVG(salary)
FROM
    employees
GROUP BY
    department_id
HAVING
    AVG(salary) >= 7000 --GROUP BY�� WHERE
ORDER BY
    department_id;
    
------------------
--ROllUP
------------------
--GROUP BY�� �Բ� ���
--�׷� ������ ����� ���� �� ��� ����
--������ ITEM Total ������ ����

SELECT
    department_id,
    job_id,
    SUM(salary)
FROM
    employees
GROUP BY
    ROLLUP(department_id,
    job_id)
ORDER BY
    department_id;
    
-------------------
--CUBE
-------------------
--ũ�ν� �ǿ� ����Summary�� �Բ� ����
--ROLLUP���� �����Ǵ� Item Total ���� �Բ�
--Column Total�� ������ �� ����

SELECT
    department_id,
    job_id,
    SUM(salary)
FROM
    employees
GROUP BY
    CUBE(department_id,
    job_id)
ORDER BY
    department_id;
    
------------------------
--Subquery
----------------------

--salary�� �߾Ӱ��� �̾� �ɴϴ�.

SELECT
    MEDIAN(salary)
FROM
    employees;

--salary �߾Ӱ����� ���� �޿��� �޴� ������ ���

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary > 6200;

--subquery �̿�

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary > (
        SELECT
            MEDIAN(salary)
        FROM
            employees
    )
ORDER BY
    salary DESC;
    
--Susan���� �ʰ� �Ի��� ����� ���

--Susan�� �Ի����� �̾� ���ô�.

SELECT
    hire_date
FROM
    employees
WHERE
    first_name = 'Susan';

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date > '02/06/07';

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date > (
        SELECT
            hire_date
        FROM
            employees
        WHERE
            first_name = 'Susan'
    );
    
--�޿��� �߾Ӱ� �̻��� �ް�,
--�Ի����� Susan���� ���� ����� ���

SELECT
    first_name,
    salary,
    hire_date
FROM
    employees
WHERE
    salary > (
        SELECT
            MEDIAN(salary)
        FROM
            employees
    )
    AND   hire_date > (
        SELECT
            hire_date
        FROM
            employees
        WHERE
            first_name = 'Susan'
    );
    
--������ ���� ����
--���� ���� ���� IN, ANY, ALL, EXISTS ���� �̿��ؾ���.

--department_id = 110�� �μ��� ������� �޿� ���

SELECT
    salary
FROM
    employees
WHERE
    department_id = 110;

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary IN (
        SELECT
            salary
        FROM
            employees
        WHERE
            department_id = 110
    );
    
--department_id = 110�� �μ��� ��� ������ �޿����� ����
--�޿��� �޴� ������ ���

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary > ALL (
        SELECT
            salary
        FROM
            employees
        WHERE
            department_id = 110
    );

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary > ANY (
        SELECT
            salary
        FROM
            employees
        WHERE
            department_id = 110
    ); 
    
----------------------
--Corelated Query
-------------------------
--��� ����� �̾ƿ���
--�ڽ��� ���� �μ��� ��� �޿����� ���� �޴� ������ ���

SELECT
    first_name,
    salary,
    department_id
FROM
    employees outer
WHERE
    salary > (
        SELECT
            AVG(salary)
        FROM
            employees
        WHERE
            department_id = outer.department_id
    );
    
--�������� ��������
--�� �μ����� �ְ� �޿��� �޴� ����� ���(������)

--���� 1 : �� �μ��� �ְ� �޿�

SELECT
    department_id,
    MAX(salary)
FROM
    employees
GROUP BY
    department_id;
    
--���� 2 : ���� 1���� ���� department_id�� salary�� max�� �̿�

SELECT
    department_id,
    employee_id,
    first_name,
    salary
FROM
    employees
WHERE
    ( department_id,
    salary ) IN (
        SELECT
            department_id,
            MAX(salary)
        FROM
            employees
        GROUP BY
            department_id
    )
ORDER BY
    department_id;
    
--���̺� ������ �̿�, �� �μ��� �ְ� �޿��� �޴� ������ ��� ���

SELECT
    emp.department_id,
    emp.employee_id,
    emp.first_name,
    emp.salary
FROM
    employees emp,
    (
        SELECT
            department_id,
            MAX(salary) AS salary
        FROM
            employees
        GROUP BY
            department_id
    ) sal -- sal�̶�� �ӽ� ���̺��� ����
WHERE
    emp.department_id = sal.department_id
    AND   emp.salary = sal.salary
ORDER BY
    emp.department_id ASC;
    
----------------
--TOK - K Query
----------------
--rownum ���� �÷��� �̿�, ���� ����� ������ ��ȯ

--07�� �Ի��� �߿��� ���� ���� 5������ �̾� ���ô�.

SELECT
    ROWNUM,
    first_name,
    salary
FROM
    (  --�� ���̺� ���� ���ϸ� �ο���� �̻��ϰ� ����
        SELECT
            *
        FROM
            employees
        WHERE
            hire_date LIKE '07%'
        ORDER BY
            salary DESC
    )
WHERE
    ROWNUM <= 5;
    
--RANK���� �Լ���

SELECT
    first_name,
    salary,
    RANK() OVER(
        ORDER BY
            salary DESC
    ) AS rank,
    DENSE_RANK() OVER(
        ORDER BY
            salary DESC
    ) AS dense_rank,
    ROW_NUMBER() OVER(
        ORDER BY
            salary DESC
    ) AS row_number,
    ROWNUM
FROM
    employees;
    
-------------------------------
--Hierarchical Query
--------------------------------
--Ʈ�������� ����� ���
--level�̶�� ���� �÷��� �̿� : Ʈ���� ����

SELECT
    level,
    first_name
FROM
    employees
START WITH
    manager_id IS NULL -- ���� ����
CONNECT BY
    PRIOR employee_id = manager_id --���� ����
ORDER BY
    level ASC;
    
--�Ŵ��� �̸����� �Բ� ���

SELECT
    level,
    emp.first_name,
    emp.last_name,
    man.first_name,
    man.last_name
FROM
    employees emp
    LEFT OUTER JOIN employees man ON emp.manager_id = man.employee_id
START WITH
    emp.manager_id IS NULL
CONNECT BY
    PRIOR emp.employee_id = emp.manager_id
ORDER BY
    level ASC;
    
    