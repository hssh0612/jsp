/*
< PL/SQL >
 - Programming SQL
 - SQL만으로 구현하기 어려운 작업을 수행하기 위한 프로그래밍 언어.
 - 변수, 반복문, 조건문, 예외처리 등을 이용하여 다양한 방법으로 SQL문을 실행할 수 있음.
 
< PL/SQL의 형식 >
 - declare, begin, exception의 3개의 블럭으로 구성.
 - declare, exception 블럭은 생략 가능, begin은 필수.
 
 declare --> 선언부 : 변수 또는 상수를 선언
 
 begin --> 실행부 : 조건문, 반복문, 함수 정의 등의 실질적인 프로그래밍의 내용을 기술
 
 exception --> 예외처리부 : 실행부에서 예외가 발생했을 때 처리
 
 end;
 
< PL/SQL을 작성할 때의 규칙 >
 - 한 문자가 끝날때마다 세미콜론을 사용.
 - end 뒤에 세미콜론을 사용하여 블럭이 끝났다는 것을 명시함
 - 쿼리문을 실행할 때는 반드시 /를 입력해야 함.
 - 실행 결과를 화면으로 출력하기 위해서는 set serveroutput on;이라는 명령을 사용해야 함.
 - begin 블럭 안에서 내용을 출력하기 위한 함수로 dbms_output.put_line()함수를 사용함.
 - 주석은 --(한줄 주석), /* */--(여러줄 주석)을 사용할 수 있음.
/* 
< PL/SQL의 문법 >
 := -> 할당 연산자
 constant -> 상수를 선언할 때 사용
 
< PL/SQL의 데이터 타입 >
 1.  스칼라 타입 (scalar type)
  - 오라클에서 사용하는 기본적인 데이터 타입
  - number(숫자), varchar2(문자), date(날짜), boolean(논리)
 2. 레퍼런스 타입 (reference type)
  - 데이터베이스에 존재하는 특정 테이블의 컬럼 한개 또는 행전체를 참조하는 데이터 타입 
  - %type : 컬럼 1개, %rowtype : 행 전체
 
< PL/SQL에서의 변수명을 명명하는 방법 >
 - 영어, 한글, 숫자, 기호($, #, _) 사용 가능
 - 숫자는 첫글자로는 사용할 수 없음
 - 영어 대소문자를 구분하지 않음
 - 예약어는 사용 불가
 - 공백은 사용 불가
 - 30byte 이하로 사용 가능
*/

-- 문제1)
    set serveroutput on;
    begin
        dbms_output.put_line('Welcome to PL/SQL');
    end;
    /
    
-- 문제2) 사원 테이블에서 사번이 7788인 사원의 이름을 출력하시오.
    declare
        v_eno number(4) := 7788; -- 변수 선언과 동시에 값을 할당.(최초로 값을 할당 = 초기화)
        v_ename varchar2(10);    -- 변수 선언
    begin
        v_ename := 'SCOTT'; -- 변수에 값을 할당
        dbms_output.put_line('사번: ' || v_eno || ', 사원명: ' || v_ename);
    end;
/

-- 문제 3) SCOTT 사원의 연봉인 3000만원에서 세금 10%를 공제한 실질 연봉을 출력
    declare
        v_name varchar2(10) := 'SCOTT'; -- 변수 선언 및 초기화
        v_salary number(7,2); -- 변수 선언
        v_salary2 number(7,2); -- 변수 선언
        v_tax number(4,2) := 0.1; -- 상수 선언 및 초기화
    begin
        v_salary := 3000; -- 값을 대입
        v_salary2 := v_salary - v_salary * v_tax;
        dbms_output.put_line(v_name || ' 실질 연봉 : ' || v_salary2);
    end;
    /

-- 문제 4) 10번 부서의 부서명인 '영업부'를 출력.
    declare
        v_dno number(2) not null := 10; -- not null 설정
        v_dname varchar2(10) not null default '영업부'; -- 기본값 설정
    begin
        dbms_output.put_line(v_dno || '번 부서 : ' || v_dname);
    
    end;
    /

