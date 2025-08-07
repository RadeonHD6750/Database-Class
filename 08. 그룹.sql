

-- 그룹 시작

-- 해당 컬럼에 있는 데이터 갯수
SELECT COUNT(e.EMPLOYEE_ID)
FROM EMPLOYEES e ;

-- 해당 컬럼에 들어 있는 데이터 평균
-- 본 예제에서는 평균 연봉
SELECT AVG(e.SALARY)
FROM EMPLOYEES e ;


-- 데이터 차제는 많으나
-- 최솟값이라는 그 한개만 필요한거임 ㅇㅇ
-- 최댓값이라는 그 한개만 필요한거임 ㅇㅇ
SELECT MIN(e.SALARY) AS "최솟값", MAX(e.SALARY) AS "최댓값"
FROM EMPLOYEES e ;

-- [연습문제]
-- 연봉이 2000~3000에 해당 되는 사원수
SELECT COUNT(e.EMPLOYEE_ID) AS "사원수"
FROM EMPLOYEES e 
WHERE e.SALARY BETWEEN 2000 AND 3000;


-- [연습문제]
-- EMPLOYEES에서 근속일이 5000~7000일에 해당 되는 사람들의 수
-- HIRE_DATE
SELECT COUNT(e.EMPLOYEE_ID) AS "사원수"
FROM EMPLOYEES e 
WHERE SYSDATE - e.HIRE_DATE BETWEEN 5000 AND 7000;


-- EMPLOYEES의
-- SALARY를 다음과 같이 출력하시오.
SELECT VARIANCE(e.SALARY) AS "연봉 분산",
STDDEV(e.SALARY) AS "표준편차"
FROM EMPLOYEES e ;


--EMPLOYEES의
--SALARY 총합계를 계산하여 연간 인건비를 구하시오
SELECT SUM(e.SALARY) AS "연간 인건비"
FROM EMPLOYEES e ;



-- [연습문제]
-- PRODUCT에서
-- PROD_LIST_PRICE를 모두 합산하여 총 판매단가를 구하고
-- PROD_LIST_PRICE의 평균 판매가를 구하시오.
SELECT SUM(p.PROD_LIST_PRICE) AS "총 판매단가",
AVG(p.PROD_LIST_PRICE) AS "평균 판매가"
FROM PRODUCTS p ;




-- [연습문제]
-- JOBS에서
-- JOB_ID의 갯수를 파악하여 얼마나 많은 직책이 있는지 알아내시오
SELECT COUNT( j.JOB_ID) AS "직책수"
FROM JOBS j ;



-- [연습문제]
-- DEPARTMENTS에서
-- DEPARTMENT_ID의 갯수를 파악하여 얼마나 많은 부서가 있는지 알아내시오
SELECT COUNT( d.DEPARTMENT_ID) AS "부서수"
FROM DEPARTMENTS d;


-- [연습문제]
-- SALES에서 판매된 금액인 AMOUNT_SOLD를 통하여
-- 최종 매출액을 알아내시오.
SELECT SUM(s.AMOUNT_SOLD ) AS "최종 매출액"
FROM SALES s ;



-- 집계함수만 나오고 있는데
-- 다른 컬럼이 나오고 싶으면 크림슨 발록에 해당되는
-- GROUP BY가 필요하다
-- 집계함수가 아닌 타 컬럼은 왜 안되는가
SELECT AVG(e.SALARY), e.EMP_NAME 
FROM EMPLOYEES e ;



-- 부서별 평균연봉, 같은 부서끼리의 평균연봉
-- 드디어 일반 컬럼 가능
SELECT e.DEPARTMENT_ID , AVG(e.SALARY)
FROM EMPLOYEES e 
GROUP BY e.DEPARTMENT_ID ;




-- [연습문제]
-- EMPLOYEES에서
-- SALARY부서별 최소 최대 
-- DEPARTMENT_ID
SELECT e.DEPARTMENT_ID ,
MIN(e.SALARY) AS "최소", MAX(e.SALARY) AS "최대"
FROM EMPLOYEES e     
GROUP BY e.DEPARTMENT_ID ;




--부서별 평균연봉
SELECT AVG(e.SALARY ), COUNT(e.EMPLOYEE_ID ), e.DEPARTMENT_ID
FROM EMPLOYEES e 
GROUP BY e.DEPARTMENT_ID;



-- EMPLOYEES
-- 같은 연봉(SALARY)을 받는 사원수
SELECT e.SALARY, COUNT(e.EMPLOYEE_ID )  AS "사원수"
FROM EMPLOYEES e 
GROUP BY e.SALARY;





-- [연습문제]
-- EMPLOYEES에서
-- 부서별 최소 최대 연봉
-- DEPARTMENT_ID
SELECT e.DEPARTMENT_ID ,
MIN(e.SALARY) AS "최소", MAX(e.SALARY) AS "최대"
FROM EMPLOYEES e     
GROUP BY e.DEPARTMENT_ID
ORDER BY e.DEPARTMENT_ID ASC;




