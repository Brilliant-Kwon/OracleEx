DESC author;

SELECT
    *
FROM
    author;

CREATE TABLE phone_book (
    id     NUMBER(10) PRIMARY KEY,
    name   VARCHAR2(10),
    hp     VARCHAR2(20),
    tel    VARCHAR2(20)
);

drop table phone_book;

drop SEQUENCE SEQ_PHONE_BOOK;

create sequence SEQ_PHONE_BOOK 
                    minvalue 1
                    maxvalue 999999999999999999999
                    start with 1
                    increment by 1;

ALTER SEQUENCE SEQ_PHONE_BOOK INCREMENT BY 1;

CREATE SEQUENCE seq_phone_book;

select seq_phone_book.currval from USER_SEQUENCES;

DESC phone_book;