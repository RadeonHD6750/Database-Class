
-- 여기서 출발

-- 함수 등장 ! 고생의 시작

--절댓값 구하기
SELECT ABS(-10), ABS(10)
FROM DUAL;

-- 가장 가까운 정수 구하기
SELECT CEIL(10.1),  CEIL(10.5), CEIL(10.9)
FROM DUAL;

SELECT CEIL(10.1), CEIL(10.5), CEIL(10.9), 
FLOOR(10.1),  FLOOR(10.5), FLOOR(10.9)
FROM DUAL;

-- 굉장히 중요
-- ROUND(원본, 소수점 자릿수)
SELECT ROUND(10.1) AS "완전정수", 
ROUND(10.55, 1) AS "첫째자리", 
ROUND(10.111, 2) AS "둘째자리"
FROM DUAL;

-- 산술연산
SELECT (1 + 1) AS "귀요미", (2 * 3.14 * 7.62 * 0.5) AS "7.62mm 둘레"
FROM DUAL;



-- 다음 반지름 4, 높이 10 가지는
-- 원기둥의 부피를 구하시오. 
-- V=파이 * 반지름 제곱 * 높이 
-- 파이는 3.14

SELECT (3.14 * 4 * 4 * 10) AS "원기둥 부피"
FROM DUAL;




--EMPLOYEES에서
-- SALARY를 1.3% 감봉하고
-- 그 결과를 다음과 같이 출력
-- COMMISSION_PCT이 있는 사람만

--13.3% 감봉
SELECT e.SALARY AS "감봉전", 
ROUND(e.SALARY * 0.987, 1) AS "감봉후"
FROM EMPLOYEES e 
WHERE COMMISSION_PCT IS NOT NULL;





--TRUNC
SELECT ROUND(3.999, 2), TRUNC(3.999, 2) 
FROM DUAL;


-- POWER
SELECT POWER(2, 4), SQRT(2) 
FROM DUAL;


-- MOD
SELECT MOD(4, 2)
FROM DUAL;







-- EMPLOYEES에서
-- SALARY가 13의 배수인 사람들 조회
SELECT e.EMP_NAME , e.SALARY 
FROM EMPLOYEES e 
WHERE MOD(e.SALARY, 13) = 0; 








-- EMPLOYEES에서
-- SALARY가 홀수인 사람들 조회
SELECT e.EMP_NAME , e.SALARY 
FROM EMPLOYEES e 
WHERE MOD(e.SALARY, 2) = 1; 






-- EMPLOYEES에서
-- SALARY의 백의자리수가 4인 사람
SELECT e.EMP_NAME , e.SALARY ,
MOD(e.SALARY, 1000) AS "첫단계 :백자리까지만 출력",
(MOD(e.SALARY, 1000) / 100) AS "둘째단계",
TRUNC(MOD(e.SALARY, 1000) / 100) AS "최종"
FROM EMPLOYEES e 
WHERE TRUNC(MOD(e.SALARY, 1000) / 100) = 4;












-- EMPLOYEES에서
-- SALARY의 천의자리수가 2의 배수인 사람

SELECT e.EMP_NAME , e.SALARY ,
MOD(e.SALARY, 10000) AS "첫단계 :백자리까지만 출력",
(MOD(e.SALARY, 10000) / 1000) AS "둘째단계",
TRUNC(MOD(e.SALARY, 10000) / 1000) AS "최종"
FROM EMPLOYEES e 
WHERE MOD(TRUNC(MOD(e.SALARY, 10000) / 1000), 2) = 0
AND MOD(e.SALARY, 10000) > 0;



-- 이제는 문자열 다루기 함수
-- 첫문자는 대문자로 나머지는 소문자로
-- emp_name -> C/C++
-- 'emp_name' -> empName => 카멜케이스  자바
-- 'emp_name' -> EmpName -> 파스칼링    C#
SELECT INITCAP('emp_name') -- 파스칼링
FROM DUAL;


--싹다 소문자, 싹다 대문자
SELECT LOWER('AbCd'), UPPER('AbCd') 
FROM DUAL;



SELECT CONCAT('1234', '5678') , '1234'|| '5678'
FROM DUAL;


-- 중요한 SUBSTR
SELECT SUBSTR('123456', 2, 3)
FROM DUAL;




-- EMPLOYEES에서
-- PHONE_NUMBER를 다음과 같이 출력하시오
-- 4칸짜리는 무시
SELECT e.EMP_NAME , e.PHONE_NUMBER, 
SUBSTR(e.PHONE_NUMBER , 5, 3) AS "가운데만 출력"
FROM EMPLOYEES e ;





-- EMPLOYEES에서
-- PHONE_NUMBER를 다음과 같이 출력하시오
-- 4칸짜리는 무시

SELECT e.EMP_NAME , e.PHONE_NUMBER, 
SUBSTR(e.PHONE_NUMBER , 9, 4) AS "가운데만 출력"
FROM EMPLOYEES e ;





-- EMPLOYEES에서
-- PHONE_NUMBER의 끝자리가 짝수인 것 출력
-- 4개 짜리 무시




SELECT e.EMP_NAME , e.PHONE_NUMBER, 
SUBSTR(e.PHONE_NUMBER , 12, 1) AS "끝자리만 출력"
FROM EMPLOYEES e 
WHERE MOD(SUBSTR(e.PHONE_NUMBER , 12, 1), 2) = 0
AND SUBSTR(e.PHONE_NUMBER , 12, 1) > 0;










