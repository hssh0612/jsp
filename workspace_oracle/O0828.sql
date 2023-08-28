/*
< 함수의 종류 >
 1. 내장 함수 : 오라클에 만들어 놓은 함수
 2. 사용자 정의 함수 : 사용자가 정의하는 함수
 
< 함수 (Function) >
 - 반드시 한 개의 값을 리턴하여 SQL문에서 사용할 수 있도록 하는 PL/SQL 
 
< 프로시저와 함수의 차이점 >
 1. 프로시저
  - execute 명령, 다른 PL/SQL 내부에서 호출하여 실행
  - 매개변수 : (in, out, in out 모드) 여러 개를 사용할 수 있고, 지정하지 않을 수도 있음
  - 리턴값 :  (out, in out 모드)은 여러 개를 사용할 수 있고, 없을 수도 있음.
  
 2. 함수
  - execute 명령, 다른 PL/SQL 내부에서 호출하여 실행, SQL문 내부에서 직접 사용 가능
  - 매개변수 : (in 모드만 가능) 여러 개를 사용할 수 있고, 지정하지 않을 수도 있음
  - 리턴값 : 반드시 1개만 존재, 없을 수는 없음. return문을 사용
*/

-- 함수의 정의
-- 문제 1번) 사원명을 입력하여, 연봉을 리턴하는 함수를 생성하고, 사용
    create or replace function fn_emp01 ( v_ename in employee.ename%type)
        return number
    is
        v_salary employee.salary%type;
    begin
        select salary into v_salary
        from employee
        where ename = v_ename;
        return v_salary;
    end;
    /

-- 함수 확인
    select * from all_objects where object_name like 'FN%';
-- 함수 내용 확인    
    select * from user_source where name = 'FN_EMP01';

-- 함수 삭제
    drop function fn_emp01;

-- 함수 사용 1번
    var v_salary nuber;
    execute : v_salary := fn_emp01('SCOTT');
    print v_salary;

-- 함수 사용 2번 : PL/SQL에서 사용
    
    set serveroutput on;
    declare
        v_ename employee.ename%type;
        v_salary employee.salary%type;
    begin
        v_ename := '&input_ename';
        v_salary := fn_emp01(v_ename);
        
        dbms_output.put_line(v_ename || ' 사원의 연봉 : ' || v_salary);
    end;
    /

-- 함수 사용 3번 : SQL에서 사용
    select ename, fn_emp01('SCOTT')
    from employee
    where ename = 'SCOTT';

-- 문제2번) 사원 테이블에 주어진 사원의 총연봉에 대한 세금을 계산하는 함수를 생성하고, 사용
-- 세금은 연봉과 성과급을 더한 총연봉에 대해서 10%로 계산
-- 함수명 : fn_emp_tax

    create or replace function fn_emp_tax(v_ename employee.ename%type)
        return number    
    is
        v_tax number(7,2);
    begin
        select (salary+nvl(commission,0))*0.1 into v_tax
        from employee
        where ename = v_ename;
        return v_tax;
    end;
    /

-- 함수 확인
    select * from all_objects where object_name like 'FN%';
    select * from user_source where name = 'FN_EMP_TAX';
-- 함수 사용 1번
    var v_tax number;
    execute :v_tax := fn_emp_tax('KING');
    print v_tax;
    
-- 함수 사용 2번
    declare
        v_ename employee.ename%type;
        v_tax number(7,2);
    begin
        v_ename := '&input_ename';
        v_tax := fn_emp_tax(v_ename);
        dbms_output.put_line(v_ename || ' 사원의 세금 : ' || v_tax);
    end;
    /

-- 함수 사용 3번
    select eno 사번, ename 사원명, salary 연봉, nvl(commission,0) 성과급, fn_emp_tax('KING') 세금
    from employee
    where ename = 'KING';

-- 문제 3번) 사원 테이블에서 모든 사원의 세금을 출력
-- 모든 사원의 세금을 계산하는 함수를 만들어 사용
-- 사원의 세금은 연봉과 성과급을 더한 금액에 10%를 적용
-- 출력은 사번, 사원명, 연봉, 성과급, 세금, 실연봉(세금공제)을 실연봉의 내림차순으로 출력
-- 함수명 : fn_emp_tax_all

