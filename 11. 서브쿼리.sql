
-- 서브쿼리
-- 한번에 해결할 수 없을 때 사용하는 것
-- 한마디로 큰일 났을 때 사용함
-- 즉, DB 설계가 뭔가 잘못되어 있음

-- 사원들의 평균연봉 보다 많이 받는 사원들

--이런 기존의 방식으로는 안됨
SELECT e.EMP_NAME , e.SALARY 
FROM EMPLOYEES e 
WHERE e.SALARY > AVG(e.SALARY);

--적어도 오류는 안나지만 결과는 안나옴
SELECT e.EMP_NAME , e.SALARY 
FROM EMPLOYEES e 
GROUP BY e.EMP_NAME , e.SALARY 
HAVING e.SALARY > AVG(e.SALARY);



-- 사원들의 평균연봉   ---------- 1
-- 보다 많이 받는 사원들 --------  2


-- 01. 평균연봉이라는 특정값부터 알아내야함
SELECT AVG(e.SALARY) 
FROM EMPLOYEES e;


-- 02. 보다 많이 받는 사원들
SELECT e.EMP_NAME, e.SALARY 
FROM EMPLOYEES e
WHERE e.SALARY > 6422; 




-- EMPLOYEES
-- 평균연봉 보다 많이 받는 사원들
SELECT e.EMP_NAME, e.SALARY 
FROM EMPLOYEES e
WHERE e.SALARY > (
	-- 여기에 특정값으로 출력되는 쿼리 작성
	SELECT AVG(e.SALARY) 
	FROM EMPLOYEES e
); 





-- 첫번째 유형
-- SELECT에 들어가는 형태
-- 정상범주 아님, 긴급땜빵시 사용

SELECT a.employee_id
, a.emp_name
, a.department_id
----------------------------------------------------
, (SELECT dd.department_name
FROM departments dd
WHERE dd.department_id = a.department_id) AS dept_name
----------------------------------------------------
FROM employees a
WHERE a.salary >= 3000;



-- 두번째 유형
-- FROM에다가 들어가는 형태
-- 비교적 정상범주
-- 조인을 하려는데 뭔가 계속 오류 나고 안될 때
-- 주로 FULL JOIN나서 서브쿼리에서 먼저 처리하고 그 다음에 조인
SELECT a.employee_id
, a.emp_name
, a.department_id
, b.department_name

FROM employees a, (
SELECT *
FROM departments
WHERE department_id = 100 ) b

WHERE a.department_id = b.department_id;







-- 세번째 형태
-- WHERE -- 요거가 가장 정상
-- 특정값이 필요함
SELECT e.EMP_NAME, e.SALARY 
FROM EMPLOYEES e
WHERE e.SALARY > (
	-- 여기에 특정값으로 출력되는 쿼리 작성
	SELECT AVG(e.SALARY) 
	FROM EMPLOYEES e
); 

-- 서브쿼리 등장 배경
-- 처음부터 없던 거는 아니고 원래 있었는데
-- 고안됨
-- 자바와는 달리 절차실행 불가
-- 집합실행의 한계



-- 이름에 'es'가 포함되는 사람들 보다 많이
-- 받는 사람들
--

-- 01
SELECT e.EMP_NAME , e.SALARY 
FROM EMPLOYEES e 
WHERE e.EMP_NAME LIKE '%es%';


--02
SELECT e.EMP_NAME , e.SALARY 
FROM EMPLOYEES e 
WHERE e.SALARY > ANY(
	SELECT e.SALARY 
	FROM EMPLOYEES e 
	WHERE e.EMP_NAME LIKE '%es%'
);










---- 이름에 'es'가 포함되는 사람들이랑 같은
-- 연봉을 받는 사람들

SELECT e.EMP_NAME , e.SALARY 
FROM EMPLOYEES e 
WHERE e.SALARY IN (
	SELECT e.SALARY 
	FROM EMPLOYEES e 
	WHERE e.EMP_NAME LIKE '%es%'
);











---------------------------------------------------------------------
-- PROD_SUBCATEGORY_DESC카테고리명에 'R'이 포함된 제품군의 
-- PROD_SUBCATEGORY_ID
-- 접근경로별 판매실적 환율 1340
----------------------------------------------------------------------
-- PRODUCT, SALES, CHANNEL





SELECT c.CHANNEL_ID , c.CHANNEL_DESC , 
COUNT(s.CUST_ID),
TO_CHAR((SUM(s.AMOUNT_SOLD) * 1341 / 1000000), '999,999') AS "실적금액 (단위 : 백만원)"
FROM CHANNELS c , SALES s , PRODUCTS p 
WHERE s.CHANNEL_ID = c.CHANNEL_ID 
AND s.PROD_ID = p.PROD_ID 
AND p.PROD_SUBCATEGORY_ID  IN 
(
	SELECT p2.PROD_SUBCATEGORY_ID
	FROM PRODUCTS p2 
	WHERE p2.PROD_SUBCATEGORY_DESC  LIKE '%R%'
	GROUP BY p2.PROD_SUBCATEGORY_ID
)
GROUP BY c.CHANNEL_ID , c.CHANNEL_DESC;














