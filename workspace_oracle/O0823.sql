/*
< 인덱스의 사용 여부를 결정하는 조건 >
 1. 인덱스를 사용해야 하는 경우
  - 테이블의 행의 수가 많을 때
  - where 조건에 해당하는 컬럼이 많이 사용될 때
  - 검색 결과 전체 데이터의 2~4% 정도일 때
  - join에 자주 사용되는 컬럼, null값을 포함하는 컬럼이 많을 때
  
 2. 인덱스를 사용하면 안되는 경우
  - 테이블의 행의 수가 적을 때
  - where 조건에 해당하는 컬럼이 자주 사용되지 않을 때
  - 검색 결과 전체 데이터의 10~15% 이상일 때
  - 테이블의 추가, 수정, 삭제가 자주 발생할 때
*/

-- 인덱스 확인
    select * from user_indexes;
    select * from user_ind_columns;
    
    create table dept
    as select * from department;
-- 인덱스 갱신
    alter index idx_dept_dname rebuild;
    select * from user_indexes;
    select * from tab; -- 내가 가진테이블들을 다 볼수 있음.
    
/*
< 시스템 권한 >
 - 사용자 생성과 제거, 권한 부여와 회수, 자원 관리 등과 같이 데이터베이스를 관리할 수 있는 권한
 - 데이터베이스 관리자(DBA, DataBase Administrator) 권한
 
< 시스템 권한 >
 - create session : 데이터베이스 연결 권한
 - create table : 테이블 생성 권한
 - create sequence : 시퀀스를 생성할 수 있는 권한
 - create view: 뷰를 생성할 수 있는 권한
 - create user: 사용자 계정을 생성하는 권한
 
< 테이블 스페이스 > table space
 - 테이블, 뷰 등의 객체가 저장되는 공간
 
# 객체 : 테이블, 뷰, 시퀀스, 프로시저 ...
< 객체 권한 >
 create - table, view, sequence, procedure
 alter - table, sequence
 drop - table, view, sequence, procedure
 
 insert - table, view
 update - table, view
 delete - table, view
 select - table, view, sequence
 
 index - table
 references - table
 execute - procedure
*/
-- 테이블 스페이스 확인
    select * from dba_users where username = 'USERTEST01';

-- 테이블 스페이스의 건한을 사용자에게 부여함
    alter user usertest01 default tablespace users quota unlimited on users;

-- 시스템에게서 부여받은 권한 확인
    select * from session_privs;

-- 사용자가 부여한 권한 확인
    select * from user_tab_privs;

/*
< 롤(role) 권한 >
 - 권한의 묶음
 - 다양한 권한을 효과적으로 사용하고, 관리할 수 있도록 권한을 묶어 놓은 것.
 
< 롤 권한의 종류 >
 - 사전 정의된 롤 : 오라클에서 기본적으로 제공하는 롤
 - 사용자 정의 롤 : 사용자가 직접 정의해서 사용하는 롤
 
 1. 사전 정의된 롤
  - connect : 데이터베이스의 접속에 관한 권한의 묶음.
    ex) create session, create table, create view, create sequence, 
        create synonym, create cluster, create database link, alter session
  - resource : 객체를 생성할 수 있도록 하는 권한의 묶음.
    ex) create table, create view, create sequence, create cluster,
        create procedure, create trigger
  - dba : 시스템 관리에 필요한 모든 권한의 묶음.
    ex) with grant option이 있는 모든 권한
 2. 사용자 정의 롤
  - 사용자가 직접 롤 권한을 만들어 사용함.
  - 반드시 DBA 권한이 있어야 함.
  
*/

-- 사용자가 부여받은 롤 권한 확인, 사용자 정의 롤 확인
    select * from user_role_privs;

-- 사용자 정의 롤에 부여된 권한 확인
    select * from role_sys_privs;
    select * from role_sys_privs where role like 'ROLETEST%';
    commit;

-- 사용자 정의 롤에 부여된 테이블 권한 확인
    select * from role_tab_privs;
    select * from role_tab_privs where table_name in ('EMPLOYEE','DEPARTMENT');

/*
교재 416 페이지의 3문제를 해결하시오.
*/

commit;

/*
< 동의어 > synonym
 - 데이터베이스에 대한 별칭
 - 테이블, 뷰, 시퀀스 등에 대해 사용하기 쉬운 이름을 붙인 것.
 - 공용 동의어는 DBA 권한을 가진 사용자가 생성할 수 있음.
 
< 동의어의 종류 >
 1. 전용 동의어 
  - 개별 사용자가 생성하여 사용하는 동의어
  - 객체에 대한 접근 권한을 부여받은 사용자가 정의하여 사용하며, 정의한 사용자만 사용 가능.
 
 2. 공용 동의어 
  - 전체 사용자가 사용하는 동의어
  - 권한을 부여하는 사용자가 생성하는 동의어, 생성할 때 public을 붙여서 생성함.
*/

-- 사용자가 부여한 테이블 권한 확인
    select * from user_tab_privs;

-- 공용 동의어를 확인
    select * from all_synonyms;
    select * from all_synonyms where synonym_name = 'P_DEPT';

-- 공용 동의어 삭제
    drop public synonym p_dept;
    
-- 전용 동의어를 확인 --> 전용 동의어를 생성한 사용자에서 확인
    select * from user_synonyms;
    
-- 전용 동의어를 삭제 --> 전용 동의어를 생성한 사용자에서 삭제
    drop synonym s_emp;
    
-- 교재 357 페이지의 3문제 해결  
    



























































































































































































































