

-- 데이터를 담을 밥그릇 만들기
CREATE TABLE ex01_01 (
	col1 varchar2(10),   -- 문자만 담을 수 있음
	col2 NUMBER         --  숫자만 담을 수 있음
);

-- 데이터 넣기
INSERT INTO ex01_01 (col1, col2)
VALUES('서지민', 1);


-- 데이터 오류 예제 (이건 오류가 나야함 ㅇㅇㅇ)
INSERT INTO ex01_01 (col1, col2)
VALUES(1, '서지민');


-- 데이터 형변환 예제 (이건 지 맘임 ㄹㅇ)
INSERT INTO ex01_01 (col1, col2)
VALUES('서지민', '1');
-- 형변환 == 다른 자료형이지만, 변환해줄께 봐준다
-- 암시적 형변환  -- 잠재적 요류


INSERT INTO ex01_01 (col1, col2)
VALUES('서지민', TO_NUMBER('1'));
-- 명시적 형변환 == 너 이거 변환해 (고의로 강제로)



--원하는 컬럼만 찝어서 넣기
INSERT INTO ex01_01 (col1)
VALUES(10);




-- 데이터 조회
SELECT *         -- *은 모든 컬럼 조회
FROM ex01_01;


-- 원하는 것만 찝어서 조회
SELECT col1 
FROM ex01_01;




-- 여기서는 날짜 다루기
CREATE TABLE EX01_02 (
	name varchar2(10),        -- 가입자 이름
	create_date DATE			-- 가입일
);

-- 날짜 데이터 넣기
INSERT INTO EX01_02 (name, create_date)
VALUES('jimin', '2024-05-22');


--여기서 문제
-- EX01_02테이블에서 날짜만 나오도록 하시오.

SELECT create_date
FROM EX01_02;



-- 현재 시간 입력하기 (초까지만)
-- SYSDATE
INSERT INTO EX01_02 VALUES('jimin', SYSDATE);

-- 보통은 이렇게 안함
INSERT INTO ex01_02 
VALUES('jimin', TO_DATE(
'2024-02-20 14:58:33',
'yyyy-MM-dd HH24:MI:SS'
));


-- 초정밀 시간 테이블
CREATE TABLE EX01_03(
	name varchar2(10), --가입자명
	create_date TIMESTAMP -- 가입일
);



-- EX01_03에 이름만 넣고 
-- 다음과 같이 모든 컬럼을 조회하시오.


INSERT INTO EX01_03(name)
VALUES('jimin');


SELECT *
FROM EX01_03;


-- 자 이제 초정밀 시간 넣기
INSERT INTO EX01_03 
VALUES('jimin', systimestamp);



--NOT NULL 제약조건
CREATE TABLE EX01_04 (
	name varchar2(10) NOT NULL, -- 곂쳐도 되나 반드시 필요
	phone_number varchar2(20)
);
-- 정상 데이터 입력
INSERT INTO EX01_04 (name, phone_number)
VALUES ('jimin', '010-1234-5678');

-- 난 이름 주기 싫다 - 응 안됨
INSERT INTO EX01_04 (phone_number)
VALUES ('010-1234-5678');

SELECT *
FROM EX01_04;



--NOT NULL 제약조건


--다음과 같은 조건으로 PERSON 테이블을 생성하고
-- name varchar(10)
-- phone_number varchar(20) NOT NULL
-- 조회하시오


CREATE TABLE PERSON (
	name varchar2(10), -- 곂쳐도 되나 반드시 필요
	phone_number varchar2(20) NOT NULL
);


INSERT INTO PERSON (phone_number)
VALUES ('010-1234-5678');

SELECT *
FROM PERSON;



-- 없어도 되나, 곂치면 안됨
-- UNIQUE
CREATE TABLE EX01_05 (
	name varchar2(10) NOT NULL, --무조건 있어야함
	phone_number varchar2(20) UNIQUE  -- 곂치면 안됨
);


-- 정상 데이터 입력
INSERT INTO EX01_05 (name, phone_number)
VALUES ('jimin', '010-1234-5678');


-- 제약조건에 부합하게 다음과 같이 데이터를 입력하시오.

INSERT INTO EX01_05 (name, phone_number)
VALUES ('jimin', '010-1234-0001');

INSERT INTO EX01_05 (name, phone_number)
VALUES ('jimin', '010-1234-0002');

INSERT INTO EX01_05 (name, phone_number)
VALUES ('jimin', '010-1234-0003');

SELECT *
FROM EX01_05;



-- 가장 중요한 PRIMARY KEY
-- 테이블당 기본키는 무조건 1개
-- 기본키는 다수의 컬럼으로도 이루질 수 있다. (멀티키)
CREATE TABLE EX01_06 (
	user_id VARCHAR(10) PRIMARY KEY, -- 곂처도 없어도 안됨
	name VARCHAR(10) NOT NULL,    -- 없으면 안됨
	phone_number VARCHAR(20) UNIQUE -- 곂이면 안됨
);

-- 회원가입 하는 코드
INSERT INTO EX01_06(user_id, name, phone_number)
VALUES('KM29A1', 'jimin', '010-1234-5678');



-- 각종 제약조건에 위해되지 않도록 하여
-- 다음과 같이 데이터 입력하셈 ㄱㄱㄱ



