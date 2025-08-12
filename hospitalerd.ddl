-- 생성자 Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   위치:        2025-08-12 11:34:36 KST
--   사이트:      Oracle Database 21c
--   유형:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE chart (
    chart_id   CHAR(8 BYTE) NOT NULL,
    treat_no   INTEGER NOT NULL,
    doc_id     CHAR(7 BYTE) NOT NULL,
    pat_id     CHAR(7 BYTE) NOT NULL,
    chart_desc VARCHAR2(100 BYTE) NOT NULL
);

ALTER TABLE chart
    ADD CONSTRAINT chart_pk
        PRIMARY KEY ( chart_id,
                      treat_no,
                      doc_id,
                      pat_id );

CREATE TABLE department (
    dep_no      CHAR(3 BYTE) NOT NULL,
    dep_name    VARCHAR2(20 BYTE),
    dep_manager VARCHAR2(20 BYTE) NOT NULL,
    dep_tel     VARCHAR2(20 BYTE) NOT NULL
);

ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY ( dep_no );

CREATE TABLE doctor (
    doc_id    CHAR(7 BYTE) NOT NULL,
    dep_no    CHAR(3 BYTE),
    doc_name  VARCHAR2(45 BYTE) NOT NULL,
    doc_birth CHAR(10 BYTE) NOT NULL,
    doc_gen   CHAR(1 BYTE) NOT NULL,
    doc_pos   VARCHAR2(45 BYTE) NOT NULL,
    doc_phone VARCHAR2(20 BYTE) NOT NULL,
    doc_email VARCHAR2(45 BYTE) NOT NULL
);

ALTER TABLE doctor ADD CONSTRAINT doctor_pk PRIMARY KEY ( doc_id );

CREATE TABLE nurse (
    nur_id     CHAR(7 BYTE) NOT NULL,
    dep_no     CHAR(3 BYTE),
    nur_name   VARCHAR2(50 BYTE) NOT NULL,
    nur_birth  CHAR(10 BYTE) NOT NULL,
    nur_gender CHAR(1 BYTE) NOT NULL,
    nur_pos    VARCHAR2(50 BYTE) NOT NULL,
    nur_phone  CHAR(13 BYTE) NOT NULL,
    nur_email  VARCHAR2(50 BYTE)
);

ALTER TABLE nurse ADD CONSTRAINT nurse_pk PRIMARY KEY ( nur_id );

ALTER TABLE nurse ADD CONSTRAINT nur_phone__un UNIQUE ( nur_phone );

ALTER TABLE nurse ADD CONSTRAINT nur_email__un UNIQUE ( nur_email );

CREATE TABLE patient (
    pat_id    CHAR(7 BYTE) NOT NULL,
    doc_id    CHAR(7 BYTE),
    nur_id    CHAR(7 BYTE),
    pat_name  VARCHAR2(45 BYTE) NOT NULL,
    pat_jumin CHAR(14 BYTE) NOT NULL,
    pat_gen   CHAR(1 BYTE) NOT NULL,
    pat_addr  VARCHAR2(100 BYTE) NOT NULL,
    pat_phone VARCHAR2(45 BYTE) NOT NULL,
    pat_email VARCHAR2(45 BYTE),
    pat_job   VARCHAR2(45 BYTE)
);

ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY ( pat_id );

ALTER TABLE patient ADD CONSTRAINT pat_jumin_un UNIQUE ( pat_jumin );

ALTER TABLE patient ADD CONSTRAINT pat_phone__un UNIQUE ( pat_phone );

ALTER TABLE patient ADD CONSTRAINT pat_email__un UNIQUE ( pat_email );

CREATE TABLE treatment (
    treat_no       INTEGER NOT NULL,
    doc_id         CHAR(7 BYTE) NOT NULL,
    pat_id         CHAR(7 BYTE) NOT NULL,
    treat_desc     VARCHAR2(100 BYTE) NOT NULL,
    treat_datetime DATE NOT NULL
);

ALTER TABLE treatment
    ADD CONSTRAINT treatment_pk PRIMARY KEY ( treat_no,
                                              pat_id,
                                              doc_id );

ALTER TABLE chart
    ADD CONSTRAINT chart_treatment_fk
        FOREIGN KEY ( treat_no,
                      pat_id,
                      doc_id )
            REFERENCES treatment ( treat_no,
                                   pat_id,
                                   doc_id )
                ON DELETE CASCADE;

