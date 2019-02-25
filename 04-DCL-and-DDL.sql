-----------------
--DCL 
-----------------

--system 계정 혹은 sys 계정으로 수행
--사용자 생성
--username biuser, password bituser
CONN system / manager -- 권한 부여

CREATE USER bituser IDENTIFIED BY bituser; -- 권한 있어야 함

--사용자 관련 정보 확인

CONN hr / hr

SELECT
    *
FROM
    user_users; -- 현재 사용자 확인

SELECT
    *
FROM
    all_users; -- 모든 사용자 정보 확인

SELECT
    *
FROM
    dba_users; -- 모든 사용자 상세정보 (DBA전용)

SELECT
    username,
    account_status
FROM
    dba_users
WHERE
    username = 'hr';
    
--로그인 권한 부여 ( system 계정으로 수행)

GRANT
    CREATE SESSION
TO bituser;
--connect, resource 롤 부여하면 일반 db 사용자를 만들 수 있다.

GRANT connect,resource TO bituser;
--bituser에게 hr.employees와 departments 테이블 SELECT권한 부여

GRANT CREATE SEQUENCE TO bituser;

GRANT SELECT ON hr.employees TO bituser;

GRANT SELECT ON hr.departments TO bituser;

--현재 사용자에게 부여된 ROLE 조회

SHOW USER

SELECT
    *
FROM
    user_role_privs;

--RESOURCE ROLE 안에 부여된 세부 PRIVILEGE들 확인

SELECT
    privilege
FROM
    role_sys_privs
WHERE
    role = 'RESOURCE';

SELECT
    privilege
FROM
    role_sys_privs
WHERE
    role = 'CONNECT';
    
-----------------
--DDL
-----------------
--book 테이블 생성

CREATE TABLE book (
    book_id    NUMBER(10),
    title      VARCHAR2(50),
    
    pub_date   DATE DEFAULT SYSDATE,
    author_id     NUMBER(10)
);

DESC book;

--hr.employees 테이블 select 권한이 있으니

SELECT
    *
FROM
    hr.employees;

--subquery이용 테이블 생성
--hr.employees로부터 job_id IT_로 시작하는 직원의 목록을

CREATE TABLE it_emps
    AS
        ( --서브쿼리
         SELECT
            *
          FROM
            hr.employees
          WHERE
            job_id LIKE 'IT_%'
        );

DESC it_emps

SELECT
    *
FROM
    it_emps;

--author 테이블 생성

CREATE TABLE author (
    author_id     NUMBER(10),
    author_name   VARCHAR(100) NOT NULL, --널 허용 X
    author_desc   VARCHAR(500),
    PRIMARY KEY ( author_id ) -- primary key 제약
);

DESC author

DESC book

--book 테이블의 author 컬럼 삭제

ALTER TABLE book DROP COLUMN author; --컬럼 삭제

DESC book;

--book 테이블에 author.author_id를 참조하기 위한 컬럼 추가

ALTER TABLE book ADD (
    author_id   NUMBER(10)
);

DESC book

--book 테이블의 book_id를 NUMBER(10)자리로 변경

ALTER TABLE book MODIFY (
    book_id NUMBER(10)
);

DESC book

--book의 book_id도 pk 속성을 주도록 하겠습니다.

ALTER TABLE book ADD CONSTRAINT pk_book_id PRIMARY KEY ( book_id );

DESC book

--book의 author_id에 author 테이블을 연결:PK

ALTER TABLE book
    ADD CONSTRAINT fk_author_id FOREIGN KEY ( author_id ) -- FOREIGN KEY 적용 컬럼
        REFERENCES author ( author_id ); -- 참조 컬럼

DESC book

--------------------
--Data Dictionary
-------------------
--모든 딕셔너리 확인

SELECT
    *
FROM
    dictionary;

SELECT
    *
FROM
    dictionary
WHERE
    table_name LIKE 'USER_%';
    
--사용자의 DB OBJECT 확인

SELECT
    object_name,
    object_type
FROM
    user_objects;
--사용자의 TABLE 객체 확인

SELECT
    object_name
FROM
    user_objects
WHERE
    object_type = 'TABLE';

--사용자의 제약조건 확인

SELECT
    *
FROM
    user_constraints;

SELECT
    constraint_name,
    constraint_type,
    table_name,
    search_condition
FROM
    user_constraints;
    
commit;