-- 여기서부터 오늘 할 꺼



-- 테이블 삭제
CREATE TABLE faker(
	col1 varchar2(100)
);
INSERT INTO faker(col1) VALUES('sgrefagfrdeg');
SELECT * FROM faker;

-- 데이터 삭제하기 -- 밥그릇은 멀쩡
DELETE 
FROM faker;

-- 이제는 아예 통으로 싸아악 날리기
DROP TABLE faker;





-- 기존 테이블 수정하기
-- 수정용 테이블 만들기
CREATE TABLE EX01_12 (
	user_id VARCHAR(10) PRIMARY KEY, -- 곂처도 없어도 안됨
	name VARCHAR(10) NOT NULL,    -- 없으면 안됨
	phone_number VARCHAR(20) UNIQUE -- 곂이면 안됨
);


-- 01. 컬럼명 바꾸기
-- 데이터 타입은 유지
ALTER TABLE EX01_12 
RENAME COLUMN 
user_id TO member_id;

INSERT INTO EX01_12(member_id, name, phone_number)
VALUES ('ehtrehbtrgbterg', 'jimin', '010-1234');


-- 타입 변경
-- 자료형 크기 늘리기
ALTER TABLE EX01_12 
MODIFY member_id VARCHAR(100);

-- 그럼 줄이는건? 안됨 
-- 정확히는 이미 있는 데이터 크기에 맞춰서
-- 계산 후 줄어야함
-- 근데 그러느니 안하는게 낫다
ALTER TABLE EX01_12 
MODIFY member_id VARCHAR(50);


-- 그럼 아예 다른 자료형은 되나
-- 없으면 되는데
-- 이걸 바꿀 상황이면
-- 이미 수많은 데이터가 있음
ALTER TABLE EX01_12 
MODIFY member_id NUMBER;



-- 기존 테이블 가지고
-- 복붙하기
CREATE TABLE EMP2 -- EMP 
AS -- 뭘로 할거냐
-- 아래에 오는 코드가지고
SELECT *
FROM EMPLOYEES;

SELECT *
FROM EMP2;



-- VIEW는 실체하지 않는다.
-- 주로 보안용도로 사용
CREATE OR REPLACE VIEW emp_view 
AS
SELECT EMPLOYEE_ID, EMP_NAME, EMAIL
FROM EMP2;

-- 실제 컬럼 알 수 없음
-- 이것이 VIEW인지 table인지 모름
SELECT *
FROM emp_view;


CREATE TABLE EX01_11 (
	name varchar2(100) NOT NULL,
	salary NUMBER DEFAULT 4000, -- 연봉
	job_title varchar2(50) DEFAULT 'worker', -- 직급
	create_date DATE DEFAULT SYSDATE
);


INSERT INTO EX01_11(name) VALUES('jimin');
SELECT *
FROM EX01_11;

/*
double a = 3.14;
int b = a;

b에 값을 적으시오 
 */
SELECT *
FROM EX01_06;

-- 인덱스 (페이지 번호)는 기본적으로 자동생성
-- 크게 신경쓸일 없음
CREATE UNIQUE INDEX EX01_06_INDEX
ON EX01_06(USER_ID, phone_number);

DROP INDEX EX01_06_INDEX;



-- 시노님
-- 가명, 별명
CREATE OR REPLACE SYNONYM jimin
FOR EX01_06;

SELECT *
FROM jimin;



-- 시퀀스
-- 자동으로 채번 해줌
-- 그니까 자동으로 0부터 ~~~~ 100해줌
CREATE SEQUENCE user_seq
INCREMENT BY 1
START WITH 1
MINVALUE 1 --무슨일이 있어도 최솟값은 1
MAXVALUE 999999 -- 무슨일이 있어도 최댓값은 999999
NOCYCLE; -- 만약 끝까지 돌아도 반복 안하겠다.

-- 도착한 사람들을 기록하는 테이블
CREATE TABLE ARRIVAL(
	order_number NUMBER PRIMARY KEY, -- 도착순서
	name varchar2(10) NOT NULL,  -- 도착자 이름
	create_date DATE DEFAULT sysdate -- 도착시간
);

SELECT *
FROM ARRIVAL;

INSERT INTO ARRIVAL(order_number, name)
VALUES(user_seq.nextval, 'jimin');

