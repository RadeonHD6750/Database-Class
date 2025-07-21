

-- PL/SQL
-- DB에서 자바 마냥 절차적 실행을 해줄 수 있게 함
-- 그러나 완전사장된 상태이며, 과거 존재했던 것들도
-- 이 잡듯이 찾아 없에고 있는 상황

-- 01. 콘솔이 아닌 별도의 텍스트로 출력
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;




-- 02. 연산자
-- ㄹㅇ 완전 옛 날 문법
-- C언어 이전의 포트란, 파스탈, 코볼 -> C언어 시절의 문법
DECLARE 

  a INTEGER := 1 + 1;  -- 전역변수만 있음
  c NUMBER := 0;
BEGIN
	
  -- system.out.println이랑 같음 
  DBMS_OUTPUT.PUT_LINE('a = ' || TO_CHAR(a));
 
  c := a + 1;
  DBMS_OUTPUT.PUT_LINE('a = ' || TO_CHAR(c));
END;








-- IF 제어문
DECLARE
   vn_num1 NUMBER := 1;
   vn_num2 NUMBER := 2 ;
BEGIN
	 -- 제어문
	 IF vn_num1 < vn_num2 THEN
	    DBMS_OUTPUT.PUT_LINE(vn_num1 ||'이 큰 수');
	 ELSE
	    DBMS_OUTPUT.PUT_LINE(vn_num2 ||'이 큰 수');	 
	 END IF;
	
END;












-- WHILE 문
DECLARE
   total_num NUMBER := 1;
   vn_base_num NUMBER := 1;
   vn_cnt      NUMBER := 1;
BEGIN
	
   WHILE  total_num <= 9 -- vn_cnt가 9보다 작거나 같을 경우에만 반복처리 
   LOOP
   		DBMS_OUTPUT.PUT_LINE('현재 ' || total_num || '단');
   		vn_cnt := 0;
   		WHILE vn_cnt <= 9
   		LOOP
	   		DBMS_OUTPUT.PUT_LINE (total_num || '*' || vn_cnt || '= ' || total_num * vn_cnt);
   			vn_cnt := vn_cnt + 1;
   		END LOOP;
   		total_num := total_num + 1;
   END LOOP;
  
END;




-- FOR 문
DECLARE
   vn_base_num NUMBER := 1;
   vn_cnt      NUMBER := 1;
BEGIN
   
   FOR i IN 1..9 
   LOOP
   		FOR j IN 1..9
   		LOOP
	   		DBMS_OUTPUT.PUT_LINE (i || '*' || j || '= ' || i * j);
   		END LOOP;
   END LOOP;
    
END;










-- 1부터 50까지 소수 찾기

-- 소수 찾기 1부터 50까지

DECLARE
   has_div NUMBER := 0;
BEGIN
   
   FOR n IN 2..50 -- 검사할 목록
   LOOP
	   
	   
		-- n 검사 대상
	    -- n까지의 수로 나누어 본다
   		FOR div IN 2..n
		LOOP
			-- 나누어졌다.
			IF MOD(n, div) = 0 THEN
				has_div := 1; -- 그럼 소수가 아니다.
				EXIT;
			END IF;
		
		END LOOP;
		
		IF has_div = 0 THEN
			   DBMS_OUTPUT.PUT_LINE (n || '는 소수');
		END IF;

		has_div := 0;
      
   END LOOP;
END;





