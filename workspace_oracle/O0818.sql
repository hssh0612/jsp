/*
< 기타 서브쿼리 >
 1. from절에 사용하는 서브쿼리
  - 인라인 뷰(inline view)
  - 장점 : 테이블의 크기가 대규모이거나, 테이블에 불필요한 내용이 너무 많을 때,
    사용하고자 하는 행과 열을 지정하여 결과를 줄여서 사용하게되는 장점이 있음.
  - 단점 : 가독성이 많이 떨어지는 단점이 생김.
*/
-- 문제 1) 10번 부서에서 근무하는 사원의 정보를 출력
-- 사번, 사원명, 부서번호, 부서명, 지역명
    
    -- 1번 방법 : 
    select eno, ename, e.dno, dname, loc
    from employee e, department d
    where e.dno = d.dno
    and e.dno = 10;
    
    -- 2번 방법 : from절에서 서브쿼리를 활용 --> 가독성 떨어짐.
    select eno, ename, e.dno, dname, loc
    from (select * from employee where dno = 10) e,
         (select * from department) d
    where e.dno = d.dno;
    
    -- 3번 방법 : 인라인 뷰의 가독성이 떨어지는 단점을 보완 -> with절을 사용.
    with
    e as (select * from employee where dno = 10),
    d as (select * from department)
    select eno, ename, e.dno, dname, loc
    from e,d
    where e.dno = d.dno;
    
    
/*
2. select절에서 사용하는 서브쿼리
 - select절에서 열에 해당하는 결과를 출력할 수 있도록 하는 방법
 - 장점 : 조인을 사용하지 않음, where절을 사용하지 않음
 - 단점 : 열이 복잡해져, 가독성이 떨어짐.

*/

-- 문제2) 사원 테이블과 급여 테이블을 활용하여 결과를 출력
-- 사번, 사원명, 업무, 연봉, 급여등급, 부서번호, 부서명
 -- 1번 방법
    select eno, ename, job, salary, grade, e.dno, dname
    from employee e, department d, salgrade s
    where e.dno = d.dno
    and salary between losal and hisal;
    
 -- 2번 방법 : select절에서 사용하는 서브쿼리
    select eno, ename, job, salary,
    (select grade from salgrade where e.salary between losal and hisal) "GRADE",
    dno,
    (select dname from department where e.dno = department.dno) "DNAME"
    from employee e;
    
    
/*
3. 다중열 서브쿼리
 - 같은 서브쿼리에서 비교하는 열이 여러 개일 경우에 사용
*/

-- 문제3) 부서별로 최고연봉을 부서번호, 최고연봉으로 출력
-- 1번 방법 : 다중행 서브쿼리
    select dno, salary from employee
    where salary in (select max(salary) from employee group by dno);
    
-- 2번 방법 : 다중열 서브쿼리
    select dno, salary from employee
    where (dno, salary) in (select dno, max(salary) from employee group by dno);
    
/*
4. 상호 연관 서브쿼리
 - 서브쿼리에서 메인쿼리를 사용하고, 다시 서브쿼리의 결과를 메인쿼리로 되돌려주는 방식
 - 단점 : 실행시간이 오래 걸려서, 성능을 저하.
*/

-- 문제 4) 사원 테이블에서 최저연봉보다 많은 연봉을 받는 사원의 정보를 출력
-- 부서별로 오름차순, 연봉별로 오름차순
    select * from employee e1
    where salary > (select min(salary) from employee e2 where e2.dno = e1.dno)
    order by dno, salary;
    
------------
/*
< SQL의 종류 >

1. DCL : Data Control Language, 데이터 제어어
 - 사용자 생성과 제거, 권한 부여와 회수 ...
 - grant, revoke ...

2. DDL : Date Definition Language, 데이터 정의어
 - 테이블의 생성과 구조 변경, 제거에 사용되는 명령어
 - create, alter, drop ...

3. DML : Date Mainpulation Language, 데이터 조작어
 - 데이터의 추가, 수정, 삭제에 사용되는 명령어
 - select, insert, update, delete ...
 
< 테이블 이름 정하는 규칙 > 
 1. 영문자, 한글, 숫자, 특수기호($, #, _) 사용 가능
 2. 숫자는 첫글자로는 사용 불가
 3. 공백은 사용 불가
 4. 30Byte까지 사용 가능. (영어는 30글자, 한글은 15글자(express 버전은 10글자))
 5. 같은 계정에서 같은 이름의 테이블은 사용 불가
 6. 예약어는 사용 불가
  - 권장 사항
  - 테이블은 명확하게 할 것을 권장
  - 한글은 사용하지 않는 것을 권장
  - 특수기호는 _만 사용할 것을 권장
  
< 컬럼 이름 정하는 규칙 >
1. 영문자, 한글, 숫자, 특수기호($, #, _) 사용 가능
2. 공백은 사용 불가
3. 30Byte까지 사용 가능. (영어는 30글자, 한글은 15글자(express 버전은 10글자))
4. 한 테이블에서 같은 열 이름은 사용 불가
5. 예약어는 사용 불가
 - 권장 사항
 - 열 이름은 명확하게 할 것을 권장
 - 한글은 사용하지 않을 것을 권장
 - 특수기호는 _만 사용할 것을 권장
 - 열 이름은 첫글자를 숫자로 사용 가능하지만, 되도록이면 첫글자로 숫자를 사용하지 않을것을 권장

*/