ALTER TABLE doctor
    ADD CONSTRAINT doctor_department_fk
        FOREIGN KEY ( dep_no )
            REFERENCES department ( dep_no )
                ON DELETE CASCADE;

ALTER TABLE nurse
    ADD CONSTRAINT nurse_department_fk
        FOREIGN KEY ( dep_no )
            REFERENCES department ( dep_no )
                ON DELETE CASCADE;

ALTER TABLE patient
    ADD CONSTRAINT patient_doctor_fk
        FOREIGN KEY ( doc_id )
            REFERENCES doctor ( doc_id )
                ON DELETE CASCADE;

ALTER TABLE patient
    ADD CONSTRAINT patient_nurse_fk
        FOREIGN KEY ( nur_id )
            REFERENCES nurse ( nur_id )
                ON DELETE CASCADE;

ALTER TABLE treatment
    ADD CONSTRAINT treatment_doctor_fk
        FOREIGN KEY ( doc_id )
            REFERENCES doctor ( doc_id )
                ON DELETE CASCADE;

ALTER TABLE treatment
    ADD CONSTRAINT treatment_patient_fk
        FOREIGN KEY ( pat_id )
            REFERENCES patient ( pat_id )
                ON DELETE CASCADE;

CREATE OR REPLACE TRIGGER fkntm_chart BEFORE
    UPDATE OF treat_no, pat_id, doc_id ON chart
BEGIN
    raise_application_error(-20225, 'Non Transferable FK constraint  on table chart is violated');
END;
/

CREATE OR REPLACE TRIGGER fknto_doctor BEFORE
    UPDATE OF dep_no ON doctor
    FOR EACH ROW
BEGIN
    IF :old.dep_no IS NOT NULL THEN
        raise_application_error(-20225, 'Non Transferable FK constraint doctor_department_FK on table doctor is violated');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER fknto_nurse BEFORE
    UPDATE OF dep_no ON nurse
    FOR EACH ROW
BEGIN
    IF :old.dep_no IS NOT NULL THEN
        raise_application_error(-20225, 'Non Transferable FK constraint nurse_department_FK on table nurse is violated');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER fknto_patient BEFORE
    UPDATE OF doc_id, nur_id ON patient
    FOR EACH ROW
BEGIN
    IF :old.doc_id IS NOT NULL THEN
        raise_application_error(-20225, 'Non Transferable FK constraint patient_doctor_FK on table patient is violated');
    END IF;

    IF :old.nur_id IS NOT NULL THEN
        raise_application_error(-20225, 'Non Transferable FK constraint patient_nurse_FK on table patient is violated');
    END IF;

END;
/

CREATE OR REPLACE TRIGGER fkntm_treatment BEFORE
    UPDATE OF doc_id, pat_id ON treatment
BEGIN
    raise_application_error(-20225, 'Non Transferable FK constraint  on table treatment is violated');
END;
/
INSERT INTO Department (dep_no, dep_name, dep_manager, dep_tel) VALUES ('101', '소아과', '김유신', '051-123-0101');
INSERT INTO Department (dep_no, dep_name, dep_manager, dep_tel) VALUES ('102', '내과', '김춘추', '051-123-0102');
INSERT INTO Department (dep_no, dep_name, dep_manager, dep_tel) VALUES ('103', '외과', '장보고', '051-123-0103');
INSERT INTO Department (dep_no, dep_name, dep_manager, dep_tel) VALUES ('104', '피부과', '선덕여왕', '051-123-0104');
INSERT INTO Department (dep_no, dep_name, dep_manager, dep_tel) VALUES ('105', '이비인후과', '강감찬', '051-123-0105');
INSERT INTO Department (dep_no, dep_name, dep_manager, dep_tel) VALUES ('106', '산부인과', '신사임당', '051-123-0106');
INSERT INTO Department (dep_no, dep_name, dep_manager, dep_tel) VALUES ('107', '흉부외과', '류성룡', '051-123-0107');
INSERT INTO Department (dep_no, dep_name, dep_manager, dep_tel) VALUES ('108', '정형외과', '송상현', '051-123-0108');
INSERT INTO Department (dep_no, dep_name, dep_manager, dep_tel) VALUES ('109', '신경외과', '이순신', '051-123-0109');
INSERT INTO Department (dep_no, dep_name, dep_manager, dep_tel) VALUES ('110', '비뇨기과', '정약용', '051-123-0110');
INSERT INTO Department (dep_no, dep_name, dep_manager, dep_tel) VALUES ('111', '안과', '박지원', '051-123-0111');
INSERT INTO Department (dep_no, dep_name, dep_manager, dep_tel) VALUES ('112', '치과', '전봉준', '051-123-0112');