INSERT INTO EX01_06(user_id, name, phone_number)
VALUES('KM29A2', 'jimin', '010-1234-0001');

INSERT INTO EX01_06(user_id, name)
VALUES('KM29A3', 'jimin2');

SELECT *
FROM EX01_06;





-- 정해진 데이터만 받겠다 CHECK
CREATE TABLE EX01_07 (
	user_id VARCHAR(10) PRIMARY KEY, -- 곂처도 없어도 안됨
	name VARCHAR(10) NOT NULL,    -- 없으면 안됨
	phone_number VARCHAR(20) UNIQUE, -- 곂이면 안됨
	
	age NUMBER CONSTRAINT age_check
	CHECK ( age BETWEEN 18 AND 200)
);

-- 다음과 같이 입력하셈



INSERT INTO EX01_07(user_id, name, phone_number, age)
VALUES('KM29A5', 'jimin', '010-1234-0001', 20);

INSERT INTO EX01_07(user_id, name, phone_number , age)
VALUES('KM29A6', 'jimin5', '010-1234-0003', 20);


INSERT INTO EX01_07(user_id, name , age)
VALUES('KM29A7', 'jimin6', 50);

SELECT *
FROM EX01_07;



INSERT INTO EX01_07(user_id, name , age)
VALUES('KM29A8', 'jimin6', 500);



-- 이번엔 문자열 CHECK
CREATE TABLE EX01_08 (
	user_id VARCHAR(10) PRIMARY KEY, -- 곂처도 없어도 안됨
	
	name VARCHAR(10) NOT NULL,    -- 없으면 안됨
	
	phone_number VARCHAR(20) UNIQUE, -- 곂이면 안됨
	
	age NUMBER CONSTRAINT age_check2
	CHECK ( age BETWEEN 18 AND 200),
	
	kua VARCHAR2(10) CONSTRAINT kua_check
	CHECK (kua IN ('1유형', '2유형', '모름')) 
);


-- 정상 데이터
INSERT INTO EX01_08(user_id, name , age)
VALUES('KM29A2', 'jimin1', 20);


-- 비정상 데이터
INSERT INTO EX01_08(user_id, name , age, kua)
VALUES('KM29A3', 'jimin1', 20, '가자');



-- 지난 시간에 했던 거 복습

-- 다음과 같은 조건으로 테이블을 생성하고
-- 데이터를 입력하시오.
-- 테이블명 CAR
--serial_number number PRIMARY KEY, -- 곂처도 없어도 안됨	
--name VARCHAR(10) NOT NULL,    -- 없으면 안됨
--model_name VARCHAR(20) NOT NULL, -- 없으면 안됨
-- kind VARCHAR2(10) ('경차', '준중형', '중형') 값만 허용 



CREATE TABLE CAR (
	serial_number number PRIMARY KEY, -- 곂처도 없어도 안됨
	
	name VARCHAR(10) NOT NULL,    -- 없으면 안됨
	
	model_name VARCHAR(20) NOT NULL, -- 곂이면 안됨
	
	kind VARCHAR2(10) CONSTRAINT kind_check
	CHECK (kind IN ('경차', '준중형', '중형')) 
);

INSERT INTO CAR(serial_number, name, model_name, kind)
VALUES(4, '티코1', '티코', '경차');


INSERT INTO CAR(serial_number, name, model_name, kind)
VALUES(1, 'MD', 'AVANTE', '준중형');


INSERT INTO CAR(serial_number, name, model_name, kind)
VALUES(2, 'AD', 'AVANTE', '준중형');


INSERT INTO CAR(serial_number, name, model_name, kind)
VALUES(3, 'YF', 'SONATA', '중형');

INSERT INTO CAR(serial_number, name, model_name, kind)
VALUES(6, 'NF', 'SONATA', '대형');


SELECT *
FROM CAR;



-- 이번에는 DEFAULT
-- 굳이 입력하지 않아도 자동으로 입력해줌
CREATE TABLE EX01_09 (
	name varchar2(100) NOT NULL,
	create_date DATE DEFAULT SYSDATE
);

-- 기존 방식은 날짜를 사람이 일일이 확인해야됨
INSERT INTO EX01_09(name, create_date)
VALUES('jimin', '2024-05-23');


INSERT INTO EX01_09(name)
VALUES('jimin1');


SELECT *
FROM EX01_09;


CREATE TABLE EX01_10 (
	name varchar2(100) NOT NULL,
	salary NUMBER DEFAULT 4000, -- 연봉
	create_date DATE DEFAULT SYSDATE
);

INSERT INTO EX01_10(name) VALUES('jimin');

SELECT *
FROM EX01_10;


-- 테이블 만들기
/*
CREATE TABLE 테이블명 (
	컬럼명 자료형 제약조건,
	컬럼명 자료형 제약조건
); 
-- already exist 이미 있다는 것이니 안심
-- 누락된 우괄호는 대부분은 콤마
-- 관계형 어쩌구가 읎다 허면은 문법 안맞음
-- 것도 아니면 ㄹㅇ 찐으로 괄호 없는거지 뭐
*/

-- 데이터 입력
-- INSERT INTO 테이블명(컬럼명) VALUES (데이터);

-- 데이터 조회
/*
	SELECT 컬럼명, 컬럼명
	FROM 테이블명
 */