-- 함수 생성
    create or replace function fn_emp_tax_all(v_salary number, v_commission number)
        return number
    is 
        v_tax number(7,2);
    begin
        v_tax := (v_salary + nvl(v_commission,0)) * 0.1;
        return v_tax;
    end;
    /

-- 함수 확인
    select * from all_objects where object_name like 'FN%';
    select * from user_source where name = 'FN_EMP_TAX_ALL';

-- 함수 사용 1번
    var v_tax number;
    execute : v_tax := fn_emp_tax_all(2000,500);
    print v_tax;

-- 함수 사용 2번
    declare
        v_emp employee%rowtype;
        v_tot number(7,2);
        v_tax number(7,2);
        cursor c1 is select * from employee order by salary+nvl(commission,0) desc;
    begin
        dbms_output.put_line(' 사번 | 사원명 | 연봉 | 성과급 | 총연봉 | 세금 | 실연봉(세금공제)');
        dbms_output.put_line('---------------------------------------------------------');
        for v_emp in  c1 loop
            exit when c1%notfound;
            v_tax := fn_emp_tax_all(v_emp.salary, v_emp.commission);
            v_tot := v_emp.salary+nvl(v_emp.commission,0);
            dbms_output.put_line(v_emp.eno || ' | ' || v_emp.ename || ' | ' || 
                v_emp.salary || ' | ' || nvl(v_emp.commission,0)|| ' | ' || 
                v_tot || ' | ' || v_tax || ' | ' || (v_tot-v_tax));
        end loop;
    end;
    /

-- 함수 사용 3번
    select eno 사번, ename 사원명, salary 연봉, nvl(commission,0) 성과급, salary+nvl(commission,0) 총연봉,
    fn_emp_tax_all(salary, commission) 세금, salary+nvl(commission,0)-fn_emp_tax_all(salary, commission) 실연봉
    from employee
    order by 실연봉 desc;


-- < 최종 확인 학습 >
-- 교재 19장 518~519 페이지의 2문제
-- 1번) 프로시저
    create or replace procedure pro_dept_in(
        v_dno in out department.dno%type, v_dname out department.dname%type, v_loc out department.loc%type) 
    is
    begin
        select dno, dname, loc into v_dno, v_dname, v_loc
        from department
        where dno = v_dno;
    end;
    /
    
-- 확인
    select * from user_procedures;
    select * from user_source where name = 'PRO_DEPT_IN';
    
    declare
        v_dno department.dno%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
    begin
        v_dno := &input_dno;
        pro_dept_in(v_dno, v_dname, v_loc);
        dbms_output.put_line(' 부서번호 | 부서명 | 지역명 ');
        dbms_output.put_line('---------------------------');
        dbms_output.put_line(v_dno || ' | ' || v_dname || ' | ' || v_loc);
    end;
    /
    
    
-- 2번) 함수
    create or replace function fn_date_kor(v_hiredate date)
        return varchar2
    is
    begin
        return to_char(v_hiredate, 'YYYY"년" MM"월" DD"일"');
    end;
    /

-- 확인
    select * from all_objects where object_name like 'FN%';
    select * from user_source where name = 'FN_DATE_KOR';
    
-- 사용
    select eno 사번, ename 사원명, fn_date_kor(hiredate) 입사일
    from employee
    order by hiredate;

/*
< 패키지 (Package) >
 - 관련 있는 프로시저, 함수를 하나의 논리적인 그룹으로 묶어서 사용하는 객체
 - 업무나 기능면에서 사용하고, 관리하기에 용이함.
 
< 패키지의 장점 >
 1. 모듈화 : 여러 가지 변수, 프로시저, 함수를 하나로 묶어서 사용
 2. 설계의 간편성 : 프로그램의 설계가 간편해짐.
 3. 정보 은닉 : 패키지 안에 프로시저, 함수를 저장함으로써 보안을 강화함
 4. 기능성 향상 : 모듈화하여 사용함으로써 기능을 향상할 수 있음.
 5. 성능 향상 : 패키지 안에 있는 프로시저, 함수를 한꺼번에 실행하여 사용함으로 성능 향상할 수 있음.

< 패키지의 생성 방법 >
 1. 패키지 생성 : 함수 또는 프로시저의 선언
 2. 패키지 본문(바디) 생성 : 함수 또는 프로시저의 본문을 생성
*/