INSERT INTO Doctor (doc_id, doc_name, doc_birth, doc_gen, dep_no, doc_pos, doc_phone, doc_email) VALUES ('D101101', '김유신', '1976-01-21', 'M', '101', '과장', '010-1101-1976', 'kimys@bw.com');
INSERT INTO Doctor (doc_id, doc_name, doc_birth, doc_gen, dep_no, doc_pos, doc_phone, doc_email) VALUES ('D101102', '계백', '1975-06-11', 'M', '101', '전문의', '010-1102-1975', 'gaeback@bw.com');
INSERT INTO Doctor (doc_id, doc_name, doc_birth, doc_gen, dep_no, doc_pos, doc_phone, doc_email) VALUES ('D101103', '김관창', '1989-05-30', 'M', '101', '전문의', '010-1103-1989', 'kwanch@bw.com');
INSERT INTO Doctor (doc_id, doc_name, doc_birth, doc_gen, dep_no, doc_pos, doc_phone, doc_email) VALUES ('D102101', '김춘추', '1979-04-13', 'M', '102', '과장', '010-2101-1979', 'kimcc@bw.com');
INSERT INTO Doctor (doc_id, doc_name, doc_birth, doc_gen, dep_no, doc_pos, doc_phone, doc_email) VALUES ('D102104', '이사부', '1966-09-12', 'M', '102', '전문의', '010-2104-1966', 'leesabu@bw.com');
INSERT INTO Doctor (doc_id, doc_name, doc_birth, doc_gen, dep_no, doc_pos, doc_phone, doc_email) VALUES ('D103101', '장보고', '1979-07-28', 'M', '103', '과장', '010-3101-1979', 'jangbg@bw.com');
INSERT INTO Doctor (doc_id, doc_name, doc_birth, doc_gen, dep_no, doc_pos, doc_phone, doc_email) VALUES ('D104101', '선덕여왕', '1984-06-15', 'F', '104', '과장', '010-4101-1984', 'gueen@bw.com');
INSERT INTO Doctor (doc_id, doc_name, doc_birth, doc_gen, dep_no, doc_pos, doc_phone, doc_email) VALUES ('D105101', '강감찬', '1965-10-21', 'M', '105', '과장', '010-5101-1965', 'kang@bw.com');
INSERT INTO Doctor (doc_id, doc_name, doc_birth, doc_gen, dep_no, doc_pos, doc_phone, doc_email) VALUES ('D106101', '신사임당', '1972-11-28', 'F', '106', '과장', '010-6101-1972', 'sinsa@bw.com');
INSERT INTO Doctor (doc_id, doc_name, doc_birth, doc_gen, dep_no, doc_pos, doc_phone, doc_email) VALUES ('D107103', '이이', '1992-09-07', 'M', '107', '전문의', '010-7103-1992', 'leelee@bw.com');
INSERT INTO Doctor (doc_id, doc_name, doc_birth, doc_gen, dep_no, doc_pos, doc_phone, doc_email) VALUES ('D107104', '이황', '1989-12-09', 'M', '107', '전문의', '010-7104-1989', 'hwang@bw.com');
INSERT INTO Doctor (doc_id, doc_name, doc_birth, doc_gen, dep_no, doc_pos, doc_phone, doc_email) VALUES ('D108101', '송상현', '1977-03-14', 'M', '108', '과장', '010-8101-1977', 'ssh@bw.com');