-- 문제5) 사번이 7369인 SMITH 사원의 사번과 사원명을 출력
    declare
        v_eno employee.eno%type; -- 레퍼런스 변수 선언 (컬럼 한개)
        v_ename employee.ename%type;
    begin
        v_eno := 7369;
        v_ename := 'SMITH';
        dbms_output.put_line('사번 : ' || v_eno || ', 사원명 : ' || v_ename);
    end;
    /

-- 문제6) 30번 부서의 부서 정보를 출력 (부서번호, 부서명, 지역명)
 -- 1번 방법 : %type (컬럼 1개)
    declare
        v_dno department.dno%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
    begin
        select dno, dname, loc into v_dno, v_dname, v_loc
        from department
        where dno = 30;
        dbms_output.put_line(v_dno || ' | ' || v_dname || ' | ' || v_loc);
    end;
    /

 -- 2번 방법 : %rowtype (행 전체)
    declare
        v_dept department%rowtype; -- rowtype: 행전체
    begin
        select dno, dname, loc into v_dept
        from department
        where dno = 30;
    
        dbms_output.put_line(v_dept.dno || ' | ' || v_dept.dname || ' | ' || v_dept.loc);
    end;
    /

-- 문제7) 사원 테이블을 활용하여 사번이 7902인 사원의 사번, 사원명, 업무, 입사일, 연봉을 출력
-- 3가지 방법(스칼라 변수, 레퍼런스 변수(%type, %rowtype))

-- 1번 방법 : 스칼라 변수
    declare
        v_eno number(4);
        v_ename varchar2(10);
        v_job varchar2(15);
        v_hiredate varchar2(20);
        v_salary number(7,2);
    begin
        select eno, ename, job, hiredate, salary 
        into v_eno, v_ename, v_job, v_hiredate, v_salary
        from employee
        where eno = 7902;
        
        dbms_output.put_line('사번 | 사원명 | 업무 | 입사일 | 연봉');
        dbms_output.put_line('-----------------------------------');
        dbms_output.put_line(v_eno || ' | ' || v_ename || ' | ' || v_job || '|' || v_hiredate || '|' || v_salary);
    end;
    /

-- 2번 방법 : 레퍼런스 변수 (%type)
   declare
        v_eno employee.eno%type;
        v_ename employee.ename%type;
        v_job employee.job%type;
        v_hiredate employee.hiredate%type;
        v_salary employee.salary%type;
    begin
        select eno, ename, job, hiredate, salary 
        into v_eno, v_ename, v_job, v_hiredate, v_salary
        from employee
        where eno = 7902;
        
        dbms_output.put_line('사번 | 사원명 | 업무 | 입사일 | 연봉');
        dbms_output.put_line('-----------------------------------');
        dbms_output.put_line(v_eno || ' | ' || v_ename || ' | ' || v_job || '|' || v_hiredate || '|' || v_salary);
    end;
    /

-- 3번 방법 : 레퍼런스 변수 (%rowtype)
    declare
        v_emp employee%rowtype;
    begin
        select *
        into v_emp
        from employee
        where eno = 7902;
        
        dbms_output.put_line('사번 | 사원명 | 업무 | 입사일 | 연봉');
        dbms_output.put_line('-----------------------------------');
        dbms_output.put_line(v_emp.eno || ' | ' || v_emp.ename || ' | ' || v_emp.job || '|' || v_emp.hiredate || '|' || v_emp.salary);
    end;
    /

/*
< 조건문 >
 - if문, case문
 
 1. if문
  [ 조건이 1개일 때 ]
  if 조건 then
     실행문
  end if;
  
  [ 조건이 2개일 때 ]
  if 조건1 then
     실행문;
  else
     실행문;
  end if;
  
  [ 조건이 3개 이상일 때 ]
  if 조건1 then
     실행문;
  elsif 조건2 then
     실행문;
  else
     실행문;
  end if;
  
*/

