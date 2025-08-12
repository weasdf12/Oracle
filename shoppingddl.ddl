-- 생성자 Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   위치:        2025-08-11 15:49:54 KST
--   사이트:      Oracle Database 21c
--   유형:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE cart (
    cartno        number NOT NULL,
    userid        VARCHAR2(20 BYTE) NOT NULL,
    prodno        number NOT NULL,
    cartprodcount number,
    cartproddate  DATE NOT NULL
);

ALTER TABLE cart ADD CONSTRAINT cart_pk PRIMARY KEY ( cartno );

CREATE TABLE category (
    cateno   number NOT NULL,
    catename VARCHAR2(100 BYTE) NOT NULL
);

ALTER TABLE category ADD CONSTRAINT category_pk PRIMARY KEY ( cateno );

CREATE TABLE orders (
    orderno         CHAR(11 BYTE) NOT NULL,
    userid          VARCHAR2(20 BYTE) NOT NULL,
    ordertotalprice number NOT NULL,
    orderadress     VARCHAR2(200 BYTE) NOT NULL,
    orderstatus     number,
    orderdate       DATE NOT NULL
);

ALTER TABLE orders ADD CONSTRAINT orders_pk PRIMARY KEY ( orderno );

CREATE TABLE ordersitem (
    itemno       number NOT NULL,
    orderno      CHAR(11 BYTE) NOT NULL,
    prodno       number NOT NULL,
    itemprice    number NOT NULL,
    itemdiscount number NOT NULL,
    itemcount    number
);

ALTER TABLE ordersitem ADD CONSTRAINT ordersitem_pk PRIMARY KEY ( itemno );

CREATE TABLE point (
    pointno   number NOT NULL,
    userid    VARCHAR2(20 BYTE) NOT NULL,
    point     number NOT NULL,
    "desc"    VARCHAR2(100 BYTE) NOT NULL,
    pointdate DATE NOT NULL
);

ALTER TABLE point ADD CONSTRAINT point_pk PRIMARY KEY ( pointno );

CREATE TABLE product (
    prodno       number NOT NULL,
    cateno       number NOT NULL,
    sellerno     number,
    prodname     VARCHAR2(20 BYTE) NOT NULL,
    prodprice    number NOT NULL,
    prodstock    number,
    prodsold     number,
    proddiscount number
);

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( prodno );

CREATE TABLE seller (
    sellerno number NOT NULL,
    company  VARCHAR2(100 BYTE) NOT NULL,
    tel      VARCHAR2(20) NOT NULL,
    manager  VARCHAR2(20 BYTE) NOT NULL,
    address  VARCHAR2(100) NOT NULL
);

ALTER TABLE seller ADD CONSTRAINT seller_pk PRIMARY KEY ( sellerno );

CREATE TABLE "user" (
    userid  VARCHAR2(20 BYTE) NOT NULL,
    name    VARCHAR2(20 BYTE) NOT NULL,
    birth   CHAR(10) NOT NULL,
    gender  CHAR(1 BYTE) NOT NULL,
    hp      CHAR(13 BYTE) NOT NULL,
    email   VARCHAR2(100 BYTE),
    point   number,
    "level" number,
    address VARCHAR2(100 BYTE),
    regdate DATE NOT NULL
);

ALTER TABLE "user" ADD CONSTRAINT user_pk PRIMARY KEY ( userid );

ALTER TABLE "user" ADD CONSTRAINT hp_uk UNIQUE ( hp );

ALTER TABLE "user" ADD CONSTRAINT email_uk UNIQUE ( email );

ALTER TABLE cart
    ADD CONSTRAINT cart_product_fk FOREIGN KEY ( prodno )
        REFERENCES product ( prodno );

ALTER TABLE cart
    ADD CONSTRAINT cart_user_fk FOREIGN KEY ( userid )
        REFERENCES "user" ( userid );

ALTER TABLE orders
    ADD CONSTRAINT orders_user_fk FOREIGN KEY ( userid )
        REFERENCES "user" ( userid );

