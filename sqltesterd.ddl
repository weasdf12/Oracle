-- 생성자 Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   위치:        2025-08-13 09:25:13 KST
--   사이트:      Oracle Database 21c
--   유형:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE account (
    acc_id            CHAR(14) NOT NULL,
    cust_jumin        CHAR(14 BYTE),
    acc_type          VARCHAR2(20 BYTE) NOT NULL,
    acc_balance       NUMBER NOT NULL,
    acc_card          CHAR(1 BYTE) NOT NULL,
    acc_register_date DATE
);

ALTER TABLE account ADD CONSTRAINT account_pk PRIMARY KEY ( acc_id );

CREATE TABLE card (
    card_no            CHAR(14 BYTE) NOT NULL,
    cust_jumin         CHAR(14 BYTE),
    acc_id             CHAR(14),
    card_register_date DATE,
    card_limit         NUMBER,
    card_approve_date  DATE,
    card_type          VARCHAR2(10 BYTE) NOT NULL
);

ALTER TABLE card ADD CONSTRAINT card_pk PRIMARY KEY ( card_no );

CREATE TABLE customer (
    cust_jumin CHAR(14 BYTE) NOT NULL,
    name       VARCHAR2(20) NOT NULL,
    address    VARCHAR2(100) NOT NULL,
    birth      CHAR(10 BYTE) NOT NULL,
    email      VARCHAR2(100 BYTE),
    hp         VARCHAR2(20) NOT NULL,
    job        VARCHAR2(20 BYTE)
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( cust_jumin );

ALTER TABLE customer ADD CONSTRAINT email_un UNIQUE ( email );

ALTER TABLE customer ADD CONSTRAINT hp_un UNIQUE ( hp );

CREATE TABLE transaction (
    trans_id      NUMBER NOT NULL,
    trans_acc_id  CHAR(14) NOT NULL,
    trans_type    VARCHAR2(20 BYTE),
    trans_message VARCHAR2(20 BYTE),
    trans_money   NUMBER,
    trans_date    DATE NOT NULL
);

ALTER TABLE transaction ADD CONSTRAINT transaction_pk PRIMARY KEY ( trans_id );

ALTER TABLE account
    ADD CONSTRAINT account_customer_fk FOREIGN KEY ( cust_jumin )
        REFERENCES customer ( cust_jumin );

ALTER TABLE card
    ADD CONSTRAINT card_account_fk FOREIGN KEY ( acc_id )
        REFERENCES account ( acc_id );

ALTER TABLE card
    ADD CONSTRAINT card_customer_fk FOREIGN KEY ( cust_jumin )
        REFERENCES customer ( cust_jumin );

ALTER TABLE transaction
    ADD CONSTRAINT transaction_account_fk FOREIGN KEY ( trans_acc_id )
        REFERENCES account ( acc_id );

insert into customer values('760121-1234567', '정우성', '서울' , '1976-01-21', null , '010-1101-7601', '배우');
insert into customer values('750611-1234567', '이정재', '서울' , '1975-06-11', null , '010-1101-7506', '배우');
insert into customer values('890530-1234567', '전지현', '대전' , '1989-05-30', 'jjh@naver.com' , '010-1103-8905', '자영업');
insert into customer values('790413-1234567', '이나영', '대전' , '1979-04-13', 'lee@naver.com' , '010-2101-7904', '회사원');
insert into customer values('660912-1234567', '원빈', '대전' , '1966-09-12', 'one@daum.net' , '010-2104-6609', '배우');

INSERT INTO account VALUES ('1101-1001-1001', '760121-1234567', '자유입출금', 4160000 ,'y', '2020-01-21 13:00:02');
INSERT INTO account VALUES ('1101-1001-1002', '890530-1234567', '자유입출금', 376000 ,'y', '2020-06-11 13:00:02');
INSERT INTO account VALUES ('1101-1001-1003', '790413-1234567', '자유입출금', 1200000 ,'y', '2020-05-30 13:00:02');
INSERT INTO account VALUES ('1101-1001-1004', '660912-1234567', '정기적금', 1000000 ,'n', '2020-04-13 13:00:02');
INSERT INTO account VALUES ('1101-1001-1005', '750611-1234567', '자유입출금', 820000 ,'y', '2020-09-12 13:00:02');

INSERT INTO card VALUES (
  '2111-1001-1001','760121-1234567','1101-1001-1001',TO_DATE('2020-01-21', 'YYYY-MM-DD'), 1000000, TO_DATE('2020-02-10', 'YYYY-MM-DD'),'check');
INSERT INTO card VALUES (
  '2041-1001-1002','890530-1234567','1101-1001-1002',TO_DATE('2020-06-11', 'YYYY-MM-DD'), 3000000, TO_DATE('2020-06-15', 'YYYY-MM-DD'),'check');
INSERT INTO card VALUES (
  '2011-1001-1003','790413-1234567','1101-1001-1003',TO_DATE('2020-05-30', 'YYYY-MM-DD'), 5000000, TO_DATE('2020-06-25', 'YYYY-MM-DD'),'check');
INSERT INTO card VALUES (
  '2611-1001-1005','750611-1234567','1101-1001-1005',TO_DATE('2020-09-12', 'YYYY-MM-DD'), 1500000, TO_DATE('2020-10-10', 'YYYY-MM-DD'), 'check');

INSERT INTO transaction VALUES (1, '1101-1001-1001', '입금', '2월 정기급여', 3500000, TO_DATE('2020-02-10 12:13:12','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO transaction VALUES (2, '1101-1001-1003', '출금', 'ATM 출금', 300000, TO_DATE('2020-02-10 12:37:21','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO transaction VALUES (3, '1101-1001-1002', '입금', '2월 급여', 2800000, TO_DATE('2020-02-10 12:38:21','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO transaction VALUES (4, '1101-1001-1001', '출금', '2월 공과금', 116200, TO_DATE('2020-02-10 12:39:21','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO transaction VALUES (5, '1101-1001-1005', '출금', 'ATM 출금', 50000, TO_DATE('2020-02-10 12:40:21','YYYY-MM-DD HH24:MI:SS'));

--1
select * 
from customer;

--2
select *
from card;

--3
select * 
from account;

--4
select * 
from transaction
order by trans_date desc
fetch first 3 rows only;

--5
select c.name as 고객이름,
a.card_type as 카드종류
from card a
join customer c on a.cust_jumin = c.cust_jumin
where card_limit >= 2000000;

--6
select  trans_acc_id as 계좌번호,
  COUNT(*) as 거래건수 
from transaction
group by trans_acc_id
order by 거래건수 desc;

--7
select *
from transaction
where trans_money >= 1000000
order by trans_date;

--8
select a.acc_id as 계좌id,
c.card_no as 카으id,
c.card_type as 종류
from account a
join card c on a.acc_id = c.acc_id
order by a.acc_id;

--9
select *
from transaction 
where trans_type like '입금';

--10
select c.name as 고객명,
c.cust_jumin as 주민,
c.hp as 전화,
c.address as 주소
from account a
join customer c on a.cust_jumin = c.cust_jumin
where acc_balance >= 4000000;

-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                             10
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
-- ERRORS                                   0
-- WARNINGS                                 0
