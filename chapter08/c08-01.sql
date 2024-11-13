-- chapter08/c08-01.sql

-- chapter09 데이터베이스 보안과 관리
-- 01 보안과 권한
-- 1. 오라클 DBMS 구조 및 접근 권한
-- 오라클 데이터베이스는 multi-tenant 구조로 이루어져 있다. multi-tenant를
-- 직역하면 '다중 세입자'라는 의미로, 여러 데이터베이스(PDB-pluggable DB)를
-- 하나의 물리적 데이터베이스에 구현하는 '다중 데이터베이스'구현 기능이다.
-- 이는 오라클 12c부터 지원하는 기능으로 CDB(Container DB)라는
-- 부모 데이터베이스에 PDB라는 여러 자식 데이터베이스를 만들어 각 자식
-- 데이터베이스는 독립적으로 동작할 수 있게 하는 기술이다.

-- 오라클 DBMS는 이러한 multi-tenant 구조하에서 로그인 단계에서 
-- DBMS접근을 제한하는 로그인 사용자 관리와 로그인한 사용자별로 특정 데이터로의
-- 접근을 제한하는 권한 관리의 기능을 제공하게 된다.

-- 테이블스페이스와 로그인 사용자 관리
-- CDB USER인 c##madang을 만들고 사용하였다.
-- PDB 기준으로 진행해 보도록 하겠습니다.

-- 테이블스페이스 생성하기
-- 테이블스페이스는 오라클에서 데이터를 저장할 때 사용하는 논리적인 저장공간을
-- 의미한다. 자동으로 만들어지는 시스템 테이블스페이스와 사용자가 필요에 따라
-- 만들어 사용하는 사용자 테이블스페이스가 있다.

-- create tablespace는 테이블스페이스 생성 시 사용하는 명령이다
-- 문법
-- create tablespace 테이블스페이스명
--  datafile '저장될 경로 및 사용할 파일명'
--  size 저장공간

-- 10M의 용량을 가진 테이블스페이스 md_tbs,mb_test를 c:\madang\oradata
-- 폴더에 생성하시오. 이때 파일 이름은 각각 md_tbs_data01.dbf,
-- md_test_data01.dbf로 한다.
create tablespace md_tbs
    datafile 'C:\madang\oradata\md_tbs_data01.dbf'
    size 10M;
create tablespace md_test
    datafile 'C:\madang\oradata\md_test_data01.dbf'
    size 10M;

-- drop tablespace는 테이블스페이스 삭제 시 사용하는 명령이다.
-- drop tablespace 테이블스페이스명
--  [including contents [and datafiles][cascade constraints]];