ALTER TABLE ordersitem
    ADD CONSTRAINT ordersitem_orders_fk FOREIGN KEY ( orderno )
        REFERENCES orders ( orderno );

ALTER TABLE ordersitem
    ADD CONSTRAINT ordersitem_product_fk FOREIGN KEY ( prodno )
        REFERENCES product ( prodno );

ALTER TABLE point
    ADD CONSTRAINT point_user_fk FOREIGN KEY ( userid )
        REFERENCES "user" ( userid );

ALTER TABLE product
    ADD CONSTRAINT product_category_fk FOREIGN KEY ( cateno )
        REFERENCES category ( cateno );

ALTER TABLE product
    ADD CONSTRAINT product_seller_fk FOREIGN KEY ( sellerno )
        REFERENCES seller ( sellerno );

INSERT INTO "user" VALUES ('user1', '김유신',('1976-01-21'), 'M', '010-1101-1976', 'kimys@naver.com', 7000, 1, '서울', ('2022-01-10 10:50:12'));
INSERT INTO "user" VALUES ('user2', '계백',('1975-07-11'), 'M', '010-1102-1975', null, 5650, 1, '서울', ('2022-01-10 10:50:12'));
INSERT INTO "user" VALUES ('user3', '김춘추',('1989-05-30'), 'M', '010-1103-1989', null, 4320, 2, '서울', ('2022-01-10 10:50:12'));
INSERT INTO "user" VALUES ('user4', '이사부',('1979-04-13'), 'M', '010-2101-1979', 'leesabu@gmail.com', 0, 1, '서울', ('2022-01-10 10:50:12'));

INSERT INTO "user" VALUES ('user5', '장보고', ('1966-09-12'), 'M', '010-2104-1966', 'jangbg@naver.com', 3000, 4, '대전', ('2022-01-10 10:50:12'));
INSERT INTO "user" VALUES ('user6', '선덕여왕', ('1979-07-28'), 'M', '010-3101-1979', 'gueen@naver.com', 15840, 2, '대전', ('2022-01-10 10:50:12'));
INSERT INTO "user" VALUES ('user7', '강감찬', ('1984-06-15'), 'F', '010-4101-1984', 'kang@daum.net', 3610, 0, '대구', ('2022-01-10 10:50:12'));
INSERT INTO "user" VALUES ('user8', '신사임당', ('1965-10-21'), 'M', '010-5101-1965', 'sinsa@gmail.com', 0, 1, '대구', ('2022-01-10 10:50:12'));
INSERT INTO "user" VALUES ('user9', '이이', ('1972-11-28'), 'F', '010-6101-1972', 'leelee@nate.com', 0, 3, '부산', ('2022-01-10 10:50:12'));
INSERT INTO "user" VALUES ('user10', '허난설헌', ('1992-09-07'), 'F', '010-7103-1992', NULL, 0, 3, '광주', ('2022-01-10 10:50:12'));