-- 1. 패키지의 선언부 생성 - 변수, 프로시저, 함수
    create or replace package pkg_ex01
    is
        v_number number := 10; -- 변수 선언
        function fn_after_tax(v_salary number) return number; -- 함수 선언
        procedure sp_emp(v_eno in employee.eno%type);
        procedure sp_dept(v_dno in department.dno%type);

    end;
    /
    
-- 2. 패키지의 본문 생성
    create or replace package body pkg_ex01
    is
    -- 함수
        function fn_after_tax(v_salary number) return number
        is
            v_tax number := 0.1;
        begin
            return v_salary - (v_salary*v_tax);
        end;
    -- 프로시저
        procedure sp_emp(v_eno employee.eno%type)
        is
            v_ename employee.ename%type;
            v_salary employee.salary%type;
        begin
            select ename, salary into v_ename, v_salary 
            from employee
            where eno = v_eno;
            
            dbms_output.put_line(v_ename || '사원의 연봉 : ' || v_salary);
        end;
    -- 프로시저
        procedure sp_dept(v_dno department.dno%type)
        is
            v_dname department.dname%type;
            v_loc department.loc%type;
        begin
            select dname, loc into v_dname, v_loc
            from department
            where dno = v_dno;
            
            dbms_output.put_line(v_dname || ' : ' || v_loc);
        end;
    end;
    /

-- 패키지 확인
    select * from all_objects where object_name like 'PKG%';
-- 패키지 내용 확인
    select * from user_source where name = 'PKG_EX01';
-- 패키지 구조 확인
    desc pkg_ex01;

-- 패키지 사용
    set serveroutput on;
    begin
        dbms_output.put_line('세금 공제 후 연봉 : ' || pkg_ex01.fn_after_tax(3000));
        dbms_output.put_line(' 7788 사원의 정보 ');
        pkg_ex01.sp_emp(7788);
        dbms_output.put_line(' 10번 부서의 정보 ');
        pkg_ex01.sp_dept(10);
    end;
    /

-- 패키지 삭제
    drop package pkg_ex01; -- 본문까지 함께 삭제
    drop package body pkg_ex01; -- 본문만 삭제

-- 패키지의 프로시저 오버로딩(overloading)
-- 패키지 선언 생성
    create or replace package pkg_ex02 
    is
        procedure sp_emp(v_eno employee.eno%type); -- 사번으로 연봉 조회
        procedure sp_emp(v_ename employee.ename%type); -- 사원명으로 연봉 조회
    end;
    /

    create or replace package body pkg_ex02
    is
        -- 프로시저 1
        procedure sp_emp(v_eno employee.eno%type)
        is
            v_ename employee.ename%type;
            v_salary employee.salary%type;
        begin   
            select ename, salary into v_ename, v_salary 
            from employee
            where eno = v_eno;
            
            dbms_output.put_line(v_eno || ' | ' || v_ename || ' | ' || v_salary);
        end;
        
        -- 프로시저 2
        procedure sp_emp(v_ename employee.ename%type)
        is
            v_eno employee.eno%type;
            v_salary employee.salary%type;
        begin
            select eno, salary into v_eno, v_salary
            from employee
            where ename = v_ename;
            
            dbms_output.put_line(v_eno || ' | ' || v_ename || ' | ' || v_salary);
        end;
        
    end;
    /

-- 패키지 확인
    select * from all_objects where object_name like 'PKG%';
    select * from user_source where name = 'PKG_EX02';
    desc pkg_ex02;
    
-- 패키지 사용
    begin 
        pkg_ex02.sp_emp(7369);
        pkg_ex02.sp_emp('SCOTT');
    
    end;
    /


-- < 패키지에서 함수의 오버로딩(overloading) >
-- 패키지 선언 생성
    create or replace package pkg_ex03 
    is
        function fn_emp(v_eno employee.eno%type) return number; -- 사번으로 연봉 조회
        function fn_emp(v_ename employee.ename%type) return number; -- 사원명으로 연봉 조회
    end;
    /