-- < 테이블을 생성하는 방법 >
-- 1. 테이블 생성
    create table dept (
    dno number(2),
    dname varchar2(14),
    loc varchar2(13)
    );
    
-- 2. 테이블 생성 -> 테이블 복사 1번 
 -- 서브쿼리를 사용
 -- 테이블의 모든 컬럼을 복사.
 -- 제약조건 복사되지 않음.
 -- 데이터도 복사됨.
    create table dept2
    as select * from department;

-- 3. 테이블 복사 2번
 -- 문제1) employee 테이블에서 20번 부서의 데이터를 eno, ename, 연봉에 2를 곱한 컬럼만을 가지는 테이블 emp20을 생성
    create table emp20
    as select eno, ename, salary*2 "salary2" from employee where dno = 20;
    
-- 4. 테이블 복사 3번
-- 데이터는 복사하지 않고, 테이블 구조만 복사
    create table dept3
    as select dno, dname from department where 0 = 1;
    
-- < 테이블의 구조를 변경하는 방법 >
-- 테이블의 구조 : 컬럼, 데이터타입
-- 1. 컬럼 추가
    alter table emp20 add(birthday date);
    
-- 2. 컬럼의 길이 변경
    alter table emp20 modify(ename varchar2(20));
    
-- 3. 컬럼 이름 변경
    alter table emp20 rename column birthday to b_day;
    
-- 4. 컬럼 삭제
    alter table emp20 drop column ename;
    
-- 가능 : 같은 타입의 길이 변경은 가능 (큰 길이로는 변경 가능)
    alter table emp20 modify(eno number(6));

-- 불가능 : 같은 타입의 길이라도 작은 길이로는 변경 불가능
    alter table emp20 modify(eno number(2));

-- 불가능 : 다른 데이터 타입으로는 변경 불가
    alter table emp20 modify(eno varchar2(6));

-- < 테이블명을 변경하는 방법 >
    rename emp20 to emp_20;
    
-- < 테이블을 제거하는 방법 >
    drop table emp_20;

    
-- < 테이블의 모든 데이터를 제거하는 방법 >
-- 테이블의 구조는 남아 있고, 데이터에 할당된 공간을 해제
-- 테이블의 제약조건과 관련된 인덱스, 뷰, 동의어 등은 그대로 유지
-- truncate : DDL, delete : DML
    truncate table dept2;

-- # 계정의 모든 테이블 확인하는 명령
    select * from tab;

/*
< 데이터 사전 >
 - 사용자와 데이터베이스 자원을 효율적으로 사용하고 관리하기 위해 다양한 정보를 저장하는 시스템 테이블의 집합
 - 사용자가 데이터 사전을 직접 수정하거나, 삭제할 수는 없음.
 
< 데이터 사전의 종류 >
 1. USER_**** : 사용자 자신의 계정이 소유한 객체에 대한 정보 
 2. ALL_**** : 사용자 자신과 권한을 부여받은 객체에 대한 정보
 3. DBA_**** : 데이터베이스 관리자만 접근 가능한 객체에 대한 정보
 4. V$_**** : 데이터베이스 성능 자체에 관련된 정보
 
 1) USER_****
    - 사용자 자신이 생성한 테이블, 인덱스, 뷰 등의 객체에 대한 정보를 제공
    - user_tables : 사용자 테이블에 관한 정보
    - user_views : 사용자 뷰에 관한 정보
    - user_indexes : 사용자 인덱스에 관한 정보
    - user_sequences : 사용자 시퀀스에 관한 정보
    
 2) ALL_****
    - 사용자 자신과 사용자가 접근할 수 있는 권한을 부여받은 테이블, 인덱스, 뷰 등에 객체에 대한 정보를 제공
    - all_tables : 사용자 테이블과 사용자가 접근할 수 있는 테이블에 관한 정보

 3) DBA_****
    - 데이터베이스 관리자 또는 시스템 관리자만 접근할 수 있는 정보를 제공
    - dba_tables : 관리자가 접근할 수 있는 모든 테이블에 관한 정보
*/

 -- 사용자가 생성한 모든 테이블 정보 확인
    select * from user_tables;
    select table_name from user_tables;
    
 -- all_tables
    select * from all_tables;
    select owner, table_name from all_tables;
    
 -- dba_tables
    select * from dba_tables;
    select owner, table_name from dba_tables;
    