INSERT INTO Nurse (nur_id, nur_name, nur_birth, nur_gender, dep_no, nur_pos, nur_phone, nur_email) VALUES ('N101101', '송승헌', '1976-02-21', 'M', '101', '수간호사', '010-1101-7602', 'ssh@bw.com');
INSERT INTO Nurse (nur_id, nur_name, nur_birth, nur_gender, dep_no, nur_pos, nur_phone, nur_email) VALUES ('N102101', '이영애', '1975-07-11', 'F', '102', '수간호사', '010-1102-7507', 'yung@bw.com');
INSERT INTO Nurse (nur_id, nur_name, nur_birth, nur_gender, dep_no, nur_pos, nur_phone, nur_email) VALUES ('N102102', '엄정화', '1989-06-30', 'F', '102', '주임', '010-1103-8906', 'um@bw.com');
INSERT INTO Nurse (nur_id, nur_name, nur_birth, nur_gender, dep_no, nur_pos, nur_phone, nur_email) VALUES ('N102103', '박명수', '1979-05-13', 'M', '102', '주임', '010-2101-7905', 'park@bw.com');
INSERT INTO Nurse (nur_id, nur_name, nur_birth, nur_gender, dep_no, nur_pos, nur_phone, nur_email) VALUES ('N103101', '정준하', '1966-10-12', 'M', '103', '주임', '010-2104-6610', 'jung@bw.com');
INSERT INTO Nurse (nur_id, nur_name, nur_birth, nur_gender, dep_no, nur_pos, nur_phone, nur_email) VALUES ('N104101', '김태희', '1979-08-28', 'F', '104', '주임', '010-3101-7908', 'taeh@bw.com');
INSERT INTO Nurse (nur_id, nur_name, nur_birth, nur_gender, dep_no, nur_pos, nur_phone, nur_email) VALUES ('N105101', '송혜교', '1984-07-15', 'F', '105', '주임', '010-4101-8407', 'song@bw.com');
INSERT INTO Nurse (nur_id, nur_name, nur_birth, nur_gender, dep_no, nur_pos, nur_phone, nur_email) VALUES ('N106101', '공유', '1965-11-21', 'M', '106', '간호사', '010-5101-6511', 'gong@bw.com');
INSERT INTO Nurse (nur_id, nur_name, nur_birth, nur_gender, dep_no, nur_pos, nur_phone, nur_email) VALUES ('N107101', '이병헌', '1972-12-28', 'M', '107', '간호사', '010-6101-7212', 'byung@bw.com');
INSERT INTO Nurse (nur_id, nur_name, nur_birth, nur_gender, dep_no, nur_pos, nur_phone, nur_email) VALUES ('N108101', '송중기', '1992-10-07', 'M', '108', '간호사', '010-7103-9210', 'jungi@bw.com');

INSERT INTO Patient (pat_id, doc_id, nur_id, pat_name, pat_jumin, pat_gen, pat_addr, pat_phone, pat_email, pat_job) VALUES ('P102101', 'D102101', 'N102101', '정우성', '760121-1234567', 'M', '서울', '010-1101-7601', '', '배우');
INSERT INTO Patient (pat_id, doc_id, nur_id, pat_name, pat_jumin, pat_gen, pat_addr, pat_phone, pat_email, pat_job) VALUES ('P103101', 'D103101', 'N103101', '이정재', '750611-1234567', 'M', '서울', '010-1102-7506', '', '배우');
INSERT INTO Patient (pat_id, doc_id, nur_id, pat_name, pat_jumin, pat_gen, pat_addr, pat_phone, pat_email, pat_job) VALUES ('P102102', 'D102104', 'N102103', '전지현', '890530-1234567', 'F', '대전', '010-1103-8905', 'jjh@naver.com', '자영업');
INSERT INTO Patient (pat_id, doc_id, nur_id, pat_name, pat_jumin, pat_gen, pat_addr, pat_phone, pat_email, pat_job) VALUES ('P104101', 'D104101', 'N104101', '이나영', '790413-1234567', 'F', '대전', '010-2101-7904', 'lee@naver.com', '회사원');
INSERT INTO Patient (pat_id, doc_id, nur_id, pat_name, pat_jumin, pat_gen, pat_addr, pat_phone, pat_email, pat_job) VALUES ('P105101', 'D105101', 'N105101', '원빈', '660912-1234567', 'M', '대전', '010-2104-6609', 'one@daum.net', '배우');
INSERT INTO Patient (pat_id, doc_id, nur_id, pat_name, pat_jumin, pat_gen, pat_addr, pat_phone, pat_email, pat_job) VALUES ('P103102', 'D103101', 'N103101', '장동건', '790728-1234567', 'M', '대구', '010-3101-7907', 'jang@naver.com', '배우');
INSERT INTO Patient (pat_id, doc_id, nur_id, pat_name, pat_jumin, pat_gen, pat_addr, pat_phone, pat_email, pat_job) VALUES ('P104102', 'D104101', 'N104101', '고소영', '840615-1234567', 'F', '대구', '010-4101-8406', 'goso@daum.net', '회사원');
INSERT INTO Patient (pat_id, doc_id, nur_id, pat_name, pat_jumin, pat_gen, pat_addr, pat_phone, pat_email, pat_job) VALUES ('P108101', 'D108101', 'N108101', '김연아', '651021-1234567', 'F', '대구', '010-5101-6510', 'yuna@daum.net', '운동선수');
INSERT INTO Patient (pat_id, doc_id, nur_id, pat_name, pat_jumin, pat_gen, pat_addr, pat_phone, pat_email, pat_job) VALUES ('P102103', 'D102104', 'N102102', '유재석', '721128-1234567', 'M', '부산', '010-6101-7211', '', '개그맨');
INSERT INTO Patient (pat_id, doc_id, nur_id, pat_name, pat_jumin, pat_gen, pat_addr, pat_phone, pat_email, pat_job) VALUES ('P107101', 'D107104', 'N107101', '강호동', '920907-1234567', 'M', '부산', '010-7103-9209', '', '개그맨');
INSERT INTO Patient (pat_id, doc_id, nur_id, pat_name, pat_jumin, pat_gen, pat_addr, pat_phone, pat_email, pat_job) VALUES ('P105102', 'D105101', 'N105101', '조인성', '891209-1234567', 'M', '광주', '010-7104-8912', 'join@gmail.com', '배우');
INSERT INTO Patient (pat_id, doc_id, nur_id, pat_name, pat_jumin, pat_gen, pat_addr, pat_phone, pat_email, pat_job) VALUES ('P104103', 'D104101', 'N104101', '강동원', '770314-1234567', 'M', '광주', '010-8101-7703', 'dong@naver.com', '배우');

