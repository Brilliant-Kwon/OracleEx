-- DML : SELECT

-- SELECT ~ FROM
SELECT
    *
FROM
    employees;

SELECT
    *
FROM
    departments;

--Ư�� �÷��� ���

--����� �̸�(first_name), ��ȭ��ȣ, �Ի���, �޿��� ���

SELECT
    first_name,
    phone_number,
    hire_date,
    salary
FROM
    employees;

--��� ����

SELECT
    3.14159 * 10 * 10
FROM
    dual;

SELECT
    first_name,
    salary,
    salary * 12
FROM
    employees;

SELECT
    first_name,
    job_id * 12
FROM
    employees;

DESC employees; --job_id�� ���� �����̹Ƿ� �ȵ��� Ȯ���� �� �ִ�.

--employees ���̺��� Ŀ�̼Ǳ��� �����ؼ� �޿��� ���

SELECT
    first_name,
    salary,
    commission_pct,
    salary + salary * commission_pct
FROM
    employees;
    
--����: null���� 0���� �ٲ� ����� ���ô�.

SELECT
    first_name,
    salary,
    commission_pct,
    salary + salary * nvl(commission_pct,0)
FROM
    employees;
    
--����� �̸�, ��ȭ��ȣ, �޿��� �����ϵ� ������ �ٿ� ���

SELECT
    first_name
    || ' '
    || last_name AS �̸�,
    phone_number AS ��ȭ��ȣ,
    salary �޿�,
    hire_date "�Ի� ��¥"
FROM
    employees;
    
------------
--WHERE
------------

--�޿��� 15000 �̻��� ����� ���

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary >= 15000;

--�Ի����� 07/01/01 ������ ������� �̸��� �Ի��� ���

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date >= '07/01/01';

--�̸��� Lex�� ������ �̸�, �޿�, �Ի��� ���

SELECT
    first_name,
    salary,
    hire_date
FROM
    employees
WHERE
    first_name = 'Lex';

--�޿��� 14000�̻�, 17000�̸��� ����� �̸�, �޿� ���

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary >= 14000
    AND   salary < 17000;

--���� ���� �������� BETWEEN ���

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary BETWEEN 14000 AND 17000;

-- Ŀ�̼��� ���� �ʴ� ����� ��� (commission_pct �� null)

SELECT
    first_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct IS NULL;

--��� �Ŵ����� ����, Ŀ�̼� ������ ���� �����

SELECT
    first_name,
    manager_id,
    commission_pct
FROM
    employees
WHERE
    manager_id IS NULL
    AND   commission_pct IS NULL;

--�μ� ���̵� 10,20,40�� ���� �ִ� ���

SELECT
    first_name,
    department_id
FROM
    employees
WHERE
    department_id IN (
        10,
        20,
        40
    );

--LIKE
-- % : ���� ���� �������� ���� ���ڿ�
-- _ : �������� ���� 1���� ����

-- �̸��� am�� �����ϰ� �ִ� ����� �̸��� �޿��� ���

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    first_name LIKE '%am%';

--�̸��� �ι�° ���ڰ� a�� ���

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    first_name LIKE '_a%';

-------
--ORDER BY : ����
-------

--��� ��Ͽ��� �μ���ȣ �������� ���� �̸�, �μ���ȣ, �޿� ���

SELECT
    first_name,
    department_id,
    salary
FROM
    employees
ORDER BY
    department_id; -- �⺻�� ASC (�������� ����)

-- �޿��� 15000 ������ ����� ����� �޿��� �������� ���� ���

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary <= 15000
ORDER BY
    salary DESC;

-- ��� ����� �μ���ȣ�� ������������
-- 2���� �޿��� �������� �̸�, �μ���ȣ, �޿� ������ ���

SELECT
    first_name,
    department_id,
    salary
FROM
    employees
ORDER BY
    department_id,
    salary DESC;

------------------------
--������ �Լ�
---------------------

--���ڿ� ������ �Լ�

