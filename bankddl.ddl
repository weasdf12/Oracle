-- 생성자 Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   위치:        2025-08-11 12:10:09 KST
--   사이트:      Oracle Database 21c
--   유형:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE bank_account (
    a_no        CHAR(11) NOT NULL,
    a_item_dist CHAR(2) NOT NULL,
    a_item_name VARCHAR2(20) NOT NULL,
    a_c_no      VARCHAR2(14),
    a_balance   INTEGER NOT NULL,
    a_open_date DATE NOT NULL
);

ALTER TABLE bank_account ADD CONSTRAINT bank_account_pk PRIMARY KEY ( a_no );

CREATE TABLE bank_customer (
    c_no    VARCHAR2(14) NOT NULL,
    c_name  VARCHAR2(20) NOT NULL,
    c_dist  INTEGER NOT NULL,
    c_phone CHAR(13) NOT NULL,
    c_addr  VARCHAR2(50)
);

ALTER TABLE bank_customer ADD CONSTRAINT bank_customer_pk PRIMARY KEY ( c_no );

CREATE TABLE bank_transaction (
    t_no       INTEGER NOT NULL,
    t_a_no_1   CHAR(11) NOT NULL,
    t__dist    INTEGER NOT NULL,
    t_amount   INTEGER NOT NULL,
    t_datetime DATE NOT NULL
);

ALTER TABLE bank_transaction ADD CONSTRAINT bank_transaction_pk PRIMARY KEY ( t_no );

-- Error - Unique Constraint bank_transaction.bank_transaction__UN doesn't have columns

ALTER TABLE bank_account
    ADD CONSTRAINT bank_account_bank_customer_fk FOREIGN KEY ( a_c_no )
        REFERENCES bank_customer ( c_no );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE bank_transaction
    ADD CONSTRAINT bank_transaction_bank_account_fk FOREIGN KEY ( t_a_no_1 )
        REFERENCES bank_account ( a_no );


DELETE FROM bank_account;
DELETE FROM bank_customer;

INSERT INTO bank_customer VALUES ('730423-1000001', '김유신', 1, '010-1234-1001', '경남 김해시');
INSERT INTO bank_customer VALUES ('730423-1000002', '김춘추', 1, '010-1234-1002', '경남 경주시');
INSERT INTO bank_customer VALUES ('750423-1000003', '장보고', 1, '010-1234-1003', '전남 완도군');
INSERT INTO bank_customer VALUES ('102-12-51094', '(주)정보산업', 2, '051-500-1004', '부산시 부산진구');
INSERT INTO bank_customer VALUES ('930423-1000005', '이순신', 1, '010-1234-1005', '서울 종로구');

INSERT INTO bank_account VALUES ('101-11-1001', 'S1', '자유저축예금', '730423-1000001', 1550000, TO_DATE('2011-04-11', 'YYYY-MM-DD'));
INSERT INTO bank_account VALUES ('101-11-1002', 'S1', '자유저축예금', '930423-1000005', 260000, TO_DATE('2011-05-12', 'YYYY-MM-DD'));
INSERT INTO bank_account VALUES ('101-11-1003', 'S1', '자유저축예금', '750423-1000003', 75000, TO_DATE('2011-06-13', 'YYYY-MM-DD'));
INSERT INTO bank_account VALUES ('101-12-1001', 'S2', '기업전용예금', '102-12-51094', 15000000, TO_DATE('2011-07-14', 'YYYY-MM-DD'));
INSERT INTO bank_account VALUES ('101-13-1001', 'S3', '정기저축예금', '730423-1000002', 1200000, TO_DATE('2011-08-15', 'YYYY-MM-DD'));

insert into bank_transaction values (1, '101-11-1001', 1, 50000, TO_DATE('2023-01-01 13:15:10', 'YYYY-MM-DD HH24:MI:SS'));
insert into bank_transaction values (2, '101-12-1001', 2, 1000000, TO_DATE('2023-01-02 13:15:12', 'YYYY-MM-DD HH24:MI:SS'));
insert into bank_transaction values (3, '101-11-1002', 3, 260000, TO_DATE('2023-01-03 13:15:14', 'YYYY-MM-DD HH24:MI:SS'));
insert into bank_transaction values (4, '101-11-1002', 2, 100000, TO_DATE('2023-01-04 13:15:16', 'YYYY-MM-DD HH24:MI:SS'));
insert into bank_transaction values (5, '101-11-1003', 3, 75000, TO_DATE('2023-01-05 13:15:18', 'YYYY-MM-DD HH24:MI:SS'));
insert into bank_transaction values (6, '101-11-1001', 1, 150000, TO_DATE('2023-01-05 13:15:28', 'YYYY-MM-DD HH24:MI:SS'));

SELECT
    c.c_no AS 고객번호,
    c.c_name AS 이름,
    c.c_phone AS 연락처,
    a.a_no AS 계좌번호,
    a.a_item_name AS 계좌상품명,
    a.a_balance AS 현재잔액
FROM
    bank_customer c
JOIN
    bank_account a
ON
    c.c_no = a.a_c_no;

SELECT
    CASE t.t__dist
        WHEN 1 THEN '입금'
        WHEN 2 THEN '출금'
        WHEN 3 THEN '이체'
        ELSE '기타'
    END AS 거래구분,
    t.t_amount AS 거래금액,
    TO_CHAR(t.t_datetime, 'YYYY-MM-DD HH24:MI:SS') AS 거래날짜
FROM
    bank_customer c
JOIN
    bank_account a ON c.c_no = a.a_c_no
JOIN
    bank_transaction t ON a.a_no = t.t_a_no_1
WHERE
    c.c_name = '이순신';

SELECT
    c.c_no AS 주민번호,
    c.c_name AS 고객명,
    a.a_no AS 계좌번호,
    a.a_balance AS 현재잔액,
    TO_CHAR(a.a_open_date, 'YYYY-MM-DD') AS 계좌개설일
FROM
    bank_customer c
JOIN
    bank_account a ON c.c_no = a.a_c_no
WHERE
    c.c_dist = 1
ORDER BY
    a.a_balance DESC
FETCH FIRST 1 ROWS ONLY;



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             3
-- CREATE INDEX                             0
-- ALTER TABLE                              5
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   2
-- WARNINGS                                 0