-- 문제8) 주어진 변수의 양수, 음수, 0인지의 여부를 판단하시오.
    declare
        v_number number := 10;
    begin
        if v_number > 0 then
            dbms_output.put_line(v_number || '는 양수입니다.');
        end if;
    end;
    /

    declare
        v_number number := -10;
    begin
        if v_number > 0 then
            dbms_output.put_line(v_number || '는 양수입니다.');
        else
            dbms_output.put_line(v_number || '는 음수입니다.');
        end if;
    end;
    /

    declare
        v_number number := -10;
    begin
        if v_number > 0 then
            dbms_output.put_line(v_number || '는 양수입니다.');
        elsif v_number < 0 then
            dbms_output.put_line(v_number || '는 음수입니다.');
        else
            dbms_output.put_line(v_number || '입니다.');
        end if;
    end;
    /

--# case문
    declare
        v_number number := 0;
    begin
        case
            when v_number > 0 then
                dbms_output.put_line(v_number || '은(는) 양수입니다.');
            when v_number < 0 then
                dbms_output.put_line(v_number || '은(는) 음수입니다.');
            else
                dbms_output.put_line(v_number || ' 입니다.');
        end case;
    end;
    /

-- 문제9) 주어진 숫자에 대해 홀수, 짝수 여부를 판별
-- 2가지 방법(if문, case문)
  -- if문
    declare
        v_number number := 10;
    begin
        if mod(v_number,2) = 0 then
            dbms_output.put_line(v_number || '은(는) 짝수입니다.');
        else
            dbms_output.put_line(v_number || '은(는) 홀수입니다.');
        end if;
    end;
    /
  
  --# case문 1번
    declare
        v_number number := 10;
    begin
        case
            when mod(v_number,2) = 0 then
                dbms_output.put_line(v_number || '은(는) 짝수입니다.');
            else
                dbms_output.put_line(v_number || '은(는) 홀수입니다.');
        end case;
    end;
    /

  --# case문 2번
    declare
        v_number number := 10;
    begin
        case mod(v_number,2)
            when 0 then
                dbms_output.put_line(v_number || '은(는) 짝수입니다.');
            else
                dbms_output.put_line(v_number || '은(는) 홀수입니다.');
        end case;
    end;
    /

-- 문제10번) 주어진 국어, 영어, 수학 점수에 대한 평균으로 학점을 판별
-- 3가지 방법(if문 1가지, case 2가지)

 -- 1번
    declare
        v_kor number := 92;
        v_eng number := 93;
        v_mat number := 93;
        v_avg number(5,2);
    begin
        v_avg := (v_kor + v_eng + v_mat) / 3;
        dbms_output.put_line('평균 : ' || v_avg);
        
        if v_avg >= 90 then
            dbms_output.put_line('학점 : A');
        elsif v_avg >= 80 then
            dbms_output.put_line('학점 : B');
        elsif v_avg >= 70 then
            dbms_output.put_line('학점 : C');
        elsif v_avg >= 60 then
            dbms_output.put_line('학점 : D');
        else
            dbms_output.put_line('학점 : F');
        end if;
    end;
    /
 
 -- 2번
    declare
        v_kor number := 92;
        v_eng number := 93;
        v_mat number := 93;
        v_avg number(5,2);
    begin
        v_avg := (v_kor + v_eng + v_mat) / 3;
        dbms_output.put_line('평균 : ' || v_avg);
        
        case
            when v_avg >= 90 then
                dbms_output.put_line('학점 : A');
            when v_avg >= 80 then
                dbms_output.put_line('학점 : B');
            when v_avg >= 70 then
                dbms_output.put_line('학점 : C');
            when v_avg >= 60 then
                dbms_output.put_line('학점 : D');
            else
                dbms_output.put_line('학점 : F');
        end case;
    end;
    /
   
 
 -- 3번
    declare
        v_kor number := 92;
        v_eng number := 93;
        v_mat number := 93;
        v_avg number(5,2);
    begin
        v_avg := (v_kor + v_eng + v_mat) / 3;
        dbms_output.put_line('평균 : ' || v_avg);
        
        case trunc(v_avg/10)
            when 9 then
                dbms_output.put_line('학점 : A');
            when 8 then
                dbms_output.put_line('학점 : B');
            when 7 then
                dbms_output.put_line('학점 : C');
            when 6 then
                dbms_output.put_line('학점 : D');
            else
                dbms_output.put_line('학점 : F');
        end case;
    end;
    /
   
