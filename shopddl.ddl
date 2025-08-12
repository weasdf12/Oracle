-- 생성자 Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   위치:        2025-08-11 10:26:49 KST
--   사이트:      Oracle Database 21c
--   유형:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE customer (
    custid VARCHAR2(10 BYTE) NOT NULL,
    name   VARCHAR2(10 BYTE) NOT NULL,
    hp     CHAR(13 BYTE),
    addr   VARCHAR2(100 BYTE),
    rdate  DATE NOT NULL
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( custid );

ALTER TABLE customer ADD CONSTRAINT customer__un UNIQUE ( hp );

CREATE TABLE "order" (
    orderno      INTEGER NOT NULL,
    orderid      VARCHAR2(10 BYTE),
    orderproduct INTEGER,
    ordercount   INTEGER NOT NULL,
    orderdate    DATE NOT NULL
);
drop table Order;
ALTER TABLE "order" ADD CONSTRAINT order_pk PRIMARY KEY ( orderno );

CREATE TABLE product (
    prodno   INTEGER NOT NULL,
    prodname VARCHAR2(10 BYTE) NOT NULL,
    stock    INTEGER NOT NULL,
    price    INTEGER,
    company  VARCHAR2(20 BYTE) NOT NULL
);
alter table product modify prodname varchar2(12 byte);
ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( prodno );

ALTER TABLE "Order"
    ADD CONSTRAINT order_customer_fk FOREIGN KEY ( orderid )
        REFERENCES customer ( custid );

ALTER TABLE "Order"
    ADD CONSTRAINT order_product_fk FOREIGN KEY ( orderproduct )
        REFERENCES product ( prodno );



insert into customer values ('c101', '김유신', '010-1234-1001', '경남 김해시', '2023-01-01');
insert into customer values ('c102', '김춘추', '010-1234-1002', '경남 진주시', '2023-01-02');
insert into customer values ('c103', '장보고', '010-1234-1003', '전남 완도군', '2023-01-03');
insert into customer values ('c104', '강감찬', '010-1234-1004', '서울시 관악구', '2023-01-04');
insert into customer values ('c105', '이순신', '010-1234-1005', '부산시 금정구', '2023-01-05');

insert into product values ('1', '새우깡', '5000', '1500', '농심');
insert into product values ('2', '초코파이', '2500', '2500', '오리온');
insert into product values ('3', '포카칩', '3600', '1700', '오리온');
insert into product values ('4', '양파링', '1250', '1800', '농심');
insert into product values ('5', '죠리퐁', '2200', null, '크라운');
select * from "order";
insert into "order" values ('1' ,'c102', 3, 2 ,'2023-01-01 13:15:10');
insert into "order" values ('2' ,'c101', 4, 1 ,'2023-01-01 13:15:12');
insert into "order" values ('3' ,'c102', 1, 1 ,'2023-01-01 13:15:14');
insert into "order" values ('4' ,'c103', 5, 5 ,'2023-01-01 13:15:16');
insert into "order" values ('5' ,'c105', 2, 1 ,'2023-01-01 13:15:18');

SELECT 
    o.orderNo,
    c.name AS 고객명,
    p.prodName AS 상품명,
    o.orderCount AS 주문수량,
    o.orderDate AS 주문일
FROM 
    "Order" o
JOIN 
    Customer c ON o.orderId = c.custId
JOIN 
    Product p ON o.orderProduct = p.prodNo;

SELECT 
    o.orderNo AS 주문번호,
    p.prodNo AS 상품번호,
    p.prodName AS 상품명,
    p.price AS 가격,
    o.orderCount AS 주문수량,
    o.orderDate AS 주문일
FROM 
    "Order" o
JOIN 
    Customer c ON o.orderId = c.custId
JOIN 
    Product p ON o.orderProduct = p.prodNo
WHERE 
    c.name = '김유신';



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             3
-- CREATE INDEX                             0
-- ALTER TABLE                              6
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
