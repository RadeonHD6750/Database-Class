

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


-- 연봉이 2000~3000에 해당 되는 사원수
SELECT COUNT(e.EMPLOYEE_ID) AS "사원수"
FROM EMPLOYEES e 
WHERE e.SALARY BETWEEN 2000 AND 3000;






-- EMPLOYEES에서 근속일이 5000~7000일에 해당 되는 사람들의 수
-- HIRE_DATE
SELECT COUNT(e.EMPLOYEE_ID) AS "사원수"
FROM EMPLOYEES e 
WHERE SYSDATE - e.HIRE_DATE BETWEEN 5000 AND 7000;


-- 집계함수만 나오고 있는데
-- 다른 컬럼이 나오고 싶으면 크림슨 발록에 해당되는
-- GROUP BY가 필요하다. 근데 너모 어려우니 당장은 ㅇㅇ


-- EMPLOYEES의
-- SALARY를 다음과 같이 출력하시오.
SELECT VARIANCE(e.SALARY) AS "연봉 분산",
STDDEV(e.SALARY) AS "표준편차"
FROM EMPLOYEES e ;






-- 집계함수가 아닌 타 컬럼은 왜 안되는가
SELECT AVG(e.SALARY), e.EMP_NAME 
FROM EMPLOYEES e ;



-- 부서별 평균연봉, 같은 부서끼리의 평균연봉
-- 드디어 일반 컬럼 가능
SELECT e.DEPARTMENT_ID , AVG(e.SALARY)
FROM EMPLOYEES e 
GROUP BY e.DEPARTMENT_ID ;





-- EMPLOYEES에서
-- SALARY부서별 최소 최대 
-- DEPARTMENT_ID
SELECT e.DEPARTMENT_ID ,
MIN(e.SALARY) AS "최소", MAX(e.SALARY) AS "최대"
FROM EMPLOYEES e     
GROUP BY e.DEPARTMENT_ID ;





-- HAVING절 가즈아

-- 부서별 평균연봉
SELECT e.DEPARTMENT_ID , AVG(e.SALARY)
FROM EMPLOYEES e 
WHERE AVG(e.SALARY) > 8000
GROUP BY e.DEPARTMENT_ID 
HAVING AVG(e.SALARY) > 8000;






-- EMPLOYEES에서
-- EMP_NAME에 'e'가 포함되고
-- MANAGER_ID별 평균연봉이 8000이상
SELECT e.MANAGER_ID , AVG(e.SALARY) AS "평균연봉"
FROM EMPLOYEES e 
WHERE e.EMP_NAME LIKE '%e%'
GROUP BY e.MANAGER_ID
HAVING  AVG(e.SALARY) > 8000;







--EMPLOYEES에서
--다음과 같이 출력하시오.

SELECT (e.SALARY || '를 받고 있는 사람은 ' || COUNT(e.EMPLOYEE_ID) || '명 입니다. ')AS "해당 연봉을 받는 사원수"
FROM EMPLOYEES e 
GROUP BY e.SALARY;







--EMPLOYEES에서
--다음과 같이 사원수가 짝수인 것만 출력하시오.

SELECT (e.SALARY || '를 받고 있는 사람은 ' || COUNT(e.EMPLOYEE_ID) || '명 입니다. ') AS "해당 연봉을 받는 사원수"
FROM EMPLOYEES e 
GROUP BY e.SALARY
HAVING MOD(COUNT(e.EMPLOYEE_ID), 2) = 0;






-- COUNTRIES에서 
-- COUNTRY_SUBREGION_ID 대륙ID, COUNTRY_SUBREGION 대륙명
-- COUNTRY_ID -- 나라 ID  COUNTRY_ID를 카운트하면 됨
SELECT c.COUNTRY_SUBREGION_ID AS "대륙ID" ,
c.COUNTRY_SUBREGION AS "대륙명", 
COUNT(c.COUNTRY_ID) AS "그 대륙에 있는 나라수"
FROM COUNTRIES c 
GROUP BY c.COUNTRY_SUBREGION_ID ,c.COUNTRY_SUBREGION ;







-- PRODUCTS
-- 제품군별 평균가 출력 환율 1330




SELECT p.PROD_CATEGORY_ID, p.PROD_CATEGORY,
(AVG(p.PROD_LIST_PRICE) *1330) AS "평균가"
FROM PRODUCTS p 
GROUP BY p.PROD_CATEGORY_ID, p.PROD_CATEGORY
ORDER BY p.PROD_CATEGORY_ID;




-- SALES테이블에서
-- [사용할 컬럼정보] SALES_DATE, (AMOUNT_SOLD)
-- 월별 매출액
-- 출력조건 (월별, 매출액)
-- 판매된 금액인 AMOUNT_SOLD를 전부 합하면 그것이 매출액
-- SUM 함수 사용하면 됨


SELECT (TO_CHAR(s.SALES_DATE, 'MM')) AS "월별",
SUM(s.AMOUNT_SOLD) AS "매출액"
FROM SALES s 
GROUP BY (TO_CHAR(s.SALES_DATE, 'MM'))
ORDER BY "월별" ASC;





-- SALES
-- [사용할 컬럼정보] SALES_DATE, SUM(AMOUNT_SOLD)
-- 6,7,8 월별 매출액, 6~8월간만
-- 출력조건 (월별, 매출액)
SELECT TO_CHAR(s.SALES_DATE, 'mm') AS "월별", SUM(s.AMOUNT_SOLD) AS "매출액"
FROM SALES s 
WHERE TO_CHAR(s.SALES_DATE, 'mm') BETWEEN 6 AND 8
GROUP BY TO_CHAR(s.SALES_DATE, 'mm');








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






-- EMPLOYEES에서 EMP_NAME 길이별 수
SELECT LENGTH(e.EMP_NAME) AS "이름 길이", 
COUNT(e.EMPLOYEE_ID) AS "길이가 같은 사람의 수"
FROM EMPLOYEES e 
WHERE e.EMPLOYEE_ID IS NOT NULL
GROUP BY LENGTH(e.EMP_NAME)
ORDER BY LENGTH(e.EMP_NAME);



-- EMPLOYEES에서 EMP_NAME의 뒷부분 길이별 수
-- 공백 여러개인 것 무시

SELECT LENGTH (SUBSTR(e.EMP_NAME, INSTR(e.EMP_NAME, ' ') + 1, LENGTH(e.EMP_NAME))) AS "가릴부분 길이",
COUNT(e.EMPLOYEE_ID)
FROM EMPLOYEES e
GROUP BY LENGTH (SUBSTR(e.EMP_NAME, INSTR(e.EMP_NAME, ' ') + 1, LENGTH(e.EMP_NAME)))
ORDER BY "가릴부분 길이";



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