/*
< DML >
 - 테이블에 데이터를 추가, 수정, 삭제하는 명령
 1. select : 데이터를 조회(검색)하는 명령
 2. insert : 데이터를 추가하는 명령
 3. update : 데이터를 수정하는 명령
 4. delete : 데이터를 삭제하는 명령
 
< 트랜잭션 (Transaction) >
 - 데이터의 삽입, 수정, 삭제에 대해서 최종적으로 확정을 하도록 하는 명령
 1. commit : 확정, 최종적으로 데이터베이스에 반영
 2. rollback : 되돌림, 데이터베이스에 반영하기 전 상태로 되돌림 
*/


create table emp
as select * from employee;

create table dept
as select * from department;

-- < 데이터 삽입 >
-- insert into 테이블명(필드명...) values(값...);
    
  -- 1. 테이블에 데이터 삽입 1번
    insert into emp(eno, ename, job, manager, hiredate, salary, commission, dno)
    values(8000,'JENIFFER', 'YUTUBER', 7839, '2023/01/03', 4500, null, 40);
    commit;
    
 -- 2. 데이터 삽입 2번
 -- 컬럼에 대한 값을 누락없이 순서대로 입력한다면 컬럼명을 생략할 수 있음.
    insert into emp values(8100,'STELLAR', 'BANKER',7902,'2022/08/08',4000, null, 40);
    commit;
    
 -- 3. 데이터 삽입 3번
 -- not null이 아닌 컬럼은 생략할 수 없고, 
 -- 추가하는 컬럼명을 명시하고, 값을 나열할 수 있음. 
    insert into emp(eno, ename, job) values (8100,'TOM', 'ACTOR');
    commit;

 -- 4. 데이터 삽입 4번
 -- 컬럼명을 명시하면, 순서는 바뀌어도 됨.
    insert into emp(eno, salary, ename) values(8200, 3500, 'JERRY');
    
 -- 5. 데이터 삽입 5번
 -- null인 컬럼에 대해서 값을 컬럼명과 값을 생략하면 null이 자동으로 삽입됨.
    insert into emp(eno, ename, job, manager, hiredate, salary, dno)
    values(8300,'KIM', 'Maker', 7788, '2022/11/11', 3200, 20);
    commit;
    
-- 6. 데이터 삽입 6번
-- 다른 테이블의 데이터를 복사하여 삽입 -> 컬럼의 순서와 개수가 일치할 때 가능
-- 서브 쿼리 사용
    insert into emp select * from employee;
    commit;

select * from emp;

-- < 데이터 수정 >
-- update 테이블명 set 변경내용 where 조건;
-- 문제1) dept 테이블에서 부서번호가 10번인 데이터의 부서명을 'Programming'으로 변경
    update dept set dname = 'PROGRAMMING' where dno =10;
    commit;
    
-- 문제 2) dept 테이블에서 부서번호가 20번인 데이터의 부서명을 'MARKETING', 지역명을 'SEOUL'로 변경
    update dept set loc = 'SEOUL', dname = 'MARKETING' where dno = 20;
    commit;
-- 문제 3) dept 테이블에서 10번 부서의 지역명을 30번 부서의 지역명으로 변경
    update dept 
    set loc = (select loc from dept where dno = 30)
    where dno = 10;
    commit;
-- 문제 4) dept 테이블에서 10번 부서의 부서명과 지역명을 40번 부서의 부서명과 지역명으로 변경.
    update dept
    set dname = (select dname from dept where dno = 40),
        loc = (select loc from dept where dno = 40)
    where dno = 10;
    commit;

    update dept
    set (dname, loc) = (select dname, loc from dept where dno = 40)
    where dno = 10;
    commit;
    
    insert into dept values(10, 'ACCOUNTING', 'SEOUL');
    insert into dept values(20, 'RESEARCH', 'INCHON');
    insert into dept values(30, 'SALES', 'SEJONG');
    insert into dept values(40, 'OPERATION', 'BUCHON');
    insert into dept values(50, 'INFORMATION', 'BUSAN');
    commit;

-- 주의)
-- 문제 5) dept 테이블의 부서명을 'INFORMATION'으로 변경.
    update dept set dname = 'INFORMATION';
    commit;
    
-- < 데이터 삭제 >
-- delete [from] 테이블명 where 삭제조건;
-- 문제 1) dept 테이블에서 10번 부서의 데이터를 삭제
    delete dept where dno =10;
    commit;
    
-- 문제 2) dept 테이블에서 20번 부서이면서 부서명이 RESEARCH인 부서를 삭제
    delete dept 
    where dno = 20 and dname = 'RESEARCH';
    commit;
