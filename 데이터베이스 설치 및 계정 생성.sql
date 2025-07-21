-- 계정 생성 코드 --
-------------------------------------------------------------------------
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

--01. 공간부터 만들기
CREATE tablespace myts datafile
'D:\IDE\DB\Oracle\21C\Java\myts.dbf'
size 100M autoextend on next 10M;

--02. 계정 만들기
CREATE USER java IDENTIFIED BY oracle21c
default tablespace myts
temporary tablespace temp;

--03. 권한부여하기
GRANT connect, resource, IMP_FULL_DATABASE to java;
GRANT UNLIMITED TABLESPACE to java;

COMMIT;
-------------------------------------------------------------------------

-- 터미널에서 실행하기
-- imp java/oracle21c file=expall.dmp full=y grants=y rows=y indexes=y ignore=y
-- imp java/oracle21c file=expcust.dmp full=y grants=y rows=y indexes=y ignore=y