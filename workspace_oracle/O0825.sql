
-- 문제18) employee 사원의 값을 저장하는 레코드를 생성하여, 레코드의 값을 employee 테이블에
-- 저장하는 PL/SQL을 생성하시오.
-- 레코드명: RECORD_EMP

    set serveroutput on;
    
    declare
        -- 레코드 정의
        type RECORD_EMP is record (
            eno employee.eno%type,
            ename employee.ename%type,
            job employee.job%type,
            manager employee.manager%type,
            hiredate employee.hiredate%type,
            salary employee.salary%type,
            commission employee.commission%type,
            dno employee.dno%type
        );
        -- 레코드 변수 선언
        emp_r RECORD_EMP;
        
    begin
        emp_r.eno := 8100;
        emp_r.ename := 'LEE';
        emp_r.job := 'SALESMAN';
        emp_r.manager := 7839;
        emp_r.hiredate := sysdate;
        emp_r.salary := 4000;
        emp_r.commission := 1000;
        emp_r.dno := 30;
        
        insert into employee values emp_r;
    end;
    /
    commit;
    
/*
< 커서를 활용한 for loop문 >
# 커서 (sursor)
 - select 문의 결과를 여러 행이 조회되었을 때 이 여러 행의 결과를 화면으로 출력할 수 있도록 하는 기능
 
< 커서를 사용하는 방법 >
 1. 기본 loop문에서 사용하는 방법
  - 1단계 : 커서 선언(declare)
  - 2단계 : 커서 열기(open)
  - 3단계 : 커서 사용(fetch)
  - 4단계 : 커서 닫기(close)
  
 2. for loop문에서 사용하는 방법
  - 1단계 : 커서 선언(declare)
  - 2단계 : 커서 사용(자동으로 open, fetch, close)

< for loop문의 장점과 단점 >
 # 장점
 1. 커서의 open, fetch, close를 생략함
 2. exit문을 생략함
 3. 레퍼런스 변수도 생략 가능함
 
 # 단점
 1. 커서의 다양한 속성을 사용할 수 없음
 

< 커서의 종류 >
 1. 명시적 커서
  - 커서를 명시적으로 선언하고 사용하는 방법
 
 2. 암묵적(묵시적) 커서
  - 커서를 선언하지 않고, 암묵적으로 사용하는 방법
  - SQL키워드로 커서의 속성을 사용하여, 자동으로 생성되는 커서
  - sql%notfound, sql%found, sql%rowcount, sql%isopen
  
< 커서의 속성 >
 1. 커서명%notfound : 행을 찾지 못했다면 true, 찾았다면 false
 2. 커서명%found : 행을 찾았다면 true, 찾지 못했다면 false
 3. 커서명%rowcount : 추출한 행의 수를 구함
 4. 커서명%isopen : 커서가 열려있으면 true, 닫혔으면 false
*/
-- 문제1) 부서 테이블의 모든 결과를 출력하시오.
 -- 1번 방법 : 기본 loop문
    declare
        v_dept department%rowtype;
        -- 1. 커서 선언
        cursor c1 is select * from department;
    begin
        dbms_output.put_line('부서번호 | 부서명 | 지역명');
        dbms_output.put_line('------------------------');
        -- 2. 커서 열기
        open c1;  
        loop
            -- 3. 커서 사용(fetch)
            fetch c1 into v_dept.dno, v_dept.dname, v_dept.loc;
            exit when c1%notfound;
            dbms_output.put_line(v_dept.dno || ' | ' || v_dept.dname || ' | ' || v_dept.loc);
        end loop;
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('부서 개수 : ' || c1%rowcount);
        -- 4. 커서 닫기
        close c1;
    end;
    /
 -- 2번 방법 : for loop문
    declare
        v_dept department%rowtype; -- 생략가능
        -- 1. 커서 선언
        cursor c1 is select * from department;
    begin
        dbms_output.put_line('부서번호 | 부서명 | 지역명');
        dbms_output.put_line('------------------------');
        -- 2. 커서 사용
        for v_dept in c1 loop
            exit when c1%notfound;
            dbms_output.put_line(v_dept.dno || ' | ' || v_dept.dname || ' | ' || v_dept.loc);
        end loop;

    end;
    /  
    
