-- 주석
★★★★★★★★★★★★★★★★★★★★★★★

--< 조인 (join) >
-- - 두 개 이상의 테이블을 연결하여 결과를 얻는 것
 
-- 문제1) 사원번호 7788이 근무하는 부서의 부서명을 출력
--  - 1.두 번의 질의를 해야 함 -> 2. 한 번의 질의를 사용하여 해결하도록 함.
  
--  1. 두개의 쿼리문으로 해결
--   select dno from employee where eno=7788; -> 20
--   select dname from department where dno = 20; -> RESEARCH

-- 문제1) 사원번호 7788이 근무하는 부서의 부서명을 출력
-- 1번 방법 -> 테이블명.컬럼명
    select employee.eno, employee.ename, department.dno, department.dname
    -- dno앞에는 department.dno 이나 employee.dno나 상관없다. 
    from employee, department
    where employee.dno = department.dno
    and employee.eno = 7788;

-- 2번 방법 -> 하나의 테이블에만 존재하는 컬럼의 테이블명은 생략가능.
    select eno, ename, employee.dno, dname
    from employee, department
    where employee.dno = department.dno
    and eno = 7788;
    
-- 3번 방법 - 테이블명에 대한 알리아스 사용
    select e.eno, e.ename, e.dno, d.dname
    from employee e, department d
    where e.dno = d.dno
    and e.eno = 7788;
    
-- < 이퀴조인 4가지 >
-- 4번 방법 - 테이블명에 대한 알리아스 사용, 유일한 컬럼은 알리아스를 생략 가능.
 -- 1) 이퀴 조인
 -- where절에 조인 조건을 적는 방법
    select eno, ename, e.dno, dname
    from employee e, department d
    where e.dno = d.dno
    and eno = 7788;
    
 -- 2) natural 조인
 -- 따로 조인 조건을 명시하지 않음 -> 조건 : 두 테이블에서 조인하는 컬럼명이 동일할 때
 -- 알리아스를 사용 불가
 -- 동일한 이름으로 존재하는 컬럼명에 대해서도 알리아스를 사용하지 않음.
 -- 단점 : 조인하는 컬럼명이 명시되지 않음.
    select eno, ename, dno, dname
    from employee natural join department
    where eno = 7788;
    
 -- 3) join ~ using
 -- 장점 : 조인 컬럼명이 명시되지 않는 natural 조인의 문제점을 해결함.
 -- 알리아스를 사용불가
 -- 두 테이블에서 조인하는 컬럼명이 동일할 때 사용 가능.
    select eno, ename, dno, dname
    from employee join department
    using(dno)
    where eno = 7788;
    
 -- 4) join ~ on (inner join)
 -- 이퀴조인 거의 동일한 방법
 -- 이퀴조인에서는 조인조건을 where절에 기술, join~on에서는 on 절에 조인조건을 기술
 -- 장점 : on절에는 조인조건만 기술함.
 -- 알리아스를 사용
 -- 유일한 컬럼명에서는 알리아스를 생략할 수 있고, 두 테이블에 모두 존재하는 컬럼명은 테이블명(알이아스)를 명시해야 함.
    select eno, ename, d.dno, dname
    from employee e inner join department d
    on e.dno = d.dno
    where  eno = 7788;

/*
 < 넌이퀴 조인(Non-Equi Join) >
 - 이퀴조인은 =(equal)로 조인 조건을 만드는 것이라면,
 - 넌이퀴조인은 =이 아닌 방법으로 조인조건을 만드는 방법
 */
 
 /*
 문제 2) 사번, 사원명, 급여, 해당 급여의 등급을 출력.
 */
    select eno, ename, salary, grade
    from employee, salgrade
    where salary between losal and hisal;
    
 -- 문제3) 사번, 사원명, 급여, 해당 급여의 등급, 부서번호, 부서명을 출력.
 
    select eno, ename, salary, grade, employee.dno, dname
    from employee, salgrade, department
    where employee.dno = department.dno
    and salary between losal and hisal;
    
/*
3. 셀프 조인(Self Join)
 - 한 개의 테이블을 두 개의 테이블로 생각하고, 조인하여 사용하는 방법.
*/
 -- 문제4) 사원 테이블에서 사번, 사원명, 관리자번호, 관리자명을 출력.
    select e.eno, e.ename, m.eno, m.ename
    from employee e, employee m
    where e.manager = m.eno
    order by e.eno;
 
 
 
 
 
 