DROP SEQUENCE user_seq;



-- 본격적인 SQL 시작
-- 헬 시작
-- 예제 테이블 사용
-- (예제용) 어느 회사에서 구축한 사내관리 DB
-- 2000년대초
-- DB계의 hellow world

-- 가장 기본적인 형태
SELECT *
FROM EMPLOYEES e ;



-- 행번호 출력 
-- 의사컬럼 중 하나 이며, 실존하는 컬럼은 아님
SELECT e.EMP_NAME, ROWNUM
FROM EMPLOYEES e

-- 행 마다 곂치지 않는 고유의 문자열 부여
SELECT e.EMP_NAME, ROWID
FROM EMPLOYEES e;


-- 사칙연산
-- 반영 안됨
SELECT e.EMP_NAME, e.SALARY, (e.SALARY + 1000)
FROM EMPLOYEES e;

SELECT e.EMP_NAME, e.SALARY, (e.SALARY * 2)
FROM EMPLOYEES e;

SELECT e.EMP_NAME, e.SALARY, (e.SALARY / 2)
FROM EMPLOYEES e;

SELECT e.EMP_NAME, e.SALARY, (e.SALARY - 500)
FROM EMPLOYEES e;


-- 문자열 검색
SELECT e.EMP_NAME
FROM EMPLOYEES e
WHERE e.EMP_NAME = 'Steven King';
-- 부등호 권고하지 않음


-- 출력할 때 정렬 시키기
SELECT e.EMPLOYEE_ID, e.EMP_NAME , e.SALARY
FROM EMPLOYEES e
ORDER BY e.EMP_NAME ASC;

SELECT e.EMPLOYEE_ID, e.EMP_NAME , e.SALARY
FROM EMPLOYEES e
ORDER BY e.EMP_NAME DESC;



-- 조건 추가
-- 사원번호가 정확히 200인 사람 조회
SELECT *
FROM EMPLOYEES e
WHERE e.EMPLOYEE_ID = 200;

-- 사원 번호가 200 이상인 사람 조회
SELECT *
FROM EMPLOYEES e
WHERE e.EMPLOYEE_ID >= 200;


SELECT e.EMPLOYEE_ID , e.EMP_NAME 
FROM EMPLOYEES e
WHERE e.EMPLOYEE_ID >= 200;

-- 연봉이 5000 이상인 사람들 조회
SELECT e.EMP_NAME, e.SALARY 
FROM EMPLOYEES e
WHERE e.SALARY  >= 10000;



-- 연봉이 5000이상이고,
-- 사원번호가 250 이상인 사람 조회
SELECT e.EMPLOYEE_ID , e.SALARY 
FROM EMPLOYEES e
WHERE e.SALARY  >= 5000
AND e.EMPLOYEE_ID > 250;


-- 연봉이 5000 이상 이거나 혹은,
-- 사원번호가 250 이상인 사람 조회
SELECT e.EMPLOYEE_ID , e.SALARY 
FROM EMPLOYEES e
WHERE e.SALARY  >= 5000
OR e.EMPLOYEE_ID > 250;



-- [연습문제]
-- EMPLOYEES에서
-- SALARY가 10000 미만이고,
-- MANAGER_ID가 100인 사원 조회
SELECT e.EMPLOYEE_ID , e.SALARY,
e.MANAGER_ID 
FROM EMPLOYEES e
WHERE e.SALARY  < 10000
AND e.MANAGER_ID = 100;




-- 어제 했던거 복습
-- [연습문제]
-- DEPARTMENTS에서
-- MANAGER_ID가 150 이상인 부서들 조회
SELECT d.DEPARTMENT_NAME , d.MANAGER_ID 
FROM DEPARTMENTS d 
WHERE d.MANAGER_ID >= 150
ORDER BY d.MANAGER_ID  ASC;



-- [연습문제]
-- PRODUCT에서
-- PROD_CATEGORY가 'Electronics'이고
-- PROD_MIN_PRICE가 100이상인 것들 조회

SELECT p.PROD_CATEGORY, p.PROD_NAME 
FROM PRODUCTS p
WHERE p.PROD_CATEGORY = 'Electronics'
AND PROD_MIN_PRICE >= 100;











