SELECT
    first_name,
    last_name,
    concat(first_name,concat(' ',last_name) ), --���� 
    lower(first_name),--�ҹ��ں�ȯ
    upper(first_name),--�빮�ں�ȯ
    lpad(first_name,20,'*'),--���ڸ� ä���
    rpad(first_name,20,'*')
FROM
    employees;
    
--last_name�� a�� ���Ե� ����� ���

SELECT
    first_name,
    last_name
FROM
    employees
WHERE
    last_name LIKE '%a%'; -- Alex�ɸ��� ����

SELECT
    first_name,
    last_name
FROM
    employees
WHERE
    lower(last_name) LIKE '%a%';
    
--���� ���� �� �����̽�

SELECT
    ltrim('       Oracle     '), -- ���鹮�� ����
    rtrim('       Oracle     '),
    TRIM('       Oracle     '),
    TRIM('#' FROM '#####Oracle#####'), -- TRIM ���� ����
    substr('Oracle Database',8,4), -- 8��°���� ~ 4���� ���
    substr('Oracle Database',-8,8), --���ε���
    length('Oracle Database')--����
FROM
    dual;
    
--��ġ�� ������ �Լ�

SELECT
    ceil(3.14), --�Ҽ��� �ø�
    floor(3.14),--�Ҽ��� ����
    mod(7,4), --������ ���ϱ�
    power(2,4), --����
    round(3.5), --�Ҽ��� �ݿø�
    round(3.14159,3), --�Ҽ��� 4��° �ڸ����� �ݿø��ؼ� 3��°���� ���
    trunc(3.5),--�Ҽ��� ����
    trunc(3.14159,3)--�Ҽ��� 3��° �ڸ����� ǥ�� �ݿø� x
FROM
    dual;
-----------------
--Quiz
-----------------

--Quiz01    

SELECT
    concat(first_name,concat(' ',last_name) ) AS �̸�,
    salary AS �޿�,
    phone_number AS ��ȭ��ȣ,
    hire_date AS �Ի���
FROM
    employees;
    
--Quiz02

SELECT
    job_title,
    max_salary
FROM
    jobs
ORDER BY
    max_salary DESC;
    
--Quiz03

SELECT
    concat(first_name,concat(' ',last_name) ),
    manager_id,
    commission_pct,
    salary
FROM
    employees
WHERE
    manager_id IS NOT NULL
    AND   commission_pct IS NULL
    AND   salary >= 3000;
    
--Quiz04

SELECT
    job_title,
    max_salary
FROM
    jobs
WHERE
    max_salary >= 10000
ORDER BY
    max_salary DESC;
    
--Quiz05

SELECT
    first_name,
    salary,
    nvl(commission_pct,0)
FROM
    employees
WHERE
    salary BETWEEN 10000 AND 13999
ORDER BY
    commission_pct DESC;
    
--Quiz06

SELECT
    *
FROM
    departments
ORDER BY
    length(department_name) DESC;
    
--Quiz07

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    first_name LIKE '%s%'
    OR   first_name LIKE '%S%';
    
--Quiz08

SELECT
    upper(country_name)
FROM
    countries
WHERE
    region_id IS NOT NULL
ORDER BY
    upper(country_name) DESC;
    
--Quiz09

SELECT
    concat(first_name,concat(' ',last_name) ),
    salary,
    phone_number,
    hire_date
FROM
    employees
WHERE
    hire_date <= '03/12/31';
    
-----------------------    
-----------------------
--Oracle�� ��¥ ��� ����

SELECT
    *
FROM
    nls_session_parameters;

SELECT
    value
FROM
    nls_session_parameters
WHERE
    parameter = 'NLS_DATE_FORMAT';

--���� ��¥�� �˾ƿ� ���ô� : sysdate

SELECT
    SYSDATE
FROM
    dual; -- ���� �Ѱ�

SELECT
    SYSDATE
FROM
    employees; --���̺� �� ROW �� ��ŭ

-- ���� ��¥�� ��������, �Ի����� �� ������ �������� Ȯ��

SELECT
    first_name,
    hire_date,
    months_between(SYSDATE,hire_date)
