-- 서브쿼리 파트
-- ★★★★★★★★★★★★★★
/*
< 서브 쿼리 (Sub Query) >
 - 다른 쿼리문 안에 들어가 있는 쿼리를 가진 쿼리.
 - 서브 쿼리문을 가지고 있는 메인 쿼리문의 형태.
 - main query : 바깥쪽에 있는 쿼리문 
 - sub query : 안쪽에 들어가 있는 쿼리문, 괄호로 싼 쿼리문
  --> 일반적으로 main query 안에 sub query가 포함된 형태의 쿼리문을 서브 쿼리문이라고 부름.
*/


-- 문제1) SCOTT 사원보다 연봉이 많은 사원의 이름과 연봉을 확인.
    -- 2번의 쿼리를 통해 문제 해결
      -- 1. SCOTT 사원의 연봉을 확인 --> 결과 : 3000
         select salary from employee where ename = 'SCOTT';
      -- 2. 연봉이 3000보다 많은 사원의 이름과 연봉을 확인.
         select ename, salary from employee where salary > 3000;
         
    -- 1번의 쿼리를 통해서 문제 해결
         select ename, salary from employee
         where salary > (select salary from employee where ename = 'SCOTT');
         
    -- 1번 문제를 조인으로 해결한다면.
        -- 셀프 조인 -> 이퀴조인
        select o.ename, o.salary
        from employee s, employee o
        where s.salary < o.salary
        and s.ename = 'SCOTT';
        
        select o.ename, o.salary
        from employee s join employee o
        on s.salary < o.salary
        where s.ename = 'SCOTT';

-- # 단일 행 서브쿼리
-- 문제2) 최고연봉을 받는 사원의 사원명, 직무, 연봉을 출력
         select ename, job, salary
         from employee 
         where salary = (select max(salary) from employee);

-- # 단일행 서브쿼리
-- 문제3) SMITH와 동일한 부서에서 근무하는 사원의 사번, 이름, 부서번호를 출력
         select eno, ename, dno
         from employee
         where dno = (select dno from employee where ename = 'SMITH');
         
         -- 조인으로 문제를 해결한다면 -> 셀프 조인 - 이퀴조인
         select o.eno, o.ename, o.dno
         from employee s, employee o
         where s.dno = o.dno
         and s.ename = 'SMITH';
         
         select o.eno, o.ename, o.dno
         from employee s join employee o
         on s.dno = o.dno
         where s.ename = 'SMITH';

-- # 단일행 서브쿼리
-- 문제4) 사원 테이블의 평균연봉보다 작은 연봉을 받는 사원의 사원명, 직무, 연봉을 출력
         select ename, job, salary
         from employee
         where salary < (select avg(salary) from employee);

★★★
-- # 단일행 서브쿼리 
-- 문제5) 부서별 최저연봉이 30번 부서의 최저연봉보다 작은 부서의 부서번호와 최저연봉을 구해라.
         select e.dno, min(salary)
         from department d, employee e
         where salary < (select min(salary) from employee where dno = 30)
         group by e.dno, salary;
         
         -- * 강사님
         select dno, min(salary) 
         from employee
         group by dno
         having min(salary) < (select min(salary) from employee where dno = 30);
         

-- ########
/*
< 서브쿼리의 종류 >
 - 서브쿼리의 결과행의 개수에 따른 구분
    1. 단일행 서브쿼리
     - 결과가 1개인 서브쿼리문
    2. 다중해 서브뭐리
     - 결과가 2개 이상인 서브쿼리문
     
< 서브쿼리에서 사용하는 연산자 >
 1. 단일행 비교
 - >, >=, <, <=, = <>
 2. 다중행 비교
 - in, any(some), all, exists
 - >any, >=any, <any, <=any, =any(in), <>any(not in)
 - >all, >=all, <all, <=all, =all, <>all
 - exists
 
< 다중행에서의 연산자 구분 >
- any: 메인쿼리의 비교조건이 서브쿼리의 결과와 하나이상 일치할 때 사용
- all: 메인쿼리의 비교조건이 서브쿼리의 결과와 모두 일치할 때 사용 

< 다중행 서브쿼리에서의 any와 all의 차이점 >
1. any(some) : 서브쿼리의 여러 결과 중에서 한 가지만 만족해도 결과를 출력
 - <any : 서브쿼리의 결과 중에서 최대값보다 작은 값을 출력
 - >any : 서브쿼리의 결과 중에서 최소값보다 큰 값을 출력
2. all : 서브쿼리의 여러 결과를 모두 만족해야 결과를 출력
 - <all : 서브쿼리의 결과 중에서 최소값보다 작은 값을 출력
 - >all : 서브쿼리의 결과 중에서 최대값보다 큰 값을 출력

2. all
*/
-- # 다중행 서브쿼리
-- 문제6) 부서별 최저연봉을 받는 사원의 사번과 사원명을 출력
    -- ORA-01427: single-row subquery returns more than one row
    -- 단일행 쿼리문에 대해서 여러 개의 결과를 처리하여 발생하는 에러
         select eno, ename
         from employee
         where salary < (select min(salary) from employee group by dno);
         
    -- 해결책
        select dno, eno, ename from employee
        where salary in (select min(salary) from employee group by dno);
        
        select dno, eno, ename from employee
        where salary = any (select min(salary) from employee group by dno);
        