/*
< 반복문 > loop문
 1. 기본 loop문
     loop
        실행문;
        증감값;
        반복문의 탈출 조건;
     end loop;
 
 2. while loop문
     while 조건 loop
        실행문;
        증감값;
     end loop;
 
 3. for loop문
  - 시작값부터 끝값까지 1씩 증가하면서 실행
  - i : 제어 변수, 1씩 증가함을 전제로 사용
  - reverse : 끝값부터 시작값으로 1씩 감소하면서 실행
  
    for i in 시작값..끝값 loop
        실행문;
    end loop;

 4. 커서를 사용한 for loop문
  - # exit : 반복문 탈출
  - # exit when 조건 : 조건에 따라 반복문 탈출
  - # continue : 실행문을 생략할 때 사용
  - # exit continue : 조건에 따라 실행문을 생략할 때 사용

*/

-- 문제 11번) 1부터 10까지 1씩 증가하는 값을 출력
-- 기본 loop문 - 1번
    declare
        v_num number := 1;
    begin
        loop
            dbms_output.put_line(v_num);
            v_num := v_num + 1;
            if v_num > 10 then
                exit;
            end if;
        end loop;
    end;
    /

-- 기본 loop문 - 2번
    declare
        v_num number := 1;
    begin
        loop
            dbms_output.put_line(v_num);
            v_num := v_num + 1;
            exit when v_num > 10;
        end loop;
    end;
    /

-- while loop문 
    declare
        v_num number := 1;
    begin
        while v_num <= 10 loop
            dbms_output.put_line(v_num);
            v_num := v_num + 1;
        end loop;
    end;
    /    

-- 3-1. for loop문 - 1번
    begin
        for i in 1..10 loop
            dbms_output.put_line(i);
        end loop;
    end;
    /    

-- 3-2. for loop문 - 2번 - reverse
    begin
        for i in reverse 1..10 loop
            dbms_output.put_line(i);
        end loop;
    end;
    /  

-- 문제12번) 1부터 10까지 중에서 3의 배수를 제외하고 출력
 -- 1-1. for loop문 1번 - continue문 사용
    begin
        for i in 1..10 loop
            if mod(i,3) = 0 then
                continue;
            end if;
            dbms_output.put_line(i);
        end loop;
    end;
    /

 -- 1-2. for loop문 2번 - continue문 사용
    begin
        for i in 1..10 loop
            continue when mod(i,3) = 0;
            dbms_output.put_line(i);
        end loop;
    end;
    /

-- 문제 13) 주어진 단에 대해 구구단을 출력
-- 3가지 반복문

 -- 1번
    declare
        v_dan number := 5;
        v_i number := 1;
    begin
        loop
            dbms_output.put_line(v_dan || ' * ' || v_i || ' = ' || v_dan*v_i);
            v_i := v_i +1;
            exit when v_i > 9;
        end loop;
    end;
    /

 -- 2번
    declare
        v_dan number := 5;
        v_i number := 1;
    begin
        while v_i < 10 loop
            dbms_output.put_line(v_dan || ' * ' || v_i || ' = ' || v_dan*v_i);
            v_i := v_i +1;
        end loop;
    end;
    /
 
-- 3번
    declare
        v_dan number := 5;
    begin
        for i in 1..9 loop
            dbms_output.put_line(v_dan || ' * ' || i || ' = ' || v_dan*i);
        end loop;
    end;
    /