-- 문제2번) 사원 테이블에서 연봉이 2000에서 3000 사이인 사원의 정보를 연봉이 높은 순으로, 사번순으로 출력
-- 기본 loop문, for loop문 2가지 방법으로 해결
 -- 1번 : 기본 loop문
 
    declare
        v_emp employee%rowtype;
        cursor c1 is 
        select * from employee 
        where salary between 2000 and 3000 
        order by salary desc, eno;
    begin
        dbms_output.put_line('사번 | 사원명 | 업무 | 관리자번호 | 입사일 | 연봉 | 성과급 | 부서번호');
        dbms_output.put_line('-----------------------------------------------------');
        open c1;
        loop
            fetch c1 into v_emp;
            exit when c1%notfound;
            dbms_output.put_line(v_emp.eno || ' | ' || v_emp.ename || ' | ' || v_emp.job || ' | ' || v_emp.manager || ' | ' || 
            v_emp.hiredate || ' | ' || v_emp.salary || ' | ' || nvl(v_emp.commission,0) || ' | ' || v_emp.dno);
        end loop;
        close c1;
    end;
    /
    
 -- 2번 : for loop문
    declare
        v_emp employee%rowtype;
        cursor c1 is 
        select * from employee 
        where salary between 2000 and 3000 
        order by salary desc, eno;
    begin
        dbms_output.put_line('사번 | 사원명 | 업무 | 관리자번호 | 입사일 | 연봉 | 성과급 | 부서번호');
        dbms_output.put_line('-----------------------------------------------------');
        for v_emp in c1 loop
            exit when c1%notfound;
            dbms_output.put_line(v_emp.eno || ' | ' || v_emp.ename || ' | ' || v_emp.job || ' | ' || v_emp.manager || ' | ' || 
            v_emp.hiredate || ' | ' || v_emp.salary || ' | ' || nvl(v_emp.commission,0) || ' | ' || v_emp.dno);
        end loop;
    end;
    /
    
-- 문제3번) 사원 테이블에서 성과급을 받는 사원의 사번, 사원명, 연봉, 성과급, 부서번호, 부서명을 출력
-- 성과급이 높은 순으로, 연봉이 높은 순으로 출력
-- 기본 loop문, for loop문
 -- 1번 : 기본 loop문
-- 1번: 기본 loop문
    declare
        type RECORD_ED is record (
            eno employee.eno%type,
            ename employee.ename%type,
            salary employee.salary%type,
            commission employee.commission%type,
            dno employee.dno%type,
            dname department.dname%type
        );
        ed_r RECORD_ED;
        -- 커서 선언
        cursor c1 is 
        /*
        select eno, ename, salary, commission, e.dno, dname 
        from employee e join department d
        on e.dno = d.dno where commission is not null 
        */
        select eno, ename, salary, commission, dno, dname
        from employee natural join department
        where commission is not null
        
        order by commission desc, salary desc;
    begin
    dbms_output.put_line('사번 | 사원명 | 연봉 | 성과급 | 부서번호 | 부서명');
        dbms_output.put_line('-------------------------------------------');
        open c1;
        loop
            fetch c1 into ed_r;
            exit when c1%notfound;
            dbms_output.put_line(ed_r.eno || ' | ' || ed_r.ename || ' | ' || ed_r.salary || ' | ' || 
            ed_r.commission || ' | ' || ed_r.dno || ' | ' || ed_r.dname);
            
        end loop;
        close c1;
    end;
    /
    

 -- 2번 : for loop문
    declare
        cursor c1 is
        select eno, ename, salary, commission, dno, dname
        from employee natural join department
        where commission is not null
        order by commission desc, salary desc;
    begin
        dbms_output.put_line('사번 | 사원명 | 연봉 | 성과급 | 부서번호 | 부서명');
        dbms_output.put_line('-----------------------------------------------------');
        for v_ed in c1 loop
            exit when c1%notfound;
            dbms_output.put_line(v_ed.eno || ' | ' || v_ed.ename || ' | ' ||  v_ed.salary || ' | ' ||  
            v_ed.commission || ' | ' || v_ed.dno || ' | ' || v_ed.dname);
        end loop;
    end;
    /
    
