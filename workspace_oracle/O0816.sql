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
 
    select e.eno, e.ename, m.eno, m.ename
from employee e inner join employee m
on e.manager = m.eno
order by e.eno;

/*
4. 아우터 조인(Outer Join), 외부 조인
 - 이너 조인은 양쪽 컬럼의 값 중의 하나가 null이면 결과를 출력하지 않지만,
 - 아우터 조인은 컬럼의 값이 null일 때도 값을 출력하도록 함.
  4-1. 레프트 아우터 조인(left outer join), 왼쪽 외부 조인
   - 왼쪽 컬럼이 기준, 왼쪽 컬럼에 대한 값이 null일 때 출력
  
  4-2. 라이트 아우터 조인(right outer join), 오른쪽 외부 조인
   - 오른쪽 컬럼이 기준, 오른쪽 컬럼에 대한 값이 null일 때 출력
  
  4-3. 풀 아우터 조인(full outer join), 전체 외부 조인
   - 왼쪽 컬럼에 대한 null값, 오른쪽 컬럼에 대한 null값을 모두 출력
*/

-- 문제5) 사원 테이블에서 사번, 사원명, 관리자번호, 관리자이름을 출력하시오.
-- 컬럼의 값이 null일때도 값을 출력하도록 하시오.
-- 직속 상관이 없을 때도 출력하라.
    -- 1번 - 최근 방법
    select e.eno, e.ename, m.eno, m.ename
    from employee e left outer join employee m
    on e.manager = m.eno
    order by e.eno;

    -- 2번 - 이전 방법
    select e.eno, e.ename, m.eno, m.ename
    from employee e join employee m
    on e.manager = m.eno(+)
    order by e.eno;

-- 문제6) 사원 테이블에서 사번, 사원명, 관리자번호, 관리자이름을 출력하시오.
-- 오른쪽 컬럼의 값이 null일때도 값을 출력하도록 하시오.
--> 부하 직원이 없는 사원의 정보도 출력하라.
    -- 1번 - 최근 방법
    select e.eno, e.ename, m.eno, m.ename
    from employee e right outer join employee m
    on e.manager = m.eno
    order by e.eno;
    
    -- 2번 - 이전 방법
    select e.eno, e.ename, m.eno, m.ename
    from employee e join employee m
    on e.manager(+) = m.eno
    order by e.eno;

-- 문제7) 사원 테이블에서 사번, 사원명, 관리자번호, 관리자이름을 출력하시오.
-- 왼쪽과 오른쪽 컬럼의 값이 null일때 모두 값을 출력하도록 하시오.
 --> 관리자가 없는 사원의 정보와 부하 지원이 없는 사원의 정보도 출력하라.
 
    -- 1번 - 권장
    select e.eno, e.ename, m.eno, m.ename
    from employee e full outer join employee m
    on e.manager = m.eno
    order by e.eno;
    
    -- 2번 - 권장하지않음
    select e.eno, e.ename, m.eno, m.ename
    from employee e join employee m
    on e.manager = m.eno(+)
    union
    select e.eno, e.ename, m.eno, m.ename
    from employee e join employee m
    on e.manager(+) = m.eno;
    
    -- 3번 - 권장하지않음
    select e.eno, e.ename, m.eno, m.ename
    from employee e left outer join employee m
    on e.manager = m.eno
    union
    select e.eno, e.ename, m.eno, m.ename
    from employee e right outer join employee m
    on e.manager = m.eno;
    

-- < 조인 확인 학습 >
--1. SCOTT 사원의 사번, 사원명, 부서번호, 부서명을 출력
-- - 알리아스를 사용하고, 4가지의 방법으로 문제 해결
    -- 1-1.
    select eno 사번, ename 사원명, e.dno 부서번호 , dname 부서명
    from employee e, department d
    where e.dno = d.dno
    and ename = 'SCOTT';
    
    -- 1-2.
    select eno 사번, ename 사원명, e.dno 부서번호 , dname 부서명
    from employee natural join department
    where ename = 'SCOTT';
    
    -- 1-3.
    select eno 사번, ename 사원명, e.dno 부서번호 , dname 부서명
    from employee join department
    using(dno)
    where ename = 'SCOTT';
    
    -- 1-4.
     select eno 사번, ename 사원명, e.dno 부서번호 , dname 부서명
    from employee e join department d
    on e.dno = d.dno
    where ename = 'SCOTT';
    
