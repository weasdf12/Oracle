create table department (                      --학과
    dep_no  number ,                           --학과번호
    college varchar(20),                       --단과대학
    dep_name   varchar(20),                       --학과
    dep_king varchar(20),                      --학과장
    dep_hp  char(12)                            --학과 연락처    
    );
CREATE TABLE student (            --학생
    std_no       NUMBER NOT NULL, -- 학번
    std_jumin    CHAR(14 BYTE) NOT NULL, -- 주민번호
    std_name     VARCHAR2(30 BYTE) NOT NULL, -- 학생이름
    std_eng_name VARCHAR2(30 BYTE), -- 영문명
    std_gen      CHAR(1 BYTE) NOT NULL, -- 성별
    std_nation   VARCHAR2(30 BYTE) DEFAULT '한국', -- 국적, DEFAULT 한국
    std_hp       CHAR(13 BYTE), -- 전번
    std_email    VARCHAR2(30 BYTE), -- 메일
    std_addr     VARCHAR2(50 BYTE), -- 주소
    dep_no   NUMBER NOT NULL, -- 학과번호
    pro_no   NUMBER NOT NULL -- 교수번호
    std_seq      NUMBER(4) NOT NULL,
    std_ent      NUMBER(4) NOT NULL
);
CREATE TABLE professor (
    pro_no           VARCHAR(10)   PRIMARY KEY,         -- 교수번호
    pro_name         VARCHAR(50)   NOT NULL,            -- 이름
    pro_jumin        CHAR(14)      UNIQUE,              -- 주민번호
    pro_hp           VARCHAR(15),                       -- 휴대폰
    pro_email        VARCHAR(100),                      -- 이메일
    dep_no              VARCHAR(100),                   -- 학과번호(join)
    position         VARCHAR(50),                       -- 직위
    status           VARCHAR(20),                       -- 재직여부
    appointment_date DATE                               -- 임용일
);
CREATE TABLE course (
    cs_id     NUMBER(10) NOT NULL,
    cs_name   VARCHAR2(50 BYTE) NOT NULL,
    cs_grade  NUMBER(1),
    cs_credit NUMBER(1),
    cs_dist   VARCHAR2(20 BYTE),
    cs_year   NUMBER(4) NOT NULL,
    cs_sem    NUMBER(1) NOT NULL,
    dep_no    NUMBER NOT NULL,
    pro_no    NUMBER NOT NULL,
    cs_seq    NUMBER(3) NOT NULL
);
ALTER TABLE professor MODIFY dep_no NUMBER;

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( std_no );

CREATE SEQUENCE student_std_seq_seq START WITH 1 MAXVALUE 9999 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER student_std_seq_trg
BEFORE INSERT ON student
FOR EACH ROW
BEGIN
  IF :NEW.std_seq IS NULL THEN
    :NEW.std_seq := student_std_seq_seq.NEXTVAL;
  END IF;

  -- 10자리 학번 = YYYY(4) * 10^6 + 학과(2) * 10^4 + 순번(4)
  :NEW.std_no := (:NEW.std_ent * 1000000)
               + (:NEW.std_dep_no * 10000)
               +  :NEW.std_seq;
END;
/
ALTER TABLE student
ADD CONSTRAINT uk_student_jumin
UNIQUE (std_jumin);

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( std_no );

ALTER TABLE student
    ADD CONSTRAINT dep_no FOREIGN KEY ( dep_no )
        REFERENCES department ( dep_no );
        
create table college(           --단과대학
    college varchar(20)
);
ALTER TABLE college ADD CONSTRAINT college_pk PRIMARY KEY ( college );
ALTER TABLE department
ADD CONSTRAINT fk_department_college
FOREIGN KEY (college)
REFERENCES college (college);


ALTER TABLE department
ADD CONSTRAINT uk_department_dep
UNIQUE (dep);

alter table professor 
add constraint 

ALTER TABLE professor
ADD CONSTRAINT fk_professor_dep
FOREIGN KEY (dep)
REFERENCES department (dep);


ALTER TABLE course ADD CONSTRAINT course_pk PRIMARY KEY ( cs_id );


ALTER TABLE course
    ADD CONSTRAINT course_department_fk FOREIGN KEY ( dep_no )
        REFERENCES department ( dep_no );

ALTER TABLE course
    ADD CONSTRAINT course_professor_fk FOREIGN KEY ( pro_no )
        REFERENCES professor ( pro_no );


CREATE SEQUENCE course_cs_seq_seq START WITH 1 MAXVALUE 999 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER course_cs_seq_trg
BEFORE INSERT ON course
FOR EACH ROW
BEGIN
  -- 순번 자동 세팅 (비었으면 시퀀스 사용)
  IF :NEW.cs_seq IS NULL THEN
    :NEW.cs_seq := course_cs_seq_seq.NEXTVAL;
  END IF;

  -- 10자리 cs_id = [dep_no(2)][cs_year(4)][cs_sem(1)][cs_seq(3)]
  :NEW.cs_id :=
        (:NEW.dep_no  * 100000000)  -- DD......
      + (:NEW.cs_year * 10000)      -- ....YYYY....
      + (:NEW.cs_sem  * 1000)       -- ........S...
      +  :NEW.cs_seq;               -- .........SSS
END;
/
SELECT 
    p.pro_no,             -- 교수번호
    p.pro_name,           -- 교수이름
    p.position,           -- 직위
    p.status,             -- 재직여부
    p.appointment_date,   -- 임용일
    d.dep_no,             -- 학과번호
    d.dep,                -- 학과명
    d.college             -- 단과대학
FROM 
    professor p
JOIN 
    department d
ON 
    TO_NUMBER(p.dep_no) = d.dep_no;










drop table department;
drop table professor;
drop table college;
drop table student;