-- 문제 4번) 평균연봉보다 많은 연봉를 받고, 이름에 'K'가 포함된 사원과 같은 부서에서 근무하는 
-- 사원의 사번, 사원명, 연봉, 부서번호, 부서명을 출력
-- 연봉이 높은순, 부서번호 순으로 출력
-- 1번 : 기본 loop문
    declare
    type RECORD_ED is record(
            eno employee.eno%type,
            ename employee.ename%type,
            salary employee.salary%type,
            dno employee.eno%type,
            dname department.dname%type
        );
        ed_r RECORD_ED;
        cursor c1 is
        select eno, ename, salary, dno, dname
        from employee natural join department
        where salary > (select avg(salary) from employee)
        and dno in (select dno from employee where ename like '%K%')
        order by salary desc, dno;
    begin
        dbms_output.put_line('사번 | 사원명 | 연봉 | 부서번호 | 부서명');
        dbms_output.put_line('-----------------------------------------------------');
        open c1;
        loop
            fetch c1 into ed_r;
            exit when c1%notfound;
            dbms_output.put_line(ed_r.eno || ' | ' || ed_r.ename || ' | ' ||  ed_r.salary || ' | ' ||  
            ed_r.dno || ' | ' || ed_r.dname);
        end loop;
        close c1;
    end;
    /

-- 2번 : for loop문
    declare
        cursor c1 is
        select eno, ename, salary, dno, dname
        from employee natural join department
        where salary > (select avg(salary) from employee)
        and dno in (select dno from employee where ename like '%K%')
        order by salary desc, dno;
    begin
        dbms_output.put_line('사번 | 사원명 | 연봉 | 부서번호 | 부서명');
        dbms_output.put_line('-----------------------------------------------------');
        for v_ed in c1 loop
            exit when c1%notfound;
            dbms_output.put_line(v_ed.eno || ' | ' || v_ed.ename || ' | ' ||  v_ed.salary || ' | ' ||  
            v_ed.dno || ' | ' || v_ed.dname);
        end loop;
    end;
    /

-- 문제5번) 관리자가 없는 사원과 업무별 최저연봉이 2000미만인 그룹은 제외하고, 업무별 최저연봉을 출력
-- 최저급여에 높은 순으로 출력
-- 1번 : 기본 loop문
    declare
        v_job varchar2(9);
        v_min_salary number(7,2);
        cursor c1 is
        select job, min(salary) 
        from employee
        where manager is not null
        group by job
        having not min(salary) < 2000
        order by min(salary) desc;
    begin
        open c1;
        loop
            fetch c1 into v_job, v_min_salary;
            exit when c1%notfound;
            dbms_output.put_line(v_job || ' | ' || v_min_salary);
        end loop;
        close c1;
    end;
    /

-- 2번 : for loop문
    declare
        cursor c1 is
        select job, min(salary) min_salary
        from employee
        where manager is not null
        group by job
        having not min(salary) < 2000
        order by min(salary) desc;
    begin
        for v in c1 loop
            exit when c1%notfound;
            dbms_output.put_line(v.job || ' | ' || v.min_salary);
        end loop;
    end;
    /
    
-- 암묵적 커서 활용 예제
    insert into employee(eno, ename, job, dno) values(9000, 'KIM', 'STUDENT',40);
    insert into employee(eno, ename, job, dno) values(9100, 'LEE', 'STUDENT',40);
    insert into employee(eno, ename, job, dno) values(9200, 'PARK', 'STUDENT',40);
    insert into employee(eno, ename, job, dno) values(9300, 'CHOI', 'STUDENT',40);
    insert into employee(eno, ename, job, dno) values(9400, 'JONG', 'STUDENT',40);
    COMMIT;
-- 문제 6번)
    begin
        update employee set job= 'SALESMAN' where eno>= 9000;
        
        dbms_output.put_line('갱신된 행수 : ' || sql%rowcount);
        
        if sql%found then
            dbms_output.put_line('갱신된 행이 있습니다.');
        else
            dbms_output.put_line('갱신된 행이 없습니다.');
        end if;
        
        if sql%isopen then
            dbms_output.put_line('커서가 open 되었습니다.');
        else
            dbms_output.put_line('커서가 open 되지않았습니다.');
        end if;
        
    end;
    /
    
-- 커서의 활용 1번 : 조건에 따라 다른 결과를 생성할 수 있음.
    declare
        v_emp employee%rowtype;
        cursor c1(e_dno employee.dno%type) is
        select * from employee where dno = e_dno;
        
    begin
        -- 10번 부서
        open c1(10);
        loop
            fetch c1 into v_emp;
            exit when c1%notfound;
            dbms_output.put_line(v_emp.dno || ' | ' || v_emp.eno || ' | ' || v_emp.ename || ' | ' || v_emp.job);
        end loop;
        close c1;
        
        dbms_output.put_line('---------------------------------------');
        -- 20번 부서
        open c1(20);
        loop
            fetch c1 into v_emp;
            exit when c1%notfound;
            dbms_output.put_line(v_emp.dno || ' | ' || v_emp.eno || ' | ' || v_emp.ename || ' | ' || v_emp.job);
        end loop;
        close c1;
    end;
    /
    