--2. 모든 사원의 사원번호, 사원명, 부서이름, 지역명을 출력
-- - 알리아스를 사용하고, 부서이름을 기준으로 오름차순, 부서이름이 같은 때는 사번을 기준으로 내림차순.
-- - 4가지의 방법으로 문제를 해결.
    -- 2-1.
    select eno 사번, ename 사원명, dname 부서명, loc 지역명
    from employee e, department d
    where e.dno = d.dno
    order by dname asc, eno desc;
    
    -- 2-2.
    select eno 사번, ename 사원명, dname 부서명, loc 지역명
    from employee natural join department
    order by dname asc, eno desc;
    
    -- 2-3.
    select eno 사번, ename 사원명, dname 부서명, loc 지역명
    from employee join department
    using(dno)
    order by dname asc, eno desc;
    
    -- 2-4.
    select eno 사번, ename 사원명, dname 부서명, loc 지역명
    from employee e join department d
    on e.dno = d.dno
    order by dname asc, eno desc;
    
--3. 10번 부서에 속하는 사원의 부서번호, 사번, 사원명, 업무, 지역명을 출력
-- - 알리아스를 사용하고, 4가지 방법으로 문제 해결.
    -- 3-1.
    select e.dno 부서번호, eno 사번, ename 사원명, e.job 업무, loc 지역명
    from employee e, department d
    where e.dno = d.dno
    and e.dno = 10;
    
    -- 3-2.
    select dno 부서번호, eno 사번, ename 사원명, job 업무, loc 지역명
    from employee natural join department d
    where dno = 10;
    
    -- 3-3.
    select dno 부서번호, eno 사번, ename 사원명, job 업무, loc 지역명
    from employee join department
    using(dno)
    where dno = 10;
    
    -- 3-4.
    select e.dno 부서번호, eno 사번, ename 사원명, e.job 업무, loc 지역명
    from employee e join department d
    on e.dno = d.dno
    where e.dno = 10;
    
--4. 커미션을 받을 수 있는 사원의 사원명, 부서명, 지역명을 출력
-- - 알리아스 사용, 4가지 방법
    -- 4-1.
    select ename 사원명, dname 부서명, loc 지역명
    from employee e, department d
    where e.dno = d.dno
    and commission is not null;
    
    -- 4-2.
    select ename 사원명, dname 부서명, loc 지역명
    from employee natural join department
    where commission is not null;
    
    -- 4-3.
    select ename 사원명, dname 부서명, loc 지역명
    from employee join department
    using(dno)
    where commission is not null;
    
    -- 4-4.
    select ename 사원명, dname 부서명, loc 지역명
    from employee e join department d
    on e.dno = d.dno
    where commission is not null;
    
--5. 사원명에 A가 포함된 사원의 사번, 사원명, 부서번호, 부서명을 출력
-- - 알리아스 사용 4가지 방법.
    -- 5-1.
    select eno 사번, ename 사원명, e.dno 부서번호, dname 부서명
    from employee e, department d
    where e.dno = d.dno
    and ename like '%A%';
    
    -- 5-2.
    select eno 사번, ename 사원명, dno 부서번호, dname 부서명
    from employee natural join department
    where ename like '%A%';
    
    -- 5-3.
    select eno 사번, ename 사원명, dno 부서번호, dname 부서명
    from employee join department
    using(dno)
    where ename like '%A%';
    
    -- 5-4.
    select eno 사번, ename 사원명, e.dno 부서번호, dname 부서명
    from employee e join department d
    on e.dno = d.dno
    where ename like '%A%';