INSERT INTO Treatment (treat_no, doc_id, pat_id, treat_desc, treat_datetime) VALUES (1021001, 'D102101', 'P102101', '감기, 몸살', TO_DATE('2022-01-10 10:50:12'));
INSERT INTO Treatment (treat_no, doc_id, pat_id, treat_desc, treat_datetime) VALUES (1031002, 'D103101', 'P103101', '교통사고 외상', TO_DATE('2022-01-10 10:50:12'));
INSERT INTO Treatment (treat_no, doc_id, pat_id, treat_desc, treat_datetime) VALUES (1021003, 'D102104', 'P102102', '위염, 장염', TO_DATE('2022-01-10 10:50:12'));
INSERT INTO Treatment (treat_no, doc_id, pat_id, treat_desc, treat_datetime) VALUES (1041004, 'D104101', 'P104101', '피부 트러블', TO_DATE('2022-01-10 10:50:12'));
INSERT INTO Treatment (treat_no, doc_id, pat_id, treat_desc, treat_datetime) VALUES (1051005, 'D105101', 'P105101', '코막힘 및 비염', TO_DATE('2022-01-10 10:50:12'));
INSERT INTO Treatment (treat_no, doc_id, pat_id, treat_desc, treat_datetime) VALUES (1031006, 'D103101', 'P103102', '목 디스크', TO_DATE('2022-01-10 10:50:12'));
INSERT INTO Treatment (treat_no, doc_id, pat_id, treat_desc, treat_datetime) VALUES (1041007, 'D104101', 'P104102', '여드름', TO_DATE('2022-01-10 10:50:12'));
INSERT INTO Treatment (treat_no, doc_id, pat_id, treat_desc, treat_datetime) VALUES (1081008, 'D108101', 'P108101', '오른쪽 발목 뼈 골절', TO_DATE('2022-01-10 10:50:12'));
INSERT INTO Treatment (treat_no, doc_id, pat_id, treat_desc, treat_datetime) VALUES (1021009, 'D102104', 'P102103', '소화불량', TO_DATE('2022-01-10 10:50:12'));
INSERT INTO Treatment (treat_no, doc_id, pat_id, treat_desc, treat_datetime) VALUES (1071010, 'D107104', 'P107101', '가슴 통증', TO_DATE('2022-01-10 10:50:12'));
INSERT INTO Treatment (treat_no, doc_id, pat_id, treat_desc, treat_datetime) VALUES (1051011, 'D105101', 'P105102', '귀 이명', TO_DATE('2022-01-10 10:50:12'));
INSERT INTO Treatment (treat_no, doc_id, pat_id, treat_desc, treat_datetime) VALUES (1041012, 'D104101', 'P104103', '팔목 화상', TO_DATE('2022-01-10 10:50:12'));

