CREATE SEQUENCE user_seq --무슨일이 있어도 최솟값은 1
INCREMENT BY 1 --무슨일이 있어도 최솟값은 1
START WITH 1 --무슨일이 있어도 최솟값은 1
MINVALUE 1 --무슨일이 있어도 최솟값은 1
MAXVALUE 999999 -- 무슨일이 있어도 최댓값은 999999
NOCYCLE;
-- 맨 마지막줄에 주석 금지