-- [연습문제]
-- EMPLOYEES에서
-- 직책별 JOB_ID 사원수


SELECT e.JOB_ID , COUNT(e.EMPLOYEE_ID ) AS "사원수"
FROM EMPLOYEES e
GROUP BY e.JOB_ID
ORDER BY "사원수" ASC;









-- [연습문제]
-- CUSTOMERS
-- 국가별 고객수
SELECT c.COUNTRY_ID AS "국가아이디", COUNT(c.CUST_ID) AS "고객수"
FROM CUSTOMERS c 
GROUP BY c.COUNTRY_ID;




-- [연습문제]
-- COUNTRIES
-- 대륙별 국가수



SELECT c.COUNTRY_REGION AS "대륙명", COUNT(c.COUNTRY_ID ) AS "국가수"
FROM COUNTRIES c 
GROUP BY c.COUNTRY_REGION;




-- SALES
-- 판매한 사원별 총 매출
SELECT s.EMPLOYEE_ID AS "판매한 사원 번호", SUM(s.AMOUNT_SOLD) AS "총 매출"
FROM SALES s 
GROUP BY s.EMPLOYEE_ID;



-- SALES
-- 판매된 제품별 총매출액
SELECT s.PROD_ID  AS "판매된 제품ID", SUM(s.AMOUNT_SOLD) AS "총 매출"
FROM SALES s 
GROUP BY s.PROD_ID 
ORDER BY "총 매출" DESC;






-- PRODUCTS
-- 카테고리별 제품수

SELECT p.PROD_CATEGORY AS "카테고리", COUNT(p.PROD_ID ) AS "제품수"
FROM PRODUCTS p 
GROUP BY p.PROD_CATEGORY
ORDER BY "제품수" DESC;





-- 판매경로별 매출액
SELECT s.CHANNEL_ID  AS "판매경로", SUM(s.AMOUNT_SOLD ) AS "매출액"
FROM SALES s 
GROUP BY s.CHANNEL_ID 
ORDER BY s.CHANNEL_ID ASC;



-- [연습문제]
--EMPLOYEES에서
--다음과 같이 출력하시오.

SELECT (e.SALARY || '를 받고 있는 사람은 ' || COUNT(e.EMPLOYEE_ID) || '명 입니다. ')AS "해당 연봉을 받는 사원수"
FROM EMPLOYEES e 
GROUP BY e.SALARY;

-- [연습문제]
-- EMPLOYEES에서
-- MANAGER_ID별(같은 팀장을 두고 있는 사람들의) 평균연봉
SELECT e.MANAGER_ID, AVG(e.SALARY) AS "평균연봉"
FROM EMPLOYEES e 
GROUP BY e.MANAGER_ID
ORDER BY e.MANAGER_ID ;



--------------------------------------
-- 컬럼 여러개 묶기
---------------------------------------
-- 집계함수를 제외한 컬럼이 이제는 여러개
-- 제각각이면 경우의 수로 뭉쳐기게 되어
-- 잘 보고 결합할 것
-- PRODUCTS
SELECT p.PROD_CATEGORY_ID, p.PROD_CATEGORY,
(SUM(p.PROD_LIST_PRICE)) AS "제품군별 총 판매가"
FROM PRODUCTS p 
GROUP BY p.PROD_CATEGORY_ID, p.PROD_CATEGORY
ORDER BY p.PROD_CATEGORY_ID;


-- [연습문제]
-- COUNTRIES
-- 대륙별 국가수
-- 보통은 FK로 되어 다른 테이블에 존재함
SELECT c.COUNTRY_REGION_ID, c.COUNTRY_REGION, COUNT(c.COUNTRY_ID) AS "국가수"
FROM COUNTRIES c
GROUP BY c.COUNTRY_REGION_ID, c.COUNTRY_REGION;


-- [연습문제]
-- COUNTRIES
-- '상세' 대륙별 국가수
-- 보통은 FK로 되어 다른 테이블에 존재함
SELECT c.COUNTRY_SUBREGION_ID, c.COUNTRY_SUBREGION, COUNT(c.COUNTRY_ID) AS "국가수"
FROM COUNTRIES c
GROUP BY c.COUNTRY_SUBREGION_ID, c.COUNTRY_SUBREGION;




--------------------------------------
-- HAVING절 가즈아
---------------------------------------


-- 부서별 평균연봉
SELECT e.DEPARTMENT_ID , AVG(e.SALARY)
FROM EMPLOYEES e 
WHERE AVG(e.SALARY) > 8000
GROUP BY e.DEPARTMENT_ID 
HAVING AVG(e.SALARY) > 8000;