-- 패키지 바디 생성
    create or replace package body pkg_ex03
    is
        -- 함수 1
        function fn_emp(v_eno employee.eno%type) return number
        is
            v_salary employee.salary%type;
        begin   
            select salary into v_salary 
            from employee
            where eno = v_eno;
            
            return v_salary;
        end;
        
        -- 함수 2
        function fn_emp(v_ename employee.ename%type) return number
        is
            v_salary employee.salary%type;
        begin
            select salary into v_salary
            from employee
            where ename = v_ename;
            
            return v_salary;
        end;
        
    end;
    /

-- 패키지 확인
    select * from all_objects where object_name like 'PKG%';
    select * from user_source where name = 'PKG_EX03';
    desc pkg_ex03;

-- 패키지 사용 (함수 오버로딩)
    select eno, ename, pkg_ex03.fn_emp(7369)
    from employee
    where eno = 7369;

    select eno, ename, pkg_ex03.fn_emp('KING')
    from employee
    where ename = 'KING';   


/*
< 트리거 (Trigger) >
 - 데이터베이스 안에서 특정한 상황이나 동작 즉 이벤트가 발생할 경우 자동으로 실행되는 기능을 정의한 PL/SQL문
 - 방아쇠, 연쇄적인 반응, 연속성을 가지는 동작의 시발점.
 EX) 데이터베이스에 접근한 로그 기록을 남길 때, 데이터베이스의 객체 간의 일관성을 유지하고자 할 때...
 
< 트리거의 장점 >
 1. 특정 데이터와 관련된 여러 작업을 수행할 때 서브 프로그램을 한꺼번에 실행할 수 있음.
 2. 제약조건 등의 구현이 어려운 작업들에 대해 복잡한 규칙을 정의하여 쉽게 사용이 가능함.
 3. 데이터 변경과 관련된 일련의 정보를 기록해 놓음으로써 여러 사용자가 공유하는 데이터에 보안과 안정성을 향상시킬 수 있음.

< 트리거의 단점 >
 1. 무분별한 트리거의 생성과 사용은 데이터베이스의 성능을 떨어뜨리게 됨.

< 트리거의 종류 1 >
 - 이벤트가 발생하는 시점에 따라 
  1. after 트리거
   - 이벤트가 발생한 후에 트리거가 동작하는 것
  2. before 트리거
   - 이벤트가 발생하기 전에 트리거가 동작하는 것 
   
< 트리거의 종류 2 >
 - 트리거가 각 행마다 발생하는 지의 여부에 따라
  1. 행 레벨 트리거
   - 여러 개의 행이 변경될 때, 각 행마다 발생하는 트리거.
  2. 문장 레벨 트리거
   - 이벤트에 대해 단 한번만 발생하는 트리거.

# 행 레벨 트리거에서 실제 컬럼을 제어하는 연산자 2가지
 - :old -> 변경 전의 값
 - :new -> 변경 후의 값
   
< 트리거의 종류 3 >
 - 발생하는 이벤트의 종류에 따라
  1. DML 트리거
   - 테이블에서 사용하는 DML 명령에 따라 발생하는 트리거
   - 일반적으로 가장 많이 사용하는 트리거
  2. DDL 트리거
   - 테이블에서 사용하는 DDL 명령에 따라 발생하는 트리거
  3. instead of 트리거
   - 뷰에 사용하는 DML 트리거
  4. 시스템 트리거
   - 데이터베이스나 스키마에서 동작하는 트리거
 
< 트리거의 종류 4 > 
 - 트리거가 한 지점 또는 여러 지점에서 동작하는 지의 여부에 따라
  1. 단순 트리거
   - 트리거가 한 지점에서 동작함.
  2. 복합 트리거
   - 트리거가 여러 지점에서 동작함.
   
*/

-- Insert 트리거
-- 문제 1번) 부서 테이블에 새로운 데이터가 추가될 때, 백업 테이블에도 데이터를 저장하는 트리거르 생성하고 확인
-- 원본 테이블
    create table dept_origin
    as select * from department;

-- 백업 테이블
    create table dept_backup
    as select * from department where 0 = 1;
    
-- 트리거 생성
    create or replace trigger t_dept1
        after insert -- after 트리거 
        on dept_origin
        for each row -- 행 레벨 트리거 (생략하면 문장 레벨 트리거)
    begin
        if inserting then
            dbms_output.put_line('Insert Trigger 발생하였습니다.');
            insert into dept_backup values(:new.dno, :new.dname, :new.loc);
        end if;
    end;
    /