INSERT INTO chart (chart_id, treat_no, doc_id, pat_id, chart_desc) VALUES ('C1021001', 1021001, 'D102101', 'P102101', '감기 주사 및 약 처방');
INSERT INTO chart (chart_id, treat_no, doc_id, pat_id, chart_desc) VALUES ('C1031002', 1031002, 'D103101', 'P103101', '입원 치료');
INSERT INTO chart (chart_id, treat_no, doc_id, pat_id, chart_desc) VALUES ('C1021003', 1021003, 'D102104', 'P102102', '위내시경');
INSERT INTO chart (chart_id, treat_no, doc_id, pat_id, chart_desc) VALUES ('C1041004', 1041004, 'D104101', 'P104101', '피부 감염 방지 주사');
INSERT INTO chart (chart_id, treat_no, doc_id, pat_id, chart_desc) VALUES ('C1051005', 1051005, 'D105101', 'P105101', '비염 치료');
INSERT INTO chart (chart_id, treat_no, doc_id, pat_id, chart_desc) VALUES ('C1031006', 1031006, 'D103101', 'P103102', '목 견인치료');
INSERT INTO chart (chart_id, treat_no, doc_id, pat_id, chart_desc) VALUES ('C1041007', 1041007, 'D104101', 'P104102', '여드름 치료약 처방');
INSERT INTO chart (chart_id, treat_no, doc_id, pat_id, chart_desc) VALUES ('C1081008', 1081008, 'D108101', 'P108101', '발목 깁스');
INSERT INTO chart (chart_id, treat_no, doc_id, pat_id, chart_desc) VALUES ('C1021009', 1021009, 'D102104', 'P102103', '주사 처방');
INSERT INTO chart (chart_id, treat_no, doc_id, pat_id, chart_desc) VALUES ('C1071010', 1071010, 'D107104', 'P107101', 'MRI 검사');
INSERT INTO chart (chart_id, treat_no, doc_id, pat_id, chart_desc) VALUES ('C1051011', 1051011, 'D105101', 'P105102', '귀 청소 및 약 처방');
INSERT INTO chart (chart_id, treat_no, doc_id, pat_id, chart_desc) VALUES ('C1041012', 1041012, 'D104101', 'P104103', '화상 크림약 처방');

--1
select d.doc_id,
d.doc_name,
d.doc_birth,
e.dep_no,
e.dep_name
from doctor d
join department e on e.dep_no = d.dep_no;

--2
select n.nur_id,
n.nur_name,
n.nur_birth,
e.dep_no,
e.dep_name
from nurse n
join department e on e.dep_no = n.dep_no;

--3
select p.pat_id,
p.pat_name,
p.pat_jumin,
p.pat_phone,
d.doc_name,
n.nur_name
from patient p
join doctor d on p.doc_id = d.doc_id
join nurse n on p.nur_id= n.nur_id;

--4
select p.pat_name as 환자이름,
d.doc_name as 담당의,
t.treat_desc as 진료내용,
c.chart_desc as 처방내용,
t.treat_datetime as 진료날
from treatment t
join patient p on t.pat_id = p.pat_id
join doctor d on t.doc_id = d.doc_id
join chart c on t.treat_no = c.treat_no;

--5
select t.treat_no as 진료번호,
p.pat_name as 이름,
d.doc_name as 담당의,
t.treat_desc as  진료내용,
c.chart_desc as 처방내용,
t.treat_datetime as 진료날
from treatment t
join patient p on t.pat_id = p.pat_id
join doctor d on t.doc_id = d.doc_id
join chart c on t.treat_no = c.treat_no
join department e on d.dep_no = e.dep_no
where e.dep_name = '외과';

--6
select t.treat_no as 진료번호,
p.pat_name as 이름,
d.doc_name as 담당의,
t.treat_desc as  진료내용,
c.chart_desc as 처방내용,
t.treat_datetime as 진료날
from treatment t
join patient p on t.pat_id = p.pat_id
join doctor d on t.doc_id = d.doc_id
join chart c on t.treat_no = c.treat_no
join department e on d.dep_no = e.dep_no
where t.treat_desc like '%화상%';

--7
select *
from patient;

--8 ???
select * from doctor;
SELECT 
	dep_manager,
	dep_name
FROM Department a
LEFT JOIN Doctor b ON a.dep_no = b.dep_no
WHERE doc_id IS NULL;

--9
select 
LISTAGG(p.pat_name, '^') WITHIN GROUP (ORDER BY p.pat_name)
from patient p
join nurse n on p.nur_id = n.nur_id
where n.nur_name = '김태희';

--10
select n.nur_id,
n.nur_name,
count(n.nur_id) as abc
from nurse n
join patient p on n.nur_id = p.nur_id
group by n.nur_id, n.nur_name
order by abc desc FETCH FIRST 1 ROWS ONLY;




-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             0
-- ALTER TABLE                             18
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           5
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
