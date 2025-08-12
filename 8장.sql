CREATE TABLE "order" (
    orderno   NUMBER NOT NULL,
    orderdate DATE,
    custid    VARCHAR2(20 BYTE),
    name      VARCHAR2(10 BYTE),
    addr      VARCHAR2(100 BYTE),
    bookid    NUMBER,
    bookname  VARCHAR2(100 BYTE),
    count     NUMBER,
    price     NUMBER
);

ALTER TABLE "order" ADD CONSTRAINT order_pk PRIMARY KEY ( orderno );


CREATE TABLE bo_book (
    orderid  VARCHAR2 (20)
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    bookname VARCHAR2(100 BYTE),
    price    NUMBER
);

ALTER TABLE bo_book ADD CONSTRAINT book_pk PRIMARY KEY ( orderid );

CREATE TABLE bo_customer (
    cusid   VARCHAR2(20 BYTE) NOT NULL,
    name    VARCHAR2(20 BYTE),
    address VARCHAR2(100 BYTE)
);

ALTER TABLE bo_customer ADD CONSTRAINT customer_pk PRIMARY KEY ( cusid );

CREATE TABLE bo_order (
    orderno   NUMBER NOT NULL,
    orderdate DATE,
    custid    VARCHAR2(20 BYTE),
    name      VARCHAR2(10 BYTE),
    addr      VARCHAR2(100 BYTE),
    bookid    NUMBER,
    bookname  VARCHAR2(100 BYTE),
    count     NUMBER,
    price     NUMBER
);

ALTER TABLE bo_order ADD CONSTRAINT order_pkv2 PRIMARY KEY ( orderno );

CREATE TABLE bo_order1 (
    orderno   NUMBER NOT NULL,
    orderid   VARCHAR2(20 BYTE),
    bookid    VARCHAR2 (20)
--  ERROR: VARCHAR2 size not specified 
    ,
    count     NUMBER,
    orderdate DATE
);

ALTER TABLE bo_order1 ADD CONSTRAINT order_pk PRIMARY KEY ( orderno );

ALTER TABLE bo_order1
    ADD CONSTRAINT order1_book_fk FOREIGN KEY ( bookid )
        REFERENCES bo_book ( orderid );

ALTER TABLE bo_order1
    ADD CONSTRAINT order1_customer_fk FOREIGN KEY ( orderid )
        REFERENCES bo_customer ( cusid );


--1
insert into "order" values (10001, '2024-01-12', 'a101', '김유신', '김해', 101, '프로그래밍', 1, 28000);
insert into "order" values (10002, '2024-01-12', 'a102', '김춘추', '경주', 101, '프로그래밍', 1,28000);
insert into "order" values (10003, '2024-01-12', 'a102', '김춘추', '경주', 102, '자료구조', 2,32000);
insert into "order" values (10004, '2024-01-12', 'a103', '장보고', '완도', 102, '자료구조', 2,32000);
insert into "order" values (10005, '2024-01-12', 'a104', '강감찬', '서울', 110, '데이터베이스', 1,25000);
insert into "order" values (10006, '2024-01-12', 'a105', '이순신', '서울', 110, '데이터베이스', 1,28000);
insert into "order" values (10007, '2024-01-12', 'a105', '이순신', '서울', 110, '자료구조', 1, 32000);



--2

--3

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE bo_book3 (
    orderid  NUMBER NOT NULL,
    bookname VARCHAR2(100 BYTE)
);

ALTER TABLE bo_book3 ADD CONSTRAINT bo_bookv1_pk PRIMARY KEY ( orderid );

CREATE TABLE bo_customer (
    cusid   VARCHAR2(20 BYTE) NOT NULL,
    name    VARCHAR2(20 BYTE),
    address VARCHAR2(100 BYTE)
);

ALTER TABLE bo_customer3 ADD CONSTRAINT bo_customerv1_pk PRIMARY KEY ( cusid );

CREATE TABLE bo_order3 (
    orderno   NUMBER NOT NULL,
    orderid   VARCHAR2(20 BYTE),
    orderdate DATE
);

ALTER TABLE bo_order3 ADD CONSTRAINT bo_order1v1_pk PRIMARY KEY ( orderno );

CREATE TABLE bo_orderitem (
    orderno NUMBER NOT NULL,
    bookid  NUMBER NOT NULL,
    count   NUMBER,
    price   NUMBER
);

ALTER TABLE bo_orderitem ADD CONSTRAINT bo_order3v1_pk PRIMARY KEY ( orderno );

ALTER TABLE bo_order3
    ADD CONSTRAINT bo_order3_bo_customer3_fk FOREIGN KEY ( orderid )
        REFERENCES bo_customer3 ( cusid );

ALTER TABLE bo_orderitem
    ADD CONSTRAINT bo_orderitem_bo_book3_fk FOREIGN KEY ( bookid )
        REFERENCES bo_book3 ( orderid );

ALTER TABLE bo_orderitem
    ADD CONSTRAINT bo_orderitem_bo_order3_fk FOREIGN KEY ( orderno )
        REFERENCES bo_order3 ( orderno );


--4
--5