INSERT INTO point VALUES (1, 'user1', 1000, '회원가입 1000 적립', TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO point VALUES (2, 'user1', 6000, '상품구매 5% 적립', TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO point VALUES (3, 'user3', 2820, '상품구매 5% 적립', TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO point VALUES (4, 'user7', 3610, '상품구매 5% 적립', TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Point VALUES (5, 'user5', 3000, '이벤트 응모 3000 적립', TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Point VALUES (6, 'user2', 1000, '회원가입 1000 적립', TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Point VALUES (7, 'user2', 2000, '이벤트 응모 2000 적립', TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Point VALUES (8, 'user2', 2650, '상품구매 5% 적립', TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Point VALUES (9, 'user3', 1500, '이벤트 응모 1500 적립', TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Point VALUES (10, 'user6', 15840, '상품구매 2% 적립', TO_DATE('2022-01-10', 'YYYY-MM-DD'));

INSERT INTO Seller VALUES (10001, '(주)다팔아', '02-201-1976', '정우성', '서울');
INSERT INTO Seller VALUES (10002, '판매의민족', '02-102-1975', '이정재', '서울');
INSERT INTO Seller VALUES (10003, '멋남', '031-103-1989', '원빈', '경기');
INSERT INTO Seller VALUES (10004, '스타일살아', '032-201-1979', '이나영', '경기');
INSERT INTO Seller VALUES (10005, '(주)삼성전자', '02-214-1966', '장동건', '서울');
INSERT INTO Seller VALUES (10006, '복실이옷짱', '051-301-1979', '고소영', '부산');
INSERT INTO Seller VALUES (10007, '컴퓨존(주)', '055-401-1984', '유재석', '대구');
INSERT INTO Seller VALUES (10008, '(주)LG전자', '02-511-1965', '강호동', '서울');
INSERT INTO Seller VALUES (10009, '굿바디스포츠', '070-6101-1972', '조인성', '부산');
INSERT INTO Seller VALUES (10010, '누리푸드', '051-710-1992', '강동원', '부산');

INSERT INTO Category VALUES (10, '여성의류패션');
INSERT INTO Category VALUES (11, '남성의류패션');
INSERT INTO Category VALUES (12, '식품·생필품');
INSERT INTO Category VALUES (13, '취미·반려견');
INSERT INTO Category VALUES (14, '홈·문구');
INSERT INTO Category VALUES (15, '자동차·공구');
INSERT INTO Category VALUES (16, '스포츠·건강');
INSERT INTO Category VALUES (17, '컴퓨터·가전·디지털');
INSERT INTO Category VALUES (18, '여행');
INSERT INTO Category VALUES (19, '도서');

INSERT INTO Product VALUES (100101, 11, 10003, '반팔티 L~2XL', 25000, 869, 132, 20);
INSERT INTO Product VALUES (100110, 10, 10004, '트레이닝', 38000, 1602, 398, 15);
INSERT INTO Product VALUES (110101, 10, 10003, '신상 운동화', 76000, 160, 40, 5);
INSERT INTO Product VALUES (120101, 12, 10010, '암소 1등급1.2kg', 150000, 0, 87, 15);
INSERT INTO Product VALUES (120103, 12, 10010, '부채살 250g', 21000, 0, 61, 10);
INSERT INTO Product VALUES (130101, 13, 10006, '강아지 사료', 56000, 58, 142, 0);
INSERT INTO Product VALUES (130112, 13, 10006, '강아지옷', 15000, 120, 80, 0);
INSERT INTO Product VALUES (141001, 14, 10001, '소파,방수', 320000, 0, 42, 0);
INSERT INTO Product VALUES (170115, 17, 10007, '그래픽카드', 900000, 28, 12, 12);
INSERT INTO Product VALUES (160103, 16, 10009, '33BR철봉', 120000, 32, 28, 0);


INSERT INTO Orders VALUES ('22010210001', 'user2', 52300, '서울시 마포구 121', 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES ('22010210002', 'user3', 56700, '서울시 강남구 21-1', 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES ('22010210010', 'user4', 72200, '서울시 강서구 큰대로 38', 2, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES ('22010310001', 'user5', 127000, '경기도 광주시 초월로 21', 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES ('22010310100', 'user1', 120000, '경기도 수원시 120번지', 0, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES ('22010410101', 'user6', 792000, '부산시 남구 21-1', 2, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES ('22010510021', 'user7', 92200, '부산시 부산진구 56 10층', 4, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES ('22010510027', 'user8', 112000, '대구시 팔달로 19', 3, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES ('22010510031', 'user10', 792000, '대전시 한밭로 24-1', 2, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES ('22010710110', 'user9', 94500, '광주시 충열로 11', 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));

INSERT INTO Ordersitem VALUES (1, '22010210001', 100110, 38000, 15, 1);
INSERT INTO Ordersitem VALUES (2, '22010210001', 100101, 25000, 20, 1);
INSERT INTO Ordersitem VALUES (3, '22010210002', 120103, 21000, 10, 3);
INSERT INTO Ordersitem VALUES (4, '22010310001', 130112, 15000, 0, 1);
INSERT INTO Ordersitem VALUES (5, '22010310001', 130101, 56000, 0, 2);
INSERT INTO Ordersitem VALUES (6, '22010210010', 110101, 76000, 5, 1);
INSERT INTO Ordersitem VALUES (7, '22010310100', 160103, 120000, 0, 1);
INSERT INTO Ordersitem VALUES (8, '22010410101', 170115, 900000, 12, 1);
INSERT INTO Ordersitem VALUES (9, '22010510021', 110101, 76000, 5, 1);
INSERT INTO Ordersitem VALUES (10, '22010510027', 130101, 56000, 0, 2);
INSERT INTO Ordersitem VALUES (11, '22010510021', 100101, 25000, 20, 1);
INSERT INTO Ordersitem VALUES (12, '22010510031', 170115, 900000, 12, 1);
INSERT INTO Ordersitem VALUES (13, '22010710110', 120103, 21000, 10, 5);

INSERT INTO cart VALUES (1, 'user1', 100101, 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO cart VALUES (2, 'user1', 100110, 2, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO cart VALUES (3, 'user3', 120103, 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO cart VALUES (4, 'user4', 130112, 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO cart VALUES (5, 'user5', 130101, 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO cart VALUES (6, 'user2', 110101, 3, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO cart VALUES (7, 'user2', 160103, 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO cart VALUES (8, 'user2', 170115, 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO cart VALUES (9, 'user3', 110101, 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO cart VALUES (10, 'user6', 130101, 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));




--1
select u.userid,
p.prodname,
c.cartprodcount
from cart c
join "user" u on c.userid = u.userid
join product p on c.prodno = p.prodno
where c.cartprodcount >=2;

--2
select p.prodno,
c.cateno,
p.prodname,
p.prodprice,
s.manager,
s.tel
from product p 
join Category c on p.cateno = c.cateno
join seller s on p.sellerno  = s.sellerno;

--3
select u.userid,
u.name,
u.hp,
u.point,
p.point as 총합
from "user" u
join point p on u.userid = p.userid;

--4
select o.orderno,
o.userid,
u.name,
o.ordertotalprice,
o.orderdate
from orders o
join "user" u on o.userid = u.userid
where o.ordertotalprice >= 100000
order by o.ordertotalprice desc, u.name asc;

--5

SELECT 
    o.orderno,
    o.userid,
    u.name,
    LISTAGG(p.prodname, ',') 
        WITHIN GROUP (ORDER BY p.prodname) as sdf,
    o.orderdate 
FROM 
    orders o
JOIN 
    ordersitem i ON o.orderno = i.orderno
JOIN 
    "user" u ON o.userid = u.userid
JOIN 
    product p ON p.prodno = i.prodno
GROUP BY 
    o.orderno, o.userid, u.name, o.orderdate;
    
--6
select prodno,
prodname,
prodprice,
proddiscount,
FLOOR(prodPrice * (1 - prodDiscount / 100)) AS 할인가
from product;

--7
select p.prodno,
p.prodname,
p.prodprice,
p.prodstock,
s.manager
from product p
join seller s on p.sellerno = s.sellerno
where manager = '고소영';

--8
select s.sellerno,
s.company,
s.manager,
s.tel
from seller s
left join product p on p.sellerno = s.sellerno
where prodno is null;

--9
select * --아몰랑
from ordersitem;

--10
select
 u.name as 고객명,
    listagg(distinct p.prodname, ',')within group (order by p.prodname) as 상품명
from orders o
join "user" u on o.userid = u.userid
join ordersitem i on o.orderno = i.orderno
join product p on p.prodno = i.prodno
where u.name = '장보고'
group by u.name;

 