-- < Trigger 최종 확인 학습 >    
-- 19장 교재 520~521 페이지의 3번 트리거 문제를 해결

-- sys_context('USERENV', 'SESSION_USER') : 오라클에서 시스템에 접근한 사용자 이름을 확인

-- 부서 테이블 생성  : 트리거 이벤트 발생 테이블
    create table dept_trg
    as select * from department;

-- 로그 기록 테이블 생성 : 트리거 기록 생성
    create table dept_trg_log (
    tablename varchar2(10),
    dml_type varchar2(10),
    deptno number(2),
    user_name varchar2(30),
    change_date date
    );

    set serveroutput on;
    
-- 트리거 생성
    create or replace trigger trg_dept_log
        after insert or update or delete
        on dept_trg
        for each row
    begin
        if inserting then
            dbms_output.put_line('DEPT_TRG 테이블에 데이터가 추가되었습니다.');
            insert into dept_trg_log values('dept_trg','insert', :new.dno, sys_context('USERENV', 'SESSION_USER'), sysdate);
        elsif updating then
            dbms_output.put_line('DEPT_TRG 테이블의 데이터가 수정되었습니다.');
            insert into dept_trg_log values('dept_trg','update', :old.dno, sys_context('USERENV', 'SESSION_USER'), sysdate);
        elsif deleting then
            dbms_output.put_line('DEPT_TRG 테이블의 데이터가 삭제되었습니다.');
            insert into dept_trg_log values('dept_trg','delete', :old.dno, sys_context('USERENV', 'SESSION_USER'), sysdate);
        end if;
    end;
    /

-- 트리거 확인
    select * from user_triggers;
    select * from user_source where name = 'TRG_DEPT_LOG';
    

-- 트리거 동작 확인
-- 1번 : 데이터 추가
    insert into dept_trg values(99, 'MARKETING', 'SEOUL');
    select * from dept_trg;
    select * from dept_trg_log;
    select tablename 테이블명, dml_type DML타입, deptno 부서번호, user_name 사용자, to_char(change_date, 'YYYY/MM/DD AM HH:MI:SS') 날짜 from dept_trg_log;
    commit;
    
-- 2번 : 데이터 수정
    update dept_trg set loc = 'BUSAN' where dno = 99;
    select * from dept_trg;
    select tablename 테이블명, dml_type DML타입, deptno 부서번호, user_name 사용자, to_char(change_date, 'YYYY/MM/DD AM HH:MI:SS') 날짜 from dept_trg_log;
    
-- 3번 : 데이터 삭제
    delete dept_trg where dno = 99;
    select * from dept_trg;
    select tablename 테이블명, dml_type DML타입, deptno 부서번호, user_name 사용자, to_char(change_date, 'YYYY/MM/DD AM HH:MI:SS') 날짜 from dept_trg_log;    
    select * from dept_trg_log;
    commit;
    






























































































































