/*
< 레코드 > record
 - 데이터 타입이 다른 변수를 하나로 묶어서 사용하는 것.
 - 선언부에서 사용함. 

< 중첩 레코드 >
 - 레코드 안에 또다른 레코드를 포함하는 레코드.
*/

    declare
        -- 레코드 정의
        type RECORD_DEPT is record (
            dno number(2) not null := 50,
            dname varchar2(14),
            loc department.loc%type
        );
        -- 레코드 변수 선언
        dept_r RECORD_DEPT;
    begin
        --레코드 변수 값을 할당
        dept_r.dno := 50;
        dept_r.dname := 'MARKETING';
        dept_r.loc := 'SEOUL';
        
        -- 레코드 변수 값을 출력
        dbms_output.put_line(dept_r.dno || ' | ' || dept_r.dname || ' | ' || dept_r.loc);
    
    end;
    /

-- 문제14번) 레코드 RECORD_DEPT을 사용하여 department 테이블에 값을 추가
    declare
        -- 레코드 정의
        type RECORD_DEPT is record (
            dno number(2) not null := 50,
            dname varchar2(14),
            loc department.loc%type
        );
        -- 레코드 변수 선언
        dept_r RECORD_DEPT;
    begin
        --레코드 변수 값을 할당
        dept_r.dno := 50;
        dept_r.dname := 'MARKETING';
        dept_r.loc := 'SEOUL';
        
        -- 레코드 변수 값을 department 테이블에 추가
        insert into department values(dept_r.dno, dept_r.dname, dept_r.loc);
    end;
    /

commit;

    declare
        -- 레코드 정의
        type RECORD_DEPT is record (
            dno number(2) not null := 50,
            dname varchar2(14),
            loc department.loc%type
        );
        -- 레코드 변수 선언
        dept_r RECORD_DEPT;
    begin
        --레코드 변수 값을 할당
        dept_r.dno := 60;
        dept_r.dname := 'SALES';
        dept_r.loc := 'BUSAN';
        
        -- 레코드 변수 값을 department 테이블에 추가 -> 레코드 변수의 값을 한꺼번에 추가
        insert into department values dept_r;
    end;
    /

-- 문제 16) 레코드 RECORD_DEPT를 사용하여 department 테이블의 내용을 수정
    declare
        -- 레코드 정의
        type RECORD_DEPT is record (
            dno number(2) not null := 50,
            dname varchar2(14),
            loc department.loc%type
        );
        -- 레코드 변수 선언
        dept_r RECORD_DEPT;
    begin
        --레코드 변수 값을 할당
        dept_r.dno := 55;
        dept_r.dname := 'INFO';
        dept_r.loc := 'ILSAN';
        
        -- 레코드 변수 값을 통해 department 테이블의 값 수정
        update department
        set row = dept_r
        where dno = 50;
    end;
    /

commit;

-- 중첩 레코드의 사용

    declare
        -- 레코드 정의
        type RECORD_DEPT is record (
            dno number(2) not null := 50,
            dname varchar2(14),
            loc department.loc%type
        );
        -- 레코드 정의 : 중첩 레코드로 정의
        type RECORD_EMP is record (
            eno employee.eno%type,
            ename employee.ename%type,
            dept_r RECORD_DEPT -- 레코드 변수가 레코드의 멤버가 됨
        );
        -- 레코드 변수 선언
        emp_r RECORD_EMP;
    begin
        --레코드 변수 값을 할당
        emp_r.eno := 8000;
        emp_r.ename := 'KIM';
        emp_r.dept_r.dno := 70;
        emp_r.dept_r.dname := 'DEVELOPMENT';
        emp_r.dept_r.loc := 'DAEJEON';
        
        -- 레코드 변수 값을 출력
        dbms_output.put_line(emp_r.eno || ' | ' || emp_r.ename || ' | ' || emp_r.dept_r.dno || ' | ' || emp_r.dept_r.dname || ' | ' || emp_r.dept_r.loc);
    end;
    /

