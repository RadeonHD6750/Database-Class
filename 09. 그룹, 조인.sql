
---------------------------------------
-- JOIN 들어가기전
-- 나머지 집합연산 보기
---------------------------------------


-- 집합 연산자 중 UNION 살펴보기
CREATE TABLE exp_goods_asia (
       country VARCHAR2(10),
       seq     NUMBER,
       goods   VARCHAR2(80));
      
      
INSERT INTO exp_goods_asia VALUES ('한국', 1, '원유제외 석유류');
INSERT INTO exp_goods_asia VALUES ('한국', 2, '자동차');
INSERT INTO exp_goods_asia VALUES ('한국', 3, '전자집적회로');
INSERT INTO exp_goods_asia VALUES ('한국', 4, '선박');
INSERT INTO exp_goods_asia VALUES ('한국', 5,  'LCD');
INSERT INTO exp_goods_asia VALUES ('한국', 6,  '자동차부품');
INSERT INTO exp_goods_asia VALUES ('한국', 7,  '휴대전화');
INSERT INTO exp_goods_asia VALUES ('한국', 8,  '환식탄화수소');
INSERT INTO exp_goods_asia VALUES ('한국', 9,  '무선송신기 디스플레이 부속품');
INSERT INTO exp_goods_asia VALUES ('한국', 10,  '철 또는 비합금강');

INSERT INTO exp_goods_asia VALUES ('일본', 1, '자동차');
INSERT INTO exp_goods_asia VALUES ('일본', 2, '자동차부품');
INSERT INTO exp_goods_asia VALUES ('일본', 3, '전자집적회로');
INSERT INTO exp_goods_asia VALUES ('일본', 4, '선박');
INSERT INTO exp_goods_asia VALUES ('일본', 5, '반도체웨이퍼');
INSERT INTO exp_goods_asia VALUES ('일본', 6, '화물차');
INSERT INTO exp_goods_asia VALUES ('일본', 7, '원유제외 석유류');
INSERT INTO exp_goods_asia VALUES ('일본', 8, '건설기계');
INSERT INTO exp_goods_asia VALUES ('일본', 9, '다이오드, 트랜지스터');
INSERT INTO exp_goods_asia VALUES ('일본', 10, '기계류');


-- UNION
-- 중복제거 후 서로꺼 합해서 보여줌
SELECT goods
FROM EXP_GOODS_ASIA ega 
WHERE COUNTRY = '한국'
UNION
SELECT goods
FROM EXP_GOODS_ASIA ega 
WHERE COUNTRY = '일본';


-- 서로 같은 것만 보여줌
SELECT goods
FROM EXP_GOODS_ASIA ega 
WHERE COUNTRY = '한국'
INTERSECT --교집합
SELECT goods
FROM EXP_GOODS_ASIA ega 
WHERE COUNTRY = '일본';



-- 한국에서 일본품목을 제외 시킴
SELECT goods
FROM EXP_GOODS_ASIA ega 
WHERE COUNTRY = '한국'
MINUS -- 차집합
SELECT goods
FROM EXP_GOODS_ASIA ega 
WHERE COUNTRY = '일본';







---------------------------------------------------------
-- 대망의 JOIN
--------------------------------------------------------
-- 사원들의 부서명
-- 가장 기본적인 동등조인


-- [수업예제]
--옛 날 문법
SELECT e.EMP_NAME , e.DEPARTMENT_ID  AS "emp 부서번호",
d.DEPARTMENT_ID  AS "dept 부서번호",d.DEPARTMENT_NAME 
FROM EMPLOYEES e , DEPARTMENTS d 
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID;


-- 오늘날 표준문법 
SELECT e.EMP_NAME , e.DEPARTMENT_ID  AS "emp 부서번호",
d.DEPARTMENT_ID  AS "dept 부서번호",d.DEPARTMENT_NAME 

FROM EMPLOYEES e 

INNER JOIN DEPARTMENTS d 
ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID);







-- 테이블 분리하는 이유
-- 그래서 보여줄 때는 JOIN으로 합해야함
-- 이러한 귀찮은 과정을 하는 이유

--01. 중복 데이터 방지
--02. 데이터 일관성 유지
--03. 유지보수




-- [수업예제]
-- 동등조인
-- 판매된 제품명
-- 동등조인
SELECT s.PROD_ID , p.PROD_NAME , s.SALES_DATE 
FROM SALES s , PRODUCTS p 
WHERE s.PROD_ID = p.PROD_ID ;

-- [수업예제]
-- 동등 조인 INNER JOIN
SELECT s.PROD_ID , p.PROD_NAME , s.SALES_DATE 
FROM SALES s 
INNER JOIN PRODUCTS p 
ON (s.PROD_ID = p.PROD_ID);


-- [수업예제]
-- OUTER 조인
-- 사원들의 부서명 출력하시오.
-- 아니 그럼 부서가 없는 사람은 어카냐
-- 부서명을 NULL로 표기하여 출력한다.
SELECT e.EMP_NAME , d.DEPARTMENT_NAME 
FROM EMPLOYEES e 
LEFT JOIN DEPARTMENTS d 
ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID);

-- [수업예제]
SELECT e.EMP_NAME , d.DEPARTMENT_NAME 
FROM EMPLOYEES e, DEPARTMENTS d 
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID (+);



-- [연습문제]
-- EMPLOYEES, JOBS
-- 사원들의 직급명을 출력하시오.
-- LEFT JOIN
-- 옛 날 문법 or 표준문법 무관

SELECT e.EMP_NAME , j.JOB_TITLE 
FROM EMPLOYEES e
LEFT JOIN JOBS j 
ON (e.JOB_ID = j.JOB_ID);

-- 옛 날 문법 LEFT JOIN
SELECT e.EMP_NAME , j.JOB_TITLE 
FROM EMPLOYEES e, JOBS j 
WHERE e.JOB_ID = j.JOB_ID (+);






-- [연습문제]
-- 판매된 제품ID를 구매한 고객명
-- SALES, CUSTOMERS 테이블 사용
SELECT s.PROD_ID , c.CUST_NAME , s.SALES_DATE 
FROM SALES s 
INNER JOIN CUSTOMERS c 
ON (s.CUST_ID = c.CUST_ID);





-- [연습문제]
-- CUSTOMERS
-- COUNTRIES
-- 고객들의 나라명
SELECT cu.CUST_NAME , ct.COUNTRY_NAME 
FROM CUSTOMERS cu
INNER JOIN COUNTRIES ct
ON (cu.COUNTRY_ID = ct.COUNTRY_ID);






-- [연습문제]
-- SALES, CHANNELS
-- 판매된 제품들의 접근경로
SELECT s.CUST_ID , s.PROD_ID  , c.CHANNEL_DESC 
FROM SALES s 
INNER JOIN CHANNELS c 
ON (s.CHANNEL_ID = c.CHANNEL_ID);


-- [연습문제]
-- EMPLOYEES만 사용
-- 셀프조인
-- LEFT JOIN 사용하면 됨 
SELECT e.EMP_NAME AS "본인이름", m.EMP_NAME AS "상관이름"
FROM EMPLOYEES e 
LEFT JOIN EMPLOYEES m
ON e.MANAGER_ID = m.EMPLOYEE_ID ;