-- 트리거 확인
    select * from user_triggers;

-- 트리거 삭제
    drop trigger t_dept1;
    
-- 트리거 동작 확인
    insert into dept_origin values(50, 'MARKETING', 'SEOUL');
    commit;
    
    select * from dept_origin;
    select * from dept_backup;

-- < Delete Trigger >
-- 문제2번) 부서 테이블의 내용을 삭제하였을 때, 백업 테이블에도 삭제하는 트리거를 생성하고 확인.
    create or replace trigger t_dept2
        after delete
        on dept_origin
        for each row
    begin
        if deleting then 
            dbms_output.put_line('Delete Trigger 발생');
            delete dept_backup where dno = :old.dno;
        end if;
    end;
    /

-- 트리거 확인
    select * from user_triggers;
    select * from user_source where name = 'T_DEPT2';

-- 트리거 동작 확인
    delete dept_origin where dno = 50;
    commit;
    
    select * from dept_origin;
    select * from dept_backup;

-- 문제3번) 부서 테이블에서 데이터가 삭제되었을 때, 삭제된 데이터를 백업 테이블에 추가하는 트리거를 생성하고, 확인
    create or replace trigger t_dept3 -- 무슨 이유 때문에 2로 바꾸랬는데 안바꿈 ㅎ
        after delete
        on dept_origin
        for each row
    begin
        if deleting then
            dbms_output.put_line('Delete Trigger가 발생하였습니다.');
            dbms_output.put_line('삭제된 데이터가 백업되었습니다.');
            insert into dept_backup values(:old.dno, :old.dname, :old.loc);
        end if;
    end;
    /

-- 트리거 확인
    select * from user_triggers;
    select * from user_source where name = 'T_DEPT3'; -- 무슨 이유 때문에 2로 바꾸랬는데 안바꿈 ㅎ
    
-- 트리거의 동작 확인
    delete dept_origin where dno in (30, 40);

    rollback;

    select * from dept_origin;
    select * from dept_backup;

-- < Update Trigger >
-- 문제4번) 부서 테이블에서 내용을 변경하였을 때, 백업 테이블의 내용도 변경되는 트리거를 생성하고, 확인
-- 부서번호를 통해서 부서명 또는 지역명을 변경할 때 
    truncate table dept_origin;
    truncate table dept_backup;
    
    insert into dept_origin select * from department;
    commit;

-- 트리거 생성
    create or replace trigger t_dept4
        after update
        on dept_origin
        for each row
    begin
        if updating then
            dbms_output.put_line('Update Trigger가 발생.');
            update dept_backup 
            set dname = :new.dno, loc = :new.dno 
            where dno = :new.dno;
        end if;
    end;
    /

-- 트리거 확인
    select * from user_triggers;
    select * from user_source where name = 'T_DEPT4';
    
-- 트리거 동작 확인
    update dept_origin
    set dname = 'INFO'
    where dno = 10;
    
    select * from dept_origin;
    select * from dept_backup;
    
    update dept_origin
    set loc = 'SEOUL'
    where dno = 20;
    
    update dept_origin
    set dname = 'MARKETING', loc = 'BUSAN'
    where dno = 30;
    
    commit;
    
-- 문제5번) 부서테이블의 내용이 변경되었을 때, 변경되기 전의 내용을 백업 테이블에 저장
-- 부서번호를 통해서 부서명과, 지역명을 변경했을 때
    create or replace trigger t_dept4
        before update
        on dept_origin
        for each row
    begin 
        if updating then
            dbms_output.put_line('Update Trigger가 발생');
            insert into dept_backup values(:old.dno, :old.dname, :old.loc);
        end if;
    end;
    /
    
-- 트리거 확인
    select * from user_triggers;
    select * from user_source where name = 'T_DEPT4';
    
-- 트리거 동작 확인
    update dept_origin
    set dname = 'PART1'
    where dno = 10;

    update dept_origin
    set loc = 'INCHEON'
    where dno = 20;
    
    update dept_origin
    set dname = 'PART2', loc = 'DAEGU'
    where dno = 30;

    select * from dept_origin;
    select * from dept_backup;

-- < Trigger 최종 확인 학습 >    
-- 19장 교재 520~521 페이지의 3번 트리거 문제를 해결