-- # 다중행 서브쿼리
-- select salary from employee where job = 'SALESMAN'; --> 1600,1500,1250,1250
-- 문제7) 직무가 SALESMAN이 아니면서, 연봉이 임의의 SALESMAN보다 낮은 사원의 사번, 사원명, 직무, 연봉을 출력
        select eno, ename, job, salary
        from employee
        where job != 'SALESMAN'
        and salary <any (select salary from employee where job = 'SALESMAN');
        
-- # 다중행 서브쿼리
-- select salary from employee where job = 'SALESMAN'; --> 1600,1500,1250,1250
-- 문제 8) 직무가 SALESMAN이 아니면서, 연봉이 SALESMAN보다 낮은 사원의 사번, 사원명, 직무, 연봉을 출력
        select eno, ename, job, salary
        from employee
        where job != 'SALESMAN'
        and salary <all (select salary from employee where job = 'SALESMAN');
        
-- #
-- 문제9) 부서 테이블에서 10번 부서의 부서명이 존재한다면 사원 테이블의 모든 정보 출력
    select * from employee
    where exists (select dname from department where dno = 10);

-- 문제10) 부서 테이블에서 40번 부서가 부서명이 존재한다면 사원 테이블의 모든 정보 출력
    select * from employee
    where exists (select dname from department where dno = 50);
         
         
-- ★★★★★
-- < 서브쿼리 확인학습 Part.1 >

-- # 단일행 서브쿼리.
-- 1. 사원번호가 7788인 사원과 업무가 같은 사원의 사번, 사원명, 업무를 출력.
        select eno, ename, job
        from employee
        where job = (select job from employee where eno = 7788);

-- # 단일행 서브쿼리.
-- 2. 사원번호가 7499인 사원보다 연봉이 많은 사원의 사번, 사원명, 업무, 급여를 출력
        select eno, ename, job, salary
        from employee
        where salary > (select salary from employee where eno = 7499);

-- # 단일행 서브쿼리
-- 3. 최대급여를 받는 사원의 사원명, 업무, 연봉을 출력.
        select ename, job, salary
        from employee
        where salary = (select max(salary) from employee);

-- # 단일행 서브쿼리
-- 4. 업무별 가장 낮은 평균연봉의 업무와 평균연봉을 출력
        select job, trunc(avg(salary))
        from employee
        group by job
        having avg(salary) = (select min(avg(salary)) from employee group by job); 
        

-- # 다중행 서브쿼리
-- 5. 각 부서별 최저연봉을 받는 사원의 사원명, 연봉, 부서번호를 출력.
        select ename, salary, dno
        from employee
        where salary in (select min(salary) from employee group by dno); 

-- # 다중형 서브쿼리
-- 6. 업무별 평균연봉의 업무와 평균연봉을 출력
        select job, trunc(avg(salary)) from employee
        group by job
        having avg(salary) in (select avg(salary) from employee group by job);
        
        -- 간단하게 해결
        select job, trunc(avg(salary)) from employee group by job;

-- < 서브쿼리 확인학습 Part.2 >
-- 1. 업부가 ANALST인 사원보다 연봉이 적으면서 업무가 ANALYST가 아닌 사원의 사번, 사원명, 업무, 연봉을 출력
    

-- 2. BLAKE와 동일한 부서에 속한 사원의 사원명, 입사일, 부서번호를 출력 BLAKE사원은 제외

-- 3. 연봉이 평균연봉보다 많은 사원의 사번, 사원명, 연봉을 출력. 연봉에 대해 오름차순

-- 4. 이름에 K가 포함된 사원과 같은 부서에서 근무하는 사원의 사번, 사원명, 부서번호를 출력

-- 5. 부서위치가 DALLAS인 사원의 사원명, 부서번호, 업무를 출력.
