-- [연습문제]
-- EMPLOYEES에서
-- EMP_NAME에 'e'가 포함되고
-- 무조건 MANAGER_ID가 있어야 하며
-- MANAGER_ID별 평균연봉이 8000이상
SELECT e.MANAGER_ID, AVG(e.SALARY) AS "평균연봉"
FROM EMPLOYEES e 
WHERE e.EMP_NAME LIKE '%e%'
AND e.MANAGER_ID IS NOT NULL
GROUP BY e.MANAGER_ID
HAVING  AVG(e.SALARY) > 8000
ORDER BY e.MANAGER_ID;



-- [연습문제]
--EMPLOYEES에서
--다음과 같이 사원수가 짝수인 것만 출력하시오.

SELECT (e.SALARY || '를 받고 있는 사람은 ' || COUNT(e.EMPLOYEE_ID) || '명 입니다. ') AS "해당 연봉을 받는 사원수"
FROM EMPLOYEES e 
GROUP BY e.SALARY
HAVING MOD(COUNT(e.EMPLOYEE_ID), 2) = 0;




-- SALES테이블에서
-- [사용할 컬럼정보] SALES_DATE, (AMOUNT_SOLD)
-- 월별 매출액
-- 출력조건 (월별, 매출액)
-- 판매된 금액인 AMOUNT_SOLD를 전부 합하면 그것이 매출액
-- SUM 함수 사용하면 됨

-- [연습문제]
SELECT (TO_CHAR(s.SALES_DATE, 'MM')) AS "월별",
SUM(s.AMOUNT_SOLD) AS "매출액"
FROM SALES s 
GROUP BY (TO_CHAR(s.SALES_DATE, 'MM'))
ORDER BY "월별" ASC;




-- [연습문제]
-- SALES
-- [사용할 컬럼정보] SALES_DATE, SUM(AMOUNT_SOLD)
-- 6,7,8 월별 매출액, 6~8월간만
-- 출력조건 (월별, 매출액)
SELECT TO_CHAR(s.SALES_DATE, 'mm') AS "월별", SUM(s.AMOUNT_SOLD) AS "매출액"
FROM SALES s 
WHERE TO_CHAR(s.SALES_DATE, 'mm') BETWEEN 6 AND 8
GROUP BY TO_CHAR(s.SALES_DATE, 'mm');




-- [연습문제]
-- SALES 사원별 총판매실적 
-- [사용할 컬럼정보] EMPLOYEE_ID, AMOUNT_SOLD
-- 출력조건 (사번, 총판매실적)
-- 합계 1400000달러 이상만
-- 출력은 환율 1385 적용해서
SELECT s.EMPLOYEE_ID , SUM(s.AMOUNT_SOLD) * 1385 AS "실적금액"
FROM SALES s 
GROUP BY s.EMPLOYEE_ID
HAVING SUM(s.AMOUNT_SOLD)  >= 1400000
ORDER BY s.EMPLOYEE_ID;





-- [연습문제]
-- EMPLOYEES에서 EMP_NAME 길이별 수
SELECT LENGTH(e.EMP_NAME) AS "이름 길이", 
COUNT(e.EMPLOYEE_ID) AS "길이가 같은 사람의 수"
FROM EMPLOYEES e 
GROUP BY LENGTH(e.EMP_NAME)
ORDER BY LENGTH(e.EMP_NAME);




-- [연습문제]
-- EMPLOYEES에서 PHONE_NUMBER 길이별 수
SELECT LENGTH(e.PHONE_NUMBER ) AS "전화번호 길이", 
COUNT(e.EMPLOYEE_ID) AS "길이가 같은 사람의 수"
FROM EMPLOYEES e 
GROUP BY LENGTH(e.PHONE_NUMBER )
ORDER BY LENGTH(e.PHONE_NUMBER );


-- [연습문제]
-- EMPLOYEES에서 EMP_NAME의 뒷부분 길이별 수
-- 공백 여러개인 것 무시

SELECT LENGTH (SUBSTR(e.EMP_NAME, INSTR(e.EMP_NAME, ' ') + 1, LENGTH(e.EMP_NAME))) AS "가릴부분 길이",
COUNT(e.EMPLOYEE_ID)
FROM EMPLOYEES e
GROUP BY LENGTH (SUBSTR(e.EMP_NAME, INSTR(e.EMP_NAME, ' ') + 1, LENGTH(e.EMP_NAME)))
ORDER BY "가릴부분 길이";



-- [연습문제]
-- EMPLOYEES에서 EMP_NAME의 공백위치가 같은 사람들 수
-- 공백 여러개인 것 무시
SELECT INSTR(e.EMP_NAME, ' ') AS "공백위치",
COUNT(e.EMPLOYEE_ID) AS "같은 사원수"
FROM EMPLOYEES e
GROUP BY INSTR(e.EMP_NAME, ' ')
ORDER BY INSTR(e.EMP_NAME, ' ');












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



SELECT goods
  FROM exp_goods_asia
 WHERE country = '한국'
UNION -- 양측 쿼리에서 중복제거하고 합하기
SELECT goods
  FROM exp_goods_asia
 WHERE country = '일본';