-- 문제 3) emp 테이블에서 SALES 부서에서 근무한 사원의 데이터를 모두 삭제
    delete emp 
    where dno = (select dno from dept where dname = 'SALES');
    commit;

-- 문제 4) dept 테이블의 모든 데이터를 삭제
    delete dept;

/*
< truncate와 delete의 차이점 >
1. truncate
 - 테아블의 모든 데이터를 삭제, 데이터의 공간까지 삭제
 - DDL 명령, commit을 사용하지 않아도 됨.
 - where절 사용 불가

2. delete
 - where절을 사용하면 조건에 삭제
 - where절을 생략하면 모든 데이터를 삭제, 데이터의 공간은 남아 있음.
 - DML 명령, commit을 사용해야 최종 반영.
*/

-- < DDL, DML 확인 학습 Part.1 >
-- 1. employee 테이블을 복사하여 emp_insert 테이블을 빈 테이블로 생성
    create table emp_insert
    as (select * from employee where 0=1);
    commit;
    select * from emp_insert;

-- 2. emp 테이블에 아래의 데이터를 추가
-- 1000,'LEE', 'STUDENT', '2022/05/10', 1700, 230, 10
-- manager는 null
    insert into emp_insert values(1000,'LEE', 'STUDENT', null, '2022/05/10', 1700, 230, 10);
    commit;
    
-- 3. emp테이블에 아래의 데이터를 추가.
-- 1100, 'KIM', 'SOLDIER', 3200,20
-- manager와 commission은 null
-- hiredate는 오늘로부터 3개월 이전
    -- 3-1.
    insert into emp_insert(eno, ename, job, hiredate, salary, dno)
    vlues(1000,'KIM', 'SOLDIER', '2022/05/11', add_months(sysdate, -3), 3200, 20);
    commit;
    
    --3-2. 
    insert into emp_insert values(1000,'KIM', 'SOLDIER',null, '2022/05/11', add_months(sysdate, -3), 3200, null, 20);

-- 4. employee 테이블의 구조와 내용을 복사하여 emp_copy 테이블을 생성.
    create table emp_copy as select * from employee;
    
-- 5. emp_copy 테이블에서 사원번호 7788인 사원의 부서번호를 10번으로 수정
    update emp_copy set dno = 10 where eno = 7788; 
    
-- 6. emp_copy 테이블에서 사원번호 7788인 사원의 업무 및 급여를 사원번호 7499의 업무 및 연봉과 일치하도록 수정
    update emp_copy
    set (job, salary) = (select job, salary from emp_copy where eno = 7499)
    where eno = 7788;
    commit;

-- 7. emp_copy 테이블에서 사원번호 7369와 동일한 업무를 하는 사원의 부서번호를 7369 사원의 부서번호로 갱신.
    update emp_copy
    set dno =(select dno from emp_copy where eno = 7369)
    where job = (select job from emp_copy where eno = 7369);
    commit;

-- 8. department 테이블의 구조와 내용을 복사하여 dept_copy 테이블을 생성하시오.
    create table dept_copy as select * from department;

-- 9. dept_copy 테이블에서 부서명이 RESEARCH인 부서를 삭제
    delete from dept_copy where dname = 'RESEARCH';
    commit;

-- 10. dept_copy 테이블에서 부서번호가 10번이거나 40인 부서를 삭제
    delete from dept_copy where dno in (10,40);
    commit;
    
-- < DDL, DML 확인 학습 Part.2 >
-- 1. employee 테이블의 구조와 내용을 복사하여 employee2 테이블을 생성하시오.
-- 사번, 이름, 연봉, 부서번호 컬럼만 복사하고, 생성되는 컬럼의 이름은 e_id, name, sal, d_id로 지정하시오.
create table employee2
as (select eno e_id, ename name, salary sal, dno d_id from employee);
commit;

-- 2. employee2 테이블에서 d_id 컬럼을 삭제하시오.
alter table employee2 drop column d_id;
commit;

-- 3. employee2 테이블에서 sal 컬럼명을 salary로 변경하시오.
alter table employee2 rename column sal to salary;
commit;

-- 4. employee2 테이블에서 name 컬럼의 길이를 20으로 변경하시오.
alter table employee2 modify(name varchar2(20));
commit;

-- 5. employee2 테이블에 가변 문자열 15자리를 갖는 d_name 칼럼을 추가하시오.
alter table employee2 add(d_name varchar2(15));
commit;

-- ★★★★★★★★★★★
-- 일요일까지 이메일로 제출
-- 다음 주 월요일에는 제약조건에 대해서 공부.
-- 퀴즈1) 287~ 289 페이지의 5문제를 해결하시오.









    select * from dept;
    



























































    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    