-- 커서의 활용 2번 : 입력창을 생성하여 
    declare
        v_emp employee%rowtype;
        cursor c1(e_eno employee.eno%type) is 
        select * from employee where eno = e_eno;
    begin
        -- 입력창을 통해 변수에 값을 입력함. -- 숫자
        v_eno := &input_dno;
        
        -- 커서를 통해서 커서의 조건에 대입하여 조회함
        for v in c1(v_eno) loop
            dbms_output.put_line(v.eno || ' | ' || v.ename || ' | ' || v.job || ' | ' || v.salary);
        end loop;
    end;
    /
    
    declare
        v_job employee.job%rowtype;
        cursor c1(e_job employee.job%type) is 
        select * from employee where job = e_job;
    begin
        -- 입력창을 통해 변수에 값을 입력함.
        v_job := &input_job; -- 문자
        
        -- 커서를 통해서 커서의 조건에 대입하여 조회함
        for v in c1(v_job) loop
            dbms_output.put_line(v.eno || ' | ' || v.ename || ' | ' || v.job || ' | ' || v.salary);
        end loop;
    end;
    /    
    
/*
< 예외 처리 방법 >
 - 에러(오류) - 문법적인 오류
 - 예외 - 실행할 때 발생하는 오류

< 예외 코드와 예외 메시지 >
 - sqlcode : 예외 코드
 - sqlerrm : 예외 메세지
  
< 예외 처리 >
 - 예외 처리가 되면 이후의 코드는 실행하지 않음.
 
 < PL/SQL의 예외의 종류 >
  - access_into_null : ora-06530 : 초기화되지 않은 속성값 할당
  - case_not_found : ora-06592 : case문의 where절이나 else절이 없는 경우
  - collection_is_null : ora-06531 : collection에서 초기화되지 않은 값을 할당
  - cursor_already_open : ora-06511 : 이미 커서가 open이 된 경우
  - dup_val_on_index : ora-00001 : unique 인덱스에 중복값을 입력한 경우
  - invalid_cursor : ora-01001 : 커서를 잘못 사용하였을 경우(ex, open하지 않은 커서를 사용하거나, close하는 경우)
  - invalid_number : ora-01722 : 문자에서 숫자로 잘못 변환된 경우
  - login_denied : ora-01017 : 로그인에 실패했을 경우
  - no_data_found : ora-01403 : select ~ into에서 결과행이 없을 경우
  - not_logged_on : ora-01012 : 데이터베이스에 접속되지 않은 경우
  - program_error : ora-06501 : PL/SQL 내부에 오류가 발생한 경우
  - rowtype_mismatch : ora-06504 : 선언된 변수가 커서 변수와 타입이 맞지 않는 경우
  - self_is_null : ora-30625 : 초기화 되지 않은 객체를 사용한 경우
  - storage_error : ora-06500 : PL/SQL의 메모리가 부족하거나 문제가 발생한 경우
  - subscript_beyond_count : ora-06533 : 컬렉션의 요소보다 큰 인덱스를 사용한 경우
  - sys_invalid_rowid : ora-01410 : 문자열을 rowid로 변환할 때 값이 적절하지 않은 경우
  - timeout_on_resource : ora-00051 : 자원에 대한 대기시간을 초과한 경우
  - too_many_rows : ora-01422 : select ~ into 문의 결과행이 지나치게 많을 경우
  - value_error : ora-06502 : 산술, 타입의 변환, 제약조건 등에서 오류가 발생한 경우
  - zero_divide : ora-01476 : 숫자를 0으로 나누려고 하는 경우

*/  

-- 예외 상황: 데이터 타입이 일치하지 않는 경우 
    declare
        v_ename number;
    begin
        select ename into v_ename
        from employee
        where eno = 7788;
        
        dbms_output.put_line('7788 사원명: ' || v_ename); -- 에러가 아닌 예외.
    end;
    /

-- 예외 처리 1번 - 1가지의 예외가 발생했을 때
    declare
        v_ename number;
    begin
        select ename into v_ename
        from employee
        where eno = 7788;
        
        dbms_output.put_line('7788 사원명: ' || v_ename);
    exception
        when value_error then
            dbms_output.put_line('예외 발생: 데이터 타입의 불일치 에러 발생');
    end;
    /

declare
    v_ename number;
begin
    select ename into v_ename
    from employee
    where eno = 7788;
    
    dbms_output.put_line('7788 사원명: ' || v_ename);