FROM
    employees
ORDER BY
    hire_date ASC;

--Date ���� �Լ���

SELECT
    SYSDATE, -- ���� ��¥�� �ð�
    add_months(SYSDATE,2), -- ���� ��¥�� 2 ���� ��
    last_day(SYSDATE), --���� ��¥�� ���� ������ ��
    months_between(TO_DATE('2012-09-24','YYYY-MM-DD'),SYSDATE),
    next_day(SYSDATE,7), --���� ��¥  7�� ��
    round(SYSDATE,'MONTH'),
    trunc(SYSDATE,'MONTH')
FROM
    dual;
    
    ------------
--��ȯ �Լ�
----------------

--TO_NUMBER(n, fmt)
--TO_CHAR(n, fmt)
--TO_DATE(n, fmt)

--TO_CHAR

SELECT
    first_name,
    hire_date,
    TO_CHAR(hire_date,'YYYY-MM-DD HH24:MI:SS')
FROM
    employees;

SELECT
    first_name,
    salary,
    TO_CHAR(salary,'$999,999.99')
FROM
    employees; -- ���� -> ����
    
--TO_NUMBER

SELECT
    to_number('2019'),
    to_number('$24,000.00','$999,999.99')
FROM
    dual;

--TO_DATE

SELECT
    TO_DATE('2014-09-24 14:30','YYYY-MM-DD HH24:MI')
FROM
    dual;
    
--��¥ ����
--Date + (-) Number : ��¥�� �ϼ� ���ϱ�(����) -> Date
--Date - Date : �� ��¥�� ���� �ϼ� -> Number
--Date  +(-) Number / 24 : ��¥�� �ð��� ���ϱ�(����) ->Date

SELECT
    TO_CHAR(SYSDATE,'YY/MM/DD HH24:MI'),
    SYSDATE + 1,--�Ϸ� ��
    SYSDATE - 1,--�Ϸ� ��
    SYSDATE - TO_DATE('20120924'), --�� ��¥�� ���� �ϼ�
    SYSDATE - 13 / 24
FROM
    dual;    


-------------
--NULL ����
-------------

--NVL �Լ�

SELECT
    first_name,
    salary,
    salary * nvl(commission_pct,0) commission --commission�� ������(AS ����)
FROM
    employees
ORDER BY
    commission DESC;
    
--NVL2 �Լ�

SELECT
    first_name,
    salary,
    nvl2(commission_pct,salary * commission_pct,0) commission --NULL�� �ƴϸ� 2��°ĭ, NULL�̸� 3��°ĭ ����
FROM
    employees
ORDER BY
    commission DESC;
    
--CASE Function
--���ʽ� ����
--job_id AD  -> 20%, SA -> 10%, IT -> 8%, ������ -> 5%

SELECT
    first_name,
    job_id,
    salary,
    substr(job_id,1,2),
    CASE substr(job_id,1,2)
            WHEN 'AD'   THEN salary * 0.2
            WHEN 'SA'   THEN salary * 0.1
            WHEN 'IT'   THEN salary * 0.08
            ELSE salary * 0.05
        END
    AS bonus
FROM
    employees;
    
--DECODE Function

SELECT
    first_name,
    job_id,
    salary,
    substr(job_id,1,2),
    DECODE(substr(job_id,1,2),'AD',salary * 0.2,'SA',salary * 0.1,'IT',salary * 0.08,salary * 0.05) AS bonus
FROM
    employees;
    
--��������
--department_id : 10 ~ 30 -> A-GROUP
--department_id : 40 ~ 50 -> B-GROUP
--department_id : 60 ~ 100 -> C-GROUP
--������ : REMainder
--team �̸����� ����ϰ� ����

SELECT
    first_name,
    department_id,
    CASE
            WHEN department_id <= 30  THEN 'A-GROUP'
            WHEN department_id <= 50  THEN 'B-GROUP'
            WHEN department_id <= 100 THEN 'C-GROUP'
            ELSE 'REMAINDER'
        END
    team
FROM
    employees
ORDER BY
    team ASC;