-----------------
--DCL 
-----------------

--system ���� Ȥ�� sys �������� ����
--����� ����
--username biuser, password bituser
CONN system / manager -- ���� �ο�

CREATE USER bituser IDENTIFIED BY bituser; -- ���� �־�� ��

--����� ���� ���� Ȯ��

CONN hr / hr

SELECT
    *
FROM
    user_users; -- ���� ����� Ȯ��

SELECT
    *
FROM
    all_users; -- ��� ����� ���� Ȯ��

SELECT
    *
FROM
    dba_users; -- ��� ����� ������ (DBA����)

SELECT
    username,
    account_status
FROM
    dba_users
WHERE
    username = 'hr';
    
--�α��� ���� �ο� ( system �������� ����)

GRANT
    CREATE SESSION
TO bituser;
--connect, resource �� �ο��ϸ� �Ϲ� db ����ڸ� ���� �� �ִ�.

GRANT connect,resource TO bituser;
--bituser���� hr.employees�� departments ���̺� SELECT���� �ο�

GRANT CREATE SEQUENCE TO bituser;

GRANT SELECT ON hr.employees TO bituser;

GRANT SELECT ON hr.departments TO bituser;

--���� ����ڿ��� �ο��� ROLE ��ȸ

SHOW USER

SELECT
    *
FROM
    user_role_privs;

--RESOURCE ROLE �ȿ� �ο��� ���� PRIVILEGE�� Ȯ��

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
--book ���̺� ����

CREATE TABLE book (
    book_id    NUMBER(10),
    title      VARCHAR2(50),
    
    pub_date   DATE DEFAULT SYSDATE,
    author_id     NUMBER(10)
);

DESC book;

--hr.employees ���̺� select ������ ������

SELECT
    *
FROM
    hr.employees;

--subquery�̿� ���̺� ����
--hr.employees�κ��� job_id IT_�� �����ϴ� ������ �����

CREATE TABLE it_emps
    AS
        ( --��������
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

--author ���̺� ����

CREATE TABLE author (
    author_id     NUMBER(10),
    author_name   VARCHAR(100) NOT NULL, --�� ��� X
    author_desc   VARCHAR(500),
    PRIMARY KEY ( author_id ) -- primary key ����
);

DESC author

DESC book

--book ���̺��� author �÷� ����

ALTER TABLE book DROP COLUMN author; --�÷� ����

DESC book;

--book ���̺� author.author_id�� �����ϱ� ���� �÷� �߰�

ALTER TABLE book ADD (
    author_id   NUMBER(10)
);

DESC book

--book ���̺��� book_id�� NUMBER(10)�ڸ��� ����

ALTER TABLE book MODIFY (
    book_id NUMBER(10)
);

DESC book

--book�� book_id�� pk �Ӽ��� �ֵ��� �ϰڽ��ϴ�.

ALTER TABLE book ADD CONSTRAINT pk_book_id PRIMARY KEY ( book_id );

DESC book

--book�� author_id�� author ���̺��� ����:PK

ALTER TABLE book
    ADD CONSTRAINT fk_author_id FOREIGN KEY ( author_id ) -- FOREIGN KEY ���� �÷�
        REFERENCES author ( author_id ); -- ���� �÷�

DESC book

--------------------
--Data Dictionary
-------------------
--��� ��ųʸ� Ȯ��

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
    
--������� DB OBJECT Ȯ��

SELECT
    object_name,
    object_type
FROM
    user_objects;
--������� TABLE ��ü Ȯ��

SELECT
    object_name
FROM
    user_objects
WHERE
    object_type = 'TABLE';

--������� �������� Ȯ��

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