---------------------------------------------------------------------
-- SALES 전체 평균 판매가AVG(AMOUNT_SOLD) 보다 
-- 판매된 가격이 높은 제품들 (제품군 아님)
-- GROUP BY로 중복제거 필요
-- 판매가 AMOUNT_SOLD
----------------------------------------------------------------------




SELECT p.PROD_ID , p.PROD_NAME , s.AMOUNT_SOLD AS "판매가" 
FROM SALES s , PRODUCTS p 
WHERE s.PROD_ID = p.PROD_ID 
AND s.AMOUNT_SOLD >
(
	SELECT AVG(s.AMOUNT_SOLD)
	FROM SALES s
)
-- GROUP BY가 뭐 꼭 집계할 때뿐 아니라 중복제거용으로도 사용할 수 있다.
-- 주로 부하를 덜어내기 위한 것으로 사용된다.
GROUP BY p.PROD_ID , p.PROD_NAME , s.AMOUNT_SOLD 
ORDER BY p.PROD_ID ASC;



-- 그럼 그냥 하면 안되냐
-- 되긴 하는데 어차피 중복된 것은 없기에
-- 1개씩 집합이 만들어진다.
-- 딱히 의미없는 행동, 오류 없음
-- 집계함수를 제외한
SELECT e.EMP_NAME , e.SALARY 
FROM EMPLOYEES e 
GROUP BY e.EMP_NAME , e.SALARY ;





-- 기획부 밑에 있는 부서들의 평균연봉
-- 보다 많이 받는 사람들


-- 기획부 밑에 있는 부서들 




SELECT d2.DEPARTMENT_NAME 
FROM DEPARTMENTS d2 
WHERE d2.PARENT_ID  = 90; -- 셀프조인 없이 야매








SELECT e.EMPLOYEE_ID , e.EMP_NAME , d.DEPARTMENT_NAME 
FROM EMPLOYEES e , DEPARTMENTS d
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID -- 메인쿼리 조인
--------------------------------------------------------------------------------
AND e.SALARY  > (

	SELECT AVG(e2.SALARY)
	FROM EMPLOYEES e2 , DEPARTMENTS d2 
	WHERE d2.DEPARTMENT_ID = e2.DEPARTMENT_ID 
	AND d2.PARENT_ID  = 90 -- 셀프조인 없이 야매
)
ORDER BY e.EMPLOYEE_ID;


-- 셀프조인 -- 기획부 밑에 있는 사람들부터 출력
-- 01
SELECT e.EMP_NAME , d.DEPARTMENT_NAME 
FROM EMPLOYEES e , DEPARTMENTS d , DEPARTMENTS p
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND d.PARENT_ID = p.DEPARTMENT_ID 
AND p.DEPARTMENT_NAME = '기획부';


-- 02. 사람들 알아 냈으니 이 사람들의 평균 구하기
-- 서브쿼리
SELECT AVG(e.SALARY)
FROM EMPLOYEES e , DEPARTMENTS d , DEPARTMENTS p
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND d.PARENT_ID = p.DEPARTMENT_ID 
AND p.DEPARTMENT_NAME = '기획부';



--03. ~~~~ 보다 많이 받는
SELECT e.EMPLOYEE_ID , e.EMP_NAME , d.DEPARTMENT_NAME 
FROM EMPLOYEES e , DEPARTMENTS d
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID -- 메인쿼리 조인
--------------------------------------------------------------------------------
AND e.SALARY  > (
	SELECT AVG(e.SALARY)
	FROM EMPLOYEES e , DEPARTMENTS d , DEPARTMENTS p
	WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID 
	AND d.PARENT_ID = p.DEPARTMENT_ID 
	AND p.DEPARTMENT_NAME = '기획부'
)
ORDER BY e.EMPLOYEE_ID;









---------------------------------------------------------------------
-- 제품이름PROD_NAME에 's'가 포함된 제품들의 최대 판매가 MAX(AMOUNT_SOLD) (1)
-- 보다 낮은 판매가 MAX(AMOUNT_SOLD) 제품들의 수량, 평균 판매가 AVG(s.AMOUNT_SOLD)(2)
----------------------------------------------------------------------




SELECT p.PROD_ID , p.PROD_NAME, COUNT(s.CUST_ID), AVG(s.AMOUNT_SOLD)
FROM SALES s, PRODUCTS p 
WHERE s.PROD_ID = p.PROD_ID 
AND s.AMOUNT_SOLD <
(
	SELECT MAX(s2.AMOUNT_SOLD)
	FROM SALES s2, PRODUCTS p2 
	WHERE s2.PROD_ID = p2.PROD_ID 
	AND p2.PROD_NAME LIKE '%s%'
)
GROUP BY p.PROD_ID , p.PROD_NAME
ORDER BY p.PROD_ID ASC;