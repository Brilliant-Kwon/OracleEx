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

--특정 컬럼의 출력

--사원의 이름(first_name), 전화번호, 입사일, 급여를 출력

SELECT
    first_name,
    phone_number,
    hire_date,
    salary
FROM
    employees;

--산술 연산

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

DESC employees; --job_id는 가변 문자이므로 안됨을 확인할 수 있다.

--employees 테이블에서 커미션까지 포함해서 급여를 계산

SELECT
    first_name,
    salary,
    commission_pct,
    salary + salary * commission_pct
FROM
    employees;
    
--수정: null값을 0으로 바꿔 계산해 봅시다.

SELECT
    first_name,
    salary,
    commission_pct,
    salary + salary * nvl(commission_pct,0)
FROM
    employees;
    
--사원의 이름, 전화번호, 급여를 추출하되 별명을 붙여 출력

SELECT
    first_name
    || ' '
    || last_name AS 이름,
    phone_number AS 전화번호,
    salary 급여,
    hire_date "입사 날짜"
FROM
    employees;
    
------------
--WHERE
------------

--급여가 15000 이상인 사원의 목록

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary >= 15000;

--입사일이 07/01/01 이후인 사원들의 이름과 입사일 출력

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date >= '07/01/01';

--이름이 Lex인 직원의 이름, 급여, 입사일 출력

SELECT
    first_name,
    salary,
    hire_date
FROM
    employees
WHERE
    first_name = 'Lex';

--급여가 14000이상, 17000미만인 사원의 이름, 급여 출력

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary >= 14000
    AND   salary < 17000;

--위와 같은 조건으로 BETWEEN 출력

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary BETWEEN 14000 AND 17000;

-- 커미션을 받지 않는 사원의 목록 (commission_pct 가 null)

SELECT
    first_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct IS NULL;

--담당 매니저가 없고, 커미션 비율이 없는 사람들

SELECT
    first_name,
    manager_id,
    commission_pct
FROM
    employees
WHERE
    manager_id IS NULL
    AND   commission_pct IS NULL;

--부서 아이디가 10,20,40에 속해 있는 사원

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
-- % : 여러 개의 정해지지 않은 문자열
-- _ : 정해지지 않은 1개의 문자

-- 이름에 am을 포함하고 있는 사원의 이름과 급여를 출력

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    first_name LIKE '%am%';

--이름의 두번째 글자가 a인 사원

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    first_name LIKE '_a%';

-------
--ORDER BY : 정렬
-------

--사원 목록에서 부서번호 오름차순 정렬 이름, 부서번호, 급여 출력

SELECT
    first_name,
    department_id,
    salary
FROM
    employees
ORDER BY
    department_id; -- 기본은 ASC (오름차순 정렬)

-- 급여가 15000 이하인 사원들 목록을 급여의 역순으로 정렬 출력

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary <= 15000
ORDER BY
    salary DESC;

-- 사원 목록을 부서번호를 오름차순으로
-- 2차로 급여의 내림차순 이름, 부서번호, 급여 순으로 출력

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
--단일행 함수
---------------------

--문자열 단일행 함수

SELECT
    first_name,
    last_name,
    concat(first_name,concat(' ',last_name) ), --연결 
    lower(first_name),--소문자변환
    upper(first_name),--대문자변환
    lpad(first_name,20,'*'),--빈자리 채우기
    rpad(first_name,20,'*')
FROM
    employees;
    
--last_name에 a가 포함된 사원의 목록

SELECT
    first_name,
    last_name
FROM
    employees
WHERE
    last_name LIKE '%a%'; -- Alex걸리지 않음

SELECT
    first_name,
    last_name
FROM
    employees
WHERE
    lower(last_name) LIKE '%a%';
    
--공백 제거 및 슬라이싱

SELECT
    ltrim('       Oracle     '), -- 공백문자 제거
    rtrim('       Oracle     '),
    TRIM('       Oracle     '),
    TRIM('#' FROM '#####Oracle#####'), -- TRIM 문자 지정
    substr('Oracle Database',8,4), -- 8번째글자 ~ 4글자 출력
    substr('Oracle Database',-8,8), --역인덱스
    length('Oracle Database')--길이
FROM
    dual;
    
--수치형 단일행 함수

SELECT
    ceil(3.14), --소수점 올림
    floor(3.14),--소수점 버림
    mod(7,4), --나머지 구하기
    power(2,4), --제곱
    round(3.5), --소수점 반올림
    round(3.14159,3), --소수점 4번째 자리에서 반올림해서 3번째까지 출력
    trunc(3.5),--소수점 버림
    trunc(3.14159,3)--소수점 3번째 자리까지 표현 반올림 x
FROM
    dual;
-----------------
--Quiz
-----------------

--Quiz01    

SELECT
    concat(first_name,concat(' ',last_name) ) AS 이름,
    salary AS 급여,
    phone_number AS 전화번호,
    hire_date AS 입사일
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
--Oracle의 날짜 출력 포맷

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

--현재 날짜를 알아와 봅시다 : sysdate

SELECT
    SYSDATE
FROM
    dual; -- 값이 한개

SELECT
    SYSDATE
FROM
    employees; --테이블 내 ROW 수 만큼

-- 현재 날짜를 기준으로, 입사한지 몇 개월이 지났는지 확인

SELECT
    first_name,
    hire_date,
    months_between(SYSDATE,hire_date)
FROM
    employees
ORDER BY
    hire_date ASC;

--Date 관련 함수들

SELECT
    SYSDATE, -- 현재 날짜와 시간
    add_months(SYSDATE,2), -- 현재 날짜에 2 개월 후
    last_day(SYSDATE), --현재 날짜의 달의 마지막 날
    months_between(TO_DATE('2012-09-24','YYYY-MM-DD'),SYSDATE),
    next_day(SYSDATE,7), --현재 날짜  7일 후
    round(SYSDATE,'MONTH'),
    trunc(SYSDATE,'MONTH')
FROM
    dual;
    
    ------------
--변환 함수
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
    employees; -- 숫자 -> 문자
    
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
    
--날짜 연산
--Date + (-) Number : 날짜에 일수 더하기(빼기) -> Date
--Date - Date : 두 날짜의 차이 일수 -> Number
--Date  +(-) Number / 24 : 날짜에 시간을 더하기(빼기) ->Date

SELECT
    TO_CHAR(SYSDATE,'YY/MM/DD HH24:MI'),
    SYSDATE + 1,--하루 뒤
    SYSDATE - 1,--하루 전
    SYSDATE - TO_DATE('20120924'), --두 날짜의 차이 일수
    SYSDATE - 13 / 24
FROM
    dual;    


-------------
--NULL 관련
-------------

--NVL 함수

SELECT
    first_name,
    salary,
    salary * nvl(commission_pct,0) commission --commission은 별명임(AS 생략)
FROM
    employees
ORDER BY
    commission DESC;
    
--NVL2 함수

SELECT
    first_name,
    salary,
    nvl2(commission_pct,salary * commission_pct,0) commission --NULL이 아니면 2번째칸, NULL이면 3번째칸 수행
FROM
    employees
ORDER BY
    commission DESC;
    
--CASE Function
--보너스 지급
--job_id AD  -> 20%, SA -> 10%, IT -> 8%, 나머지 -> 5%

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
    
--연습문제
--department_id : 10 ~ 30 -> A-GROUP
--department_id : 40 ~ 50 -> B-GROUP
--department_id : 60 ~ 100 -> C-GROUP
--나머지 : REMainder
--team 이름으로 출력하고 소팅

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