★★★★★
-- < 조인 확인 학습 part.2 >
 -- 6. NEW YORK에 근무하는 사원의 사원명, 업무, 부서번호, 부서명을 출력
  -- 알리아스 사용, 4가지 방법
    -- 6-1.
    select ename 사원명, job 업무, e.dno 부서번호, dname 부서명
    from employee e, department d
    where e.dno = d.dno
    and loc = 'NEW YORK';
    
    -- 6-2.
    select ename 사원명, job 업무, dno 부서번호, dname 부서명
    from employee natural join department
    where loc = 'NEW YORK';
    
    -- 6-3.
    select ename 사원명, job 업무, dno 부서번호, dname 부서명
    from employee join department
    using(dno)
    where loc = 'NEW YORK';
    
    -- 6-4.
    select ename 사원명, job 업무, e.dno 부서번호, dname 부서명
    from employee e join department d
    on e.dno = d.dno
    where loc = 'NEW YORK';
    
 -- 7. SCOTT과 동일한 부서에서 근무하는 동료 사원의 부서번호, 동료사원명을 출력
 -- 셀프조인 -> 이퀴조인
    -- 7-1.
    select dno 부서번호, ename 동료사원명
    from employee
    where dno = (select dno from employee where ename = 'SCOTT');
    
    -- 7-2.
    select dno 부서번호, ename 동료사원명
    from employee natural join department
    where dno = (select dno from employee where ename = 'SCOTT');
    
    -- 7-3.
    select dno 부서번호, ename 동료사원명
    from employee join department
    using(dno)
    where dno = (select dno from employee where ename = 'SCOTT');
    
    -- 7-4.
    select e.dno 부서번호, ename 동료사원명
    from employee e join department d
    on e.dno = d.dno
    where e.dno = (select dno from employee where ename = 'SCOTT');
 
 -- 8. WARD 사원보다 늦게 입사한 사원의 사원명과 입사일을 출력
  -- 입사일을 기준으로 오름차순 하여 출력
   --> 셀프조인 , 넌이퀴 조인
    -- * 강사님
    select o.ename, o.hiredate
    from employee w, employee o
    where w.hiredate < o.hiredate
    and w.ename = 'WARD'
    order by o.hiredate;
    
    -- * 강사님 2
    select o.ename, o.hiredate
    from employee w join employee o
    on w.hiredate < o.hiredate
    and w.ename = 'WARD'
    order by o.hiredate;
    
    -- 8-1.
    select ename 사원명, hiredate 입사일
    from employee
    where hiredate > (select hiredate from employee where ename = 'WARD')
    order by hiredate asc;
    
    -- 8-2.
    select ename 사원명, hiredate 입사일
    from employee natural join department
    where hiredate > (select hiredate from employee where ename = 'WARD')
    order by hiredate asc;
    
    -- 8-3.
    select ename 사원명, hiredate 입사일
    from employee join department
    using(dno)
    where hiredate > (select hiredate from employee where ename = 'WARD')
    order by hiredate asc;
    
    -- 8-4.
    select ename 사원명, hiredate 입사일
    from employee e join department d
    on e.dno = d.dno
    where hiredate > (select hiredate from employee where ename = 'WARD')
    order by hiredate asc;
  
 -- 9. 관리자보다 먼저 입사한 사원의 사원명, 입사일, 관리자이름, 관리자입사일을 출력
    -- * 강사님
    select e.ename 사원명, e.hiredate 사원입사일, m.ename 관리자명, m.hiredate 관리자입사일
    from employee e join employee m
    on e.manager = m.eno -- 조인 조건
    and e.hiredate < m.hiredate
    order by e.eno;
    
    
    -- 9-1.
    select e.eno 사원번호,e.ename 사원이름, e.hiredate 입사일, e.manager 관리자번호, m.ename 관리자이름, m.hiredate 관리자입사일
    from employee e, employee m
    where e.dno = m.dno
    and e.manager = m.eno
    and e.hiredate < m.hiredate;
    
    -- 9-2.
    
    
    -- 9-3.
    
    -- 9-4.
    select e.eno 사원번호,e.ename 사원이름, e.hiredate 입사일, e.manager 관리자번호, m.ename 관리자이름, m.hiredate 관리자입사일
    from employee e join employee m
    on e.dno = m.dno
    where e.manager = m.eno
    and e.hiredate < m.hiredate;
    
 -- < 조인 확인 학습 Part.3 >
 -- 교재 239 ~ 240 페이지의 4문제 해결
  -- 1. 급여(salary)가 2000초과인 사원들의 부서 정보, 사원 정보를 출력
  --      (dno, dname, eno, ename, salary)
  
        -- * 강사님1
        select e.dno, dname, eno, ename, salary
        from employee e, department d
        where e.dno = d.dno
        and salary > 2000
        order by e.dno;
        
        -- * 강사님2
        select dno, dname, eno, ename, salary
        from employee natural join department 
        where salary > 2000
        order by dno;
        
        -- * 강사님3
        select dno, dname, eno, ename, salary
        from employee join department 
        using(dno)
        where salary > 2000
        order by dno;
        
        -- * 강사님4
        select e.dno, dname, eno, ename, salary
        from employee e join department d
        on e.dno = d.dno
        and salary > 2000
        order by e.dno;
        
        select d.dno 부서번호, dname 부서이름, eno 사번, ename 사원이름, salary 연봉
        from employee e, department d
        where salary > 2000;
  
  -- 2. 각 부서별 평균 급여, 최대 급여, 최소 급여, 사원수를 출력
  --    (dno, dname, avg_salary, max_salary, min_salary, count)
   -- -> 조인과 그룹핑을 함께 생각하는 문제
        -- * 강사님1
        select e.dno, dname, trunc(avg(salary)), max(salary), min(salary), count(*)
        from employee e, department d
        where e.dno = d.dno
        group by e.dno, dname;
        
        -- * 강사님2
        select dno, dname, trunc(avg(salary)), max(salary), min(salary), count(*)
        from employee natural join department 
        where e.dno = d.dno
        group by e.dno, dname;
        
        -- * 강사님3
        select dno, dname, trunc(avg(salary)), max(salary), min(salary), count(*)
        from employee join department
        using(dno)
        group by dno, dname;
        
        -- * 강사님4
        select e.dno, dname, trunc(avg(salary)), max(salary), min(salary), count(*)
        from employee e join department d
        on e.dno = d.dno
        group by e.dno, dname;
        
        select dno 부서번호, dname 부서이름, round(avg(salary),2) 평균급여, max(salary) "최대 급여", min(salary) "최소 급여", count(*) 사원수
        from employee natural join department
        group by dno,dname;
  
  -- 3. 모든 부서 정보와 사원 정보를 부서 번호, 사원 이름순으로 정렬하여 출력
        -- * 강사님1 <left outer join >
        select d.dno, dname, eno, ename, job, salary
        from department d, employee e
        where d.dno = e.dno(+)
        order by e.dno, ename;
        
        -- * 강사님2 <left outer join >
        select d.dno, dname, eno, ename, job, salary
        from department d left outer join employee e
        on d.dno = e.dno
        order by e.dno, ename;
        
        -- * 강사님3 < right outer join >
        select d.dno, dname, eno, ename, job, salary
        from employee e, department d
        where e.dno(+) = d.dno
        order by e.dno, ename;
        
        -- * 강사님4 < right outer join >
        select d.dno, dname, eno, ename, job, salary
        from employee e right outer join department d
        on e.dno(+) = d.dno
        order by e.dno, ename;
        
        select * 
        from employee natural join department
        order by dno, ename;
  
  -- 4. 모든 부서 정보, 사원 정보, 급여 등급 정보, 각 사원의 직속 상관의 정보를 부서 번호,
  --    사원 번호 순서로 정렬하여 출력.
        -- * 강사님1 - 이전 방식
        select d.dno, d.dname, e.eno, e.ename, e.manager, e.salary, e.dno, s.losal, s.hisal, s.grade, m.eno, m.ename
        from department d, employee e, salgrade s, employee m
        where d.dno = e.dno(+)
        and e.salary between s.losal(+) and s.hisal(+)
        and e.manager = m.eno(+)
        order by d.dno, e.eno;
        
        -- * 강사님2 - 최근 방식(SQL-99 방식)
        select d.dno, d.dname, e.eno, e.ename, e.manager, e.salary, e.dno, s.losal, s.hisal, s.grade, m.eno, m.ename
        from department d
        left outer join employee e on d.dno = e.dno
        left outer join salgrade s on e.salary between s.losal and s.hisal
        left outer join employee m on e.manager = m.eno
        order by d.dno, e.eno;
        
        /*
        department d, employee e, salgrade s, employee m
        where d.dno = e.dno(+)
        and e.salary between s.losal(+) and s.hisal(+)
        and e.manager = m.eno(+)
        order by d.dno, e.eno;
        */
        
        select distinct * 
        from employee natural join department, salgrade
        where salary between losal and hisal
        order by dno, eno;