/*
< 컬렉션 > collection
 - 데이터타입이 같은 여러개의 데이터를 저장하는 데이터타입
 - 연관 배열
 - 선언부에서 정의하고 선언.

# 연관 배열
 - 같은 데이터타입의 값을 저장하는 배열
 - 키와 값을 저장하는 구조
 - 인덱스(키)를 통해서 값을 불러오는 방식의 배열
 - 키는 중복되지 않음.
 
< 컬렉션 메소드 >
 - 컬렉션을 다룰 때 사용하는 메소드
 - count : 컬렉션의 개수
 - first : 컬렉션의 첫번째 인덱스 번호
 - last : 컬렉션의 마지막 인덱스 번호
 - prior(n) : n번 이전 인덱스 번호
 - next(n) : n번 다음 인덱스 번호
 - delete(n) : n번 인덱스의 값을 컬렉션에서 삭제
*/

    declare
        -- 연관 배열 정의
        type EX01_ARR is table of varchar2(10) index by pls_integer;
        -- 연관 배열 변수 선언
        txt_arr EX01_ARR;
    begin
        txt_arr(1) := 'HTML';
        txt_arr(2) := 'JAVA';
        txt_arr(3) := 'ORACLE';
        txt_arr(4) := 'JSP';
        
        dbms_output.put_line(txt_arr(1) || ', ' || txt_arr(2) || ',' || txt_arr(3) || ', ' || txt_arr(4));
    end;
    /

-- 레코드와 연관 배열을 활용한 예제 1번
    declare
        -- 레코드 정의
        type RECORD_DEPT is record (
            dno department.dno%type,
            dname department.dname%type,
            loc department.loc%type
        );
        -- 연관 배열 정의
        type ARR_EX is table of RECORD_DEPT index by pls_integer;
        -- 연관 배열 변수 선언
        dept_arr ARR_EX;
        -- 인덱스 변수 선언
        idx pls_integer := 0;
    begin
        for i in (select * from department) loop
            idx := idx + 1;
            dept_arr(idx).dno := i.dno;
            dept_arr(idx).dname := i.dname;
            dept_arr(idx).loc := i.loc;
            
            dbms_output.put_line(dept_arr(idx).dno || ' | ' || dept_arr(idx).dname || ' | ' || dept_arr(idx).loc);
        end loop;
    end;
    /

-- 문제 17) 레코드와 연관 배열을 사용하여, employee 테이블의 사번, 사원명, 업무, 급여을 출력
-- 레코드명 : RECORD_EMP, 연관배열명 : ARR_EMP
    declare
        -- 레코드 정의
        type RECORD_EMP is record (
            eno employee.eno%type,
            ename employee.ename%type,
            job employee.job%type,
            salary employee.salary%type
        );
        -- 연관 배열 정의
        type ARR_EXP is table of RECORD_EMP index by pls_integer;
        -- 연관 배열 변수 선언
        emp_arr ARR_EXP;
        -- 인덱스 변수 선언
        
        idx pls_integer := 0;
    begin
        dbms_output.put_line(' 사번 | 사원명 |  업무  |  연봉 ');
        for i in (select * from employee) loop
            idx := idx + 1;
            emp_arr(idx).eno := i.eno;
            emp_arr(idx).ename := i.ename;
            emp_arr(idx).job := i.job;
            emp_arr(idx).salary := i.salary;

            dbms_output.put_line(emp_arr(idx).ename || ' | ' || emp_arr(idx).ename || ' | ' || emp_arr(idx).job || ' | ' || emp_arr(idx).salary);
        end loop;
        
        dbms_output.put_line('----------------------------------');
        -- 연관 배열의 값을 삭제
        emp_arr.delete(15);
        
        -- 연관 배열 메소드 활용
        dbms_output.put_line('배열의 개수 : ' || emp_arr.count);
        dbms_output.put_line('배열의 첫번째 값 : ' || emp_arr.first);
        dbms_output.put_line('배열의 마지막 값 : ' || emp_arr.last);
        dbms_output.put_line('배열의 14번 이전 인덱스 : ' || emp_arr.prior(14));
        dbms_output.put_line('배열의 10번 다음 인덱스 : ' || emp_arr.next(10));
    end;
    /

-- 문제18) employee 사원의 값을 저장하는 레코드를 생성하여, 레코드의 값을 employee 테이블에
-- 저장하는 PL/SQL을 생성하시오.
-- 레코드명: RECORD_EMP
    declare
    -- 레코드 정의
    
    -- 레코드 변수 선언
    
    begin
    
    end;
    /




















































































































