exception
    when value_error then
        dbms_output.put_line('예외 발생: 데이터 타입의 불일치 에러 발생');
        dbms_output.put_line('예외 번호: ' || sqlcode);
        dbms_output.put_line('예외 메시지: ' || sqlerrm);
        dbms_output.put_line('예외 발생 시간: ' || to_char(sysdate, 'YYYY/MM/DD AM HH:MI:SS'));
    when too_many_rows then 
        dbms_output.put_line('예외 발생: 지나치게 많은 행의 추출');
    when others then 
        dbms_output.put_line('예외 발생: 알 수 없는 예외 발생');
end;
/
   
   
/*
PL/SQL - Procedural Language / Structured Query Language
< 프로시저 > procedure
 - Stored Procedure, 저장된 프로시저
 - PL/SQL로 작성된 일련의 작업들을 다시 사용할 수 있도록 객체로 저장한 것.
 - EX) Procedure, Function, Trigger
 
< 프로시저의 장점 >
 - 복잡한 SQL을 간단한 프로그래밍 방법으로 사용할 수 있음.
 - 저장하여 필요할 때마다 반복적으로 사용할 수 있음.

< 프로시저의 파라미터 모드 >
 1. in 모드 : 파라미터로 값을 입력받을 때 사용하는 모드, 기본값이어서 생략 가능.
 2. out 모드 : 파라미터로 값을 리턴할 때 사용하는 모드
 3. inout 모드 : 파라미터로 값을 입력받고, 값을 리턴할 때 사용하는 모드 
*/
    
-- 문제1) 'SCOTT' 사원의 급여를 구하는 프로시저를 작성
-- 프로시저 생성
    set serveroutput on;
    
    create procedure sp_emp01 is
        v_salary employee.salary%type;
    begin
        select salary into v_salary
        from employee
        where ename = 'SCOTT';
        
        dbms_output.put_line('SCOTT 사원의 급여 : ' || v_salary);
    end;
    /
    
-- 프로시저 실행
    execute sp_emp01;
    
-- 프로시저 확인
    select * from user_procedures;
    
-- 프로시저의 내용 확인    
    select * from user_source where name = 'SP_EMP01';
    
-- 프로시저 삭제
    drop procedure sp_emp01;
    
    
-- 기존 프로시저 삭제 후 생성
-- 문제점 : 사원명이 바뀔때마다 다시 프로시저를 생성해야 한다.
    create or replace procedure sp_emp02 is
        v_salary employee.salary%type;
        v_ename employee.ename%type;
    begin
        v_ename := 'SMITH';
        select salary into v_salary
        from employee
        where ename = 'SMITH';
        
        dbms_output.put_line(v_ename || ' 사원의 급여 : ' || v_salary);
    end;
    /    
    
    execute sp_emp02;
    
-- 해결책 : 프로시저에서 사원명을 수정하는 것이 아니라 프로시저 실행시에 사원명을 입력하도록 함.
    create or replace procedure sp_emp03(v_ename in employee.ename%type) 
        is
        v_salary employee.salary%type;
    begin
        select salary into v_salary
        from employee
        where ename = v_ename;
        
        dbms_output.put_line(v_ename || ' 사원의 급여 : ' || v_salary);
    end;
    /        
    
    execute sp_emp03('KING');
    
-- 방법 4번 :out 모드
    create or replace procedure sp_emp04(v_ename in employee.ename%type, v_salary out employee.salary%type) 
        is
    begin
        select salary into v_salary
        from employee
        where ename = v_ename;
        
        -- dbms_output.put_line(v_ename || ' 사원의 급여 : ' || v_salary);
    end;
    /        
    
    --  variable v_salary employee.salary%type; -- 레퍼런스 변수는 선언 불가
    -- 스칼라 변수로 선언  
    variable v_salary number; 
    -- 프로시저 실행
    execute sp_emp04('SCOTT', :v_salary);
    
    -- 저장된 변수값 출력
    print v_salary;
    
-- 방법 5번 : in out 모드 활용
-- 문제 5번) 사원의 연봉을 변경하고, 변경된 연봉의 10%를 보너스로 하여 최종 연봉을 확인

    create or replace sp_emp05(v_ename in employee.ename%type, v_salary in out employee.salary%type)
    is 
    begin
        update employee
        set salary = v_salary + v_salary*0.1
        where ename = v_ename;
        dbms_output.put_line(v_ename || '사원의 연봉이 인상되었습니다.');
    end;
    /
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
