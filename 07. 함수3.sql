

-- 날짜 함수

-- 현재시간 출력
SELECT SYSDATE 
FROM DUAL;

-- ADD_MONTHS 개월수 다루기
--윤년, 윤달, 윤초 자동 보정
-- 2월달 경우 28 29 이상한 것도 알아서 함 ㅇㅇ
SELECT ADD_MONTHS(SYSDATE, 6) ,
ADD_MONTHS(SYSDATE, -1)
FROM DUAL;


-- 두 날짜간 개월 수 차이
SELECT MONTHS_BETWEEN(SYSDATE, '2024-11-30'),
MONTHS_BETWEEN('2024-11-30', SYSDATE)
FROM DUAL;


-- 일 차이 계산
SELECT TO_DATE('2024-11-30') - SYSDATE 
FROM DUAL;







--EMPLOYEES에서
-- HIRE_DATE로부터 지금 이 순간까지
-- 300개월이 넘는 사람
SELECT e.EMP_NAME , e.HIRE_DATE ,
MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) AS "근속개월수"
FROM EMPLOYEES e 
WHERE MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) > 300;


-- 입력된 시간을 기준으로 하여
-- 당월의 마지막 날
SELECT LAST_DAY(e.HIRE_DATE)
FROM EMPLOYEES e ;



-- ROUND -- 날짜도 결국 숫자이기에 사용가능
SELECT e.EMP_NAME , e.HIRE_DATE ,
MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) AS "근속개월수",
ROUND(MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE))
FROM EMPLOYEES e ;






--EMPLOYEES에서
-- HIRE_DATE로부터 지금 이 순간까지
-- 근속일 수가 짝수인 사람

-- 숫자형식으로 취급하여 하는 방법
SELECT e.EMP_NAME , e.HIRE_DATE ,
(SYSDATE - e.HIRE_DATE) AS "근속일"
FROM EMPLOYEES e 
WHERE MOD(ROUND(SYSDATE - e.HIRE_DATE), 2) = 0;

-- 날짜형식으로 취급하겠따
SELECT e.EMP_NAME , e.HIRE_DATE ,
(TO_DATE(SYSDATE) - e.HIRE_DATE) AS "근속일"
FROM EMPLOYEES e 
WHERE MOD(TO_DATE(SYSDATE) - e.HIRE_DATE, 2) = 0;



-- 현재날짜 기준으로
-- 차주의 요일에 해당 하는 날짜 알랴줌
SELECT NEXT_DAY(SYSDATE, '월'), 
NEXT_DAY(SYSDATE, '화')
FROM DUAL;







-- 변환하기 --중요
SELECT SYSDATE AS "현재시간",
TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "변환1",
TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS "변환2",
TO_CHAR(SYSDATE, 'MM') AS "변환3",
TO_CHAR(SYSDATE, 'DDD') AS "변환4"
FROM DUAL;






-- [연습문제]
-- EMPLOYEES에서
-- HIRE_DATE 3의 배수에 해당되는 달에 입사한 사람

SELECT e.EMP_NAME , TO_CHAR(e.HIRE_DATE , 'MM') AS "입사월"
FROM EMPLOYEES e 
WHERE MOD(TO_CHAR(e.HIRE_DATE , 'MM'), 3) = 0;


-- [연습문제]
-- 윤년인 해, 2월에 입사한 사람
SELECT e.EMP_NAME , (e.HIRE_DATE) AS "입사날", 
LAST_DAY(e.HIRE_DATE )
FROM EMPLOYEES e
WHERE TO_CHAR(LAST_DAY(e.HIRE_DATE) , 'mm-dd') = '02-29';



-- [연습문제]
-- 연도, 월 상관없이 10일부터 20일 사이에 입사한 사람
SELECT e.EMP_NAME , (e.HIRE_DATE) AS "입사날"
FROM EMPLOYEES e
WHERE TO_CHAR(e.HIRE_DATE , 'dd')BETWEEN 10 AND 20;



-- [연습문제]
-- 겨울인 월에 입사한 사람
SELECT e.EMP_NAME , (e.HIRE_DATE) AS "입사날"
FROM EMPLOYEES e
WHERE TO_CHAR(e.HIRE_DATE , 'MM') IN (12, 1, 2);


-- 숫자 변환
-- 변환은 맞는데 사실상 출력형식 지정
SELECT TO_CHAR(123456789, '999,999,999') AS "우리나라 방식",
TO_CHAR(1234.56789, '999,999.999999') AS "소수점 다루기"
FROM DUAL;








-- 기본적으로 문자에서 숫자는 자동
SELECT '123', TO_NUMBER('123')
FROM DUAL;

-- 기본적으로 자동
SELECT TO_DATE('2024-05-30') 
FROM DUAL;




-- NULL 체크 하기
SELECT e.EMP_NAME , e.COMMISSION_PCT, 
NVL(e.COMMISSION_PCT, 0) AS "NULL면 0으로 출력",
NVL2(e.COMMISSION_PCT, 1000, 0) AS "NULL면 0이고 아니면 1000"
FROM EMPLOYEES e;








-- EMPLOYEES
-- COMMISSION_PCT

SELECT e.EMP_NAME , e.COMMISSION_PCT, 
NVL2(e.COMMISSION_PCT, e.COMMISSION_PCT * 1.013, 0) 
AS "NULL면 0이고 아니면 1.3% 인상"
FROM EMPLOYEES e;


-- 가장 큰 거 찾아줌
-- 가장 작은 거 찾아줌
SELECT GREATEST (1, 3, 1, 2), LEAST(1, 3, 1, 2)
FROM DUAL;



--기억 복구용

-- [연습문제]
-- 이번달이 며칠 남았는지 알아내시오.
-- 달력을 보고 하나하나 셈을 하여 알아내면 ㅇㅈ
-- 대신 그 하나하나 세고 있는 모습을 보여야함
SELECT ('이번달 ' || (TO_CHAR(LAST_DAY(sysdate), 'DD') - TO_CHAR(sysdate, 'DD')) || '일 남았습니다.') AS "이번달"
FROM DUAL;


-- [연습문제]
-- 올해 며칠 남았는지 알아내시오.
-- 달력을 보고 하나하나 셈을 하여 알아내면 ㅇㅈ
-- 대신 그 하나하나 세고 있는 모습을 보여야함
SELECT ('올해 ' || (365 - TO_CHAR(sysdate, 'DDD')) || '일 남았습니다. ') AS "올해 남은 일수"
FROM DUAL;


-- [연습문제]
-- CUSTOMERS에서 100살 이상이 된 사람들 구하시오.
-- CUST_YEAR_OF_BIRTH
SELECT c.CUST_NAME, CUST_YEAR_OF_BIRTH AS "출생년도", (TO_CHAR(sysdate, 'YYYY') - c.CUST_YEAR_OF_BIRTH) AS "나이"
FROM CUSTOMERS c
WHERE  (TO_CHAR(sysdate, 'YYYY') - c.CUST_YEAR_OF_BIRTH) >= 100;



-- [연습문제]
-- CUSTOMERS에서 윤년에 탄생한 사람들을 출력하시오
-- CUST_YEAR_OF_BIRTH NUMBER 타입
SELECT c.CUST_NAME, c.CUST_YEAR_OF_BIRTH
FROM CUSTOMERS c 
WHERE (MOD(c.CUST_YEAR_OF_BIRTH, 400) = 0)
OR (MOD(c.CUST_YEAR_OF_BIRTH, 4) = 0 
AND MOD(c.CUST_YEAR_OF_BIRTH, 100) != 0);
