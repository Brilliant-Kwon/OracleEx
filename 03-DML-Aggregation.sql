---------------------------
--
--------------------------

--count : 갯수 세기
SELECT
    COUNT(*)
FROM
    employees; -- 총 107개

SELECT
    COUNT(manager_id)
FROM
    employees; -- 매니저가 있는 사람 106명

--합계와 평균 : SUM, AVG
--사원들의 급여의 총합

SELECT
    SUM(salary)
FROM
    employees;
    
--사원들의 급여의 평균    

SELECT
    AVG(salary)
FROM
    employees;
    
--사원들 커미션 비율의 평균치는 얼마?    

SELECT
    AVG(commission_pct)
FROM
    employees;
    
--NULL값이 있는 경우, 집계에서 제외

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

--평균 급여가 7000이상인 부서 출력
--Error 발생

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
    AVG(salary) >= 7000 --GROUP BY의 WHERE
ORDER BY
    department_id;
    
------------------
--ROllUP
------------------
--GROUP BY와 함께 사용
--그룹 지어진 결과에 대한 상세 요약 제공
--일종의 ITEM Total 정도로 이해

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
--크로스 탭에 대한Summary를 함께 추출
--ROLLUP에서 제공되는 Item Total 값과 함께
--Column Total을 추출할 수 있음

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

--salary의 중앙값을 뽑아 옵니다.

SELECT
    MEDIAN(salary)
FROM
    employees;

--salary 중앙값보다 많은 급여를 받는 직원의 목록

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary > 6200;

--subquery 이용

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
    
--Susan보다 늦게 입사한 사원의 목록

--Susan의 입사일을 뽑아 봅시다.

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
    
--급여를 중앙값 이상을 받고,
--입사일이 Susan보다 늦은 사원의 목록

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
    
--다중행 서브 쿼리
--집합 연산 관련 IN, ANY, ALL, EXISTS 등을 이용해야함.

--department_id = 110인 부서의 사원들의 급여 목록

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
    
--department_id = 110인 부서의 모든 직원들 급여보다 많은
--급여를 받는 직원의 목록

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
--사원 목록을 뽑아오되
--자신이 속한 부서의 평균 급여보다 많이 받는 직원의 목록

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
    
--서브쿼리 연습문제
--각 부서별로 최고 급여를 받는 사원을 출력(조건절)

--쿼리 1 : 각 부서의 최고 급여

SELECT
    department_id,
    MAX(salary)
FROM
    employees
GROUP BY
    department_id;
    
--쿼리 2 : 쿼리 1에서 나온 department_id와 salary의 max값 이용

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
    
--테이블 조인을 이용, 각 부서별 최고 급여를 받는 직원의 목록 출력

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
    ) sal -- sal이라는 임시 테이블을 생성
WHERE
    emp.department_id = sal.department_id
    AND   emp.salary = sal.salary
ORDER BY
    emp.department_id ASC;
    
----------------
--TOK - K Query
----------------
--rownum 수도 컬럼을 이용, 쿼리 결과의 순서를 반환

--07년 입사자 중에서 연봉 순위 5위까지 뽑아 봅시다.

SELECT
    ROWNUM,
    first_name,
    salary
FROM
    (  --새 테이블 선언 안하면 로우넘이 이상하게 나옴
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
    
--RANK관련 함수들

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
--트리형태의 결과값 출력
--level이라는 가상 컬럼을 이용 : 트리의 깊이

SELECT
    level,
    first_name
FROM
    employees
START WITH
    manager_id IS NULL -- 시작 조건
CONNECT BY
    PRIOR employee_id = manager_id --연결 조건
ORDER BY
    level ASC;
    
--매니저 이름까지 함께 출력

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
    
    