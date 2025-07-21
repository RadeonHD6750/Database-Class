

-- TRIM  양단 특정 문자 제거용인데
-- 주로 공백제거시
-- 왼쪽 혹은 오른쪽부터 지정된 문자 제거
SELECT LTRIM('   1234'),   RTRIM('1234    ')
FROM DUAL;

SELECT LTRIM('****12***34', '*'),   RTRIM('1234    ')
FROM DUAL;



-- 문자열 채우기
SELECT LPAD('1234', 10, '*'), RPAD('1234', 10, '*')
FROM DUAL;



-- EMPLOYEES에서
-- SALARY를 다음과 같이 출력하시오
SELECT e.EMP_NAME , LPAD(e.SALARY, 5, '0') AS "자릿수"
FROM EMPLOYEES e ;




--REPLACE  냥냥중요
--문자열 찾아 바꾸기 혹은 낑겨 넣기
SELECT REPLACE('123456789', '456', 'TTTTTTTT')
FROM DUAL;


--EMPLOYEES에서
--PHONE_NUMBER를 다음과 같이 출력하시오.
SELECT e.PHONE_NUMBER AS "원본 폰번",
REPLACE(e.PHONE_NUMBER, '.', '-') AS "우리나라처럼"
FROM EMPLOYEES e ;





--EMPLOYEES에서
--EMP_NAME을 다음과 같이 출력하시오.
SELECT e.EMP_NAME AS "원본",
REPLACE(e.EMP_NAME, ' ', '-') AS "바꾸기"
FROM EMPLOYEES e ;





--INSTR
--찾고자하는 문자의 위치
SELECT INSTR('12345', '3')
FROM DUAL;




--EMPLOYEES에서
-- PHONE_NUMBER를 다음과 같이 출력하시오
-- 4덩이짜리는 무시
SELECT e.PHONE_NUMBER AS "원본",
REPLACE (e.PHONE_NUMBER, 
SUBSTR(e.PHONE_NUMBER, 5, 3), '***') AS "번호 암호화"
FROM EMPLOYEES e ;




-- 문자열 길이 LENGTH
-- 몇개냐
SELECT LENGTH ('1234')
FROM DUAL;







--EMPLOYEES에서
--EMP_NAME의 길이가 3의 배수인 거 조회

SELECT e.EMP_NAME, LENGTH (e.EMP_NAME) AS "이름길이"
FROM EMPLOYEES e 
WHERE MOD(LENGTH (e.EMP_NAME), 3) = 0;




-- 지금까지 했던 문자열 함수 사왕 전부 사용하는 문제




-- EMPLOYEES에서
-- EMP_NAME을 보호하시오



SELECT e.EMP_NAME AS "원본",
INSTR(e.EMP_NAME, ' ') AS "공백위치값", 
LENGTH(e.EMP_NAME) AS "끝까지",
SUBSTR(e.EMP_NAME, INSTR(e.EMP_NAME, ' ') + 1, LENGTH(e.EMP_NAME)) AS "가릴부분",
REPLACE (e.EMP_NAME, SUBSTR(e.EMP_NAME, INSTR(e.EMP_NAME, ' ') + 1, LENGTH(e.EMP_NAME)), '*') AS "바꾸기",
RPAD(REPLACE (e.EMP_NAME, SUBSTR(e.EMP_NAME, INSTR(e.EMP_NAME, ' ') + 1, LENGTH(e.EMP_NAME)), '*'), LENGTH(e.EMP_NAME), '*') AS "이름 감추기"
FROM EMPLOYEES e;


-- 앞부분 가리기




SELECT e.EMP_NAME AS "원본",
INSTR(e.EMP_NAME, ' ') AS "공백위치값", 
LENGTH(e.EMP_NAME) AS "끝까지", 
SUBSTR(e.EMP_NAME,1, INSTR(e.EMP_NAME, ' ') - 1) AS "가릴부분",
REPLACE (e.EMP_NAME, SUBSTR(e.EMP_NAME,1, INSTR(e.EMP_NAME, ' ') - 1), '*') AS "바꾸기",
LPAD(REPLACE (e.EMP_NAME, SUBSTR(e.EMP_NAME,1, INSTR(e.EMP_NAME, ' ') - 1), '*'), LENGTH(e.EMP_NAME), '*') AS "이름 감추기"
FROM EMPLOYEES e;


