-- 퀴즈) 교재 394페이지 문제 해결

    create table dept_const (
    depto number(2) constraint deptconst_deptno_pk primary key, 
    dname varchar2(14) constraint deptconst_dname_unq unique,
    loc varchar2(13) constraint deptconst_loc_nn not null
    );
    
    create table emp_const(
    empno number(4) constraint empconst_empno_pk primary key,
    ename varchar2(10) constraint empconst_ename_nn not null,
    job varchar2(9),
    etel varchar2(20) constraint empconst_tel_unq unique,
    hiredate date,
    sal number(7,2) constraint empconst_sal_chk check (sal between 1000 and 9999),
    comm number(7,2),
    deptno number(2) constraint empconst_deptno_fk references dept_const
    );
    
    select table_name, constraint_name, constraint_type, status, search_condition from user_constraints
    where table_name in ('DEPT_CONST', 'EMP_CONST');
    
    -- ###########
    -- < 제약조건 확성화 및 비활성화 >
    -- 데이터에 대한 특별한 처리나 테스트를 목적으로 제약조건을 비활성화하고, 테스트가 끝나면 다시 활성화 하는 방법
    drop table dept;
    drop table emp;
    create table dept as select * from department;
    create table emp as select * from employee;
    
    select table_name, constraint_name, constraint_type, status, search_condition from user_constraints
    where table_name in ('DEPT', 'EMP');
    
    -- 1. dept의 dno에 pk 제약조건 추가
    alter table dept
    modify dno constraint dept_dno_pk primary key;
    
    -- 2. emp의 dno에 fk 제약조건 추가
    alter table emp
    modify dno constraint emp_dno_fk references dept;
    
    -- 3. emp의 eno에 pk 제약조건 추가
    alter table emp
    modify eno constraint emp_eno_pk primary key;
    
    -- 4. emp의 ename에 not null 제약조건 추가
    alter table emp
    modify ename constraint emp_ename_nn not null;
    
    -- 5. emp의 salary에 check 제약조건 추가
    alter table emp
    modify salary constraint emp_salary_ck check (salary between 500 and 5000);
    
    -- 6. dept의 dname에 unique 제약조건 추가
    alter table dept
    modify dname constraint dept_dname_u unique;
    
    -- ename의 not null 제약조건 검증
    insert into emp(eno, ename, dno) values(9000,'KIM',20);
    commit;
    
    -- ORA-01400: cannot insert NULL into ("SOL23"."EMP"."ENAME")
    insert into emp(eno, ename, dno) values(9100,null,20);
    
    -- ename의 not null 제약조건 비활성화
    alter table emp
    disable constraint emp_ename_nn;
    
    insert into emp(eno, ename, dno) values(9100,null,20);
    commit;
    
    select table_name, constraint_name, constraint_type, status, search_condition from user_constraints
    where table_name in ('DEPT', 'EMP');
    
    -- ename의 not null 제약조건 활성화
    -- ORA-02293: cannot validate (SOL23.EMP_ENAME_NN) - check constraint violated
    alter table emp
    enable constraint emp_ename_nn;
    
    -- ename의 null인 데이터를 삭제
    delete emp where ename is null;
    commit;
    
    alter table emp
    enable constraint emp_ename_nn;
    
    select table_name, constraint_name, constraint_type, status, search_condition from user_constraints
    where table_name in ('DEPT', 'EMP');
    
-- ######################
-- < salary의 check 제약조건에 대한 검증 >
    update emp
    set salary = salary * 2
    where ename = 'SCOTT';
    
-- salary의 check 제약조건의 비활성화
    alter table emp
    disable constraint emp_salary_ck;
    
    update emp
    set salary = salary * 2
    where ename = 'SCOTT';
    commit;
    
-- salary의 check 제약조건의 활성화
-- RA-02293: cannot validate (SOL23.EMP_SALARY_CK) - check constraint violated
    alter table emp
    enable constraint emp_salary_ck;
    
    update emp
    set salary = salary / 2
    where ename = 'SCOTT';
    commit;
    
    alter table emp
    enable constraint emp_salary_ck;
    
-- < dept에서 dname의 unique 제약조건 검증 >
-- ORA-00001: unique constraint (SOL23.DEPT_DNAME_U) violated
    insert into dept values (50, 'SALES', 'SEOUL');
    
-- ename의 unique 제약조건을 비활성화
    alter table dept
    disable constraint dept_dname_u ;
    
-- ename의 unique 제약조건을 비활성화하고, 데이터 삽입
    insert into dept values (50, 'SALES', 'SEOUL');
    commit;
    
-- ename의 unique 제약조건을 활성화
-- ORA-02299: cannot validate (SOL23.DEPT_DNAME_U) - duplicate keys found
    alter table dept
    enable constraint dept_dname_u;

-- 중복값을 삭제
    delete dept where dno = 50;
    commit;
    
-- ename의 unique 제약조건을 활성화
    alter table dept
    enable constraint dept_dname_u;
    
-- < 참조 무결성에 대한 검증 >
    insert into emp(eno, ename, dno) values(9100,'LEE',30);
    COMMIT;
    
-- ORA-02291: integrity constraint (SOL23.EMP_DNO_FK) violated - parent key not found
    insert into emp(eno, ename, dno) values(9200,'CHOI',50);
    
-- emp 테이블 foreign key를 비활성화
    alter table emp
    disable constraint emp_dno_fk;
    
    insert into emp(eno, ename, dno) values(9200, 'CHOI',50);
    commit;
    
-- emp 테이블 dno의 foreign key를 활성화
-- ORA-02298: cannot validate (SOL23.EMP_DNO_FK) - parent keys not found
    alter table emp
    enable constraint emp_dno_fk;
    
-- dept에 50번 부서를 추가
    insert into dept values(50 , 'MARKETING', 'SEOUL');
    commit;
    
-- emp 테이블 dno의 foreign key를 활성화
    alter table emp
    enable constraint emp_dno_fk;
    
    select table_name, constraint_name, constraint_type, status, search_condition from user_constraints
    where table_name in ('DEPT', 'EMP');
    
-- #####
-- < default 옵션 변경, 삭제 >
-- default 옵션 확인
    select * from user_tab_columns
    where table_name = 'EMP';
    
    select table_name, column_name, data_type, data_default from user_tab_columns
    where table_name = 'EMP';
    
-- default 옵션을 추가
-- salary 컬럼에 default값 1000을 설정
    alter table emp
    modify salary default 1000;

-- emp 테이블 데이터 삽입
    insert into emp(eno, ename, dno) values (9300,'SONG',40);
    commit;
    
-- default 옵션을 추가(변경)
-- hiredate 컬럼에 default값을 sysdate로 설정
    alter table emp
    modify hiredate default sysdate;
    commit;
    
-- emp 테이블 데이터 삽입
    insert into emp(eno, ename, dno) values(9400, 'CHOI', 30);
    commit;
    
-- default 옵션을 제거(변경)
    alter table emp
    modify hiredate default null;
    
-- emp 테이블 데이터 삽입
    insert into emp(eno, ename, dno) values(9500, 'SONG', 10);
    commit;
    
-- default 옵션을 제거(변경)
    alter table emp
    modify salary default null;

-- emp 테이블 데이터 삽입
    insert into emp(eno, ename, dno) values(9600,'PARK',30);
    commit;
    
-- ##############
/*
★★★★★
< 뷰(View) >
 - 하나 이상의 테이블 또는 뷰를 이용하여 생성하는 가상 테이블
 - 실제 데이터를 저장하지 않고, 쿼리문(select)만 저장되어 있음.
 - 물리적인 공간을 가지지 않음.

< 뷰의 장점 >
 - 보안성 : 테이블의 특정 열을 노출하고 싶지 않을 경우
 - 편리성 : 필요한 정보만 접근하여 사용하고 싶은 경우
 
< 뷰의 종류 >
 1. 단순 뷰(simple view) 
    - 하나의 기본 테이블로부터 생성한 뷰 
    - DML 명령을 실행할 수 있고, DML 명령이 기본 테이블에 반영됨. 
 2. 복합 뷰(complex view)
    - 두 개 이상의 기본 테이블로부터 생성한 뷰
    - 제약조건, 그룹 등의 유무에 따라서 DML 명령이 제한적으로 사용됨.
    - distinct, 그룹함수, group by, rownum을 포함할 수는 없음.
*/

    drop table emp;
    drop table dept;
    create table emp as select * from employee;
    create table dept as select * from department;
    
    alter table dept
    modify dno constraint dept_dno_pk primary key;
    
    alter table emp
    modify dno constraint emp_dno_fk references dept;
    
    alter table emp
    modify eno constraint emp_eno_pk primary key;
    
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('EMP', 'DEPT');
    
    desc emp;
    select * from emp;
    
    desc dept;
    select * from dept;

-- 1번 : 단순 뷰
    create view v_emp1
    as
    select eno, ename, dno, job from employee;
    
    select * from v_emp1;
    
    -- 뷰 확인
    select * from user_views;
    select * from user_views where view_name = 'V_EMP1';
    
-- 2번 : 단순 뷰
    create view v_emp2(사번, 사원명, 부서번호, 업무)
    as
    select eno, ename, dno, job from employee;
    
    select * from v_emp2;
    
-- 3번 : 단순 뷰
drop view v_emp3;
    create view v_emp3(eno, ename, dno, job)
    as
    select eno, ename, dno, job from employee where job = 'SALESMAN';
    
    select * from v_emp3;
    desc v_emp3;
    
-- 4번 : 복합 뷰
    create view v_emp4
    as
    select * from employee natural join department;
    
    select * from v_emp4;
    
-- 5번 : 복합 뷰
    create view v_emp5(eno, ename, job, dno, dname, loc)
    as
    select eno, ename, job, dno, dname, loc from employee natural join department; 
    
    select * from v_emp5;
    
-- 6번 : 복합 뷰
    create view v_emp6(eno, ename, job, dno, dname, loc)
    as
    select eno, ename, job, dno, dname, loc 
    from employee natural join department
    where dno = 30; 
    
    select * from v_emp6;
    
-- #####
-- < 뷰를 통한 데이터의 추가, 수정, 삭제 1 - 단순 뷰 >
-- 문제1) v_emp3을 사용하여 데이터를 추가
    insert into v_emp3 values(8000,'KIM', 30, 'SALESMAN');
    commit;
    
    select * from v_emp3;
    select * from employee;
    
-- 문제2) v_emp3를 사용하여 데이터를 수정
-- SALESMAN의 부서번호를 40번으로 수정
    update v_emp3
    set dno = 40
    where job = 'SALESMAN';
    
    select * from v_emp3;
    select * from emp;
    
-- 문제 3) v_emp3을 사용하여 데이터를 삭제
-- 사원명이 ALLEN 사원의 정보를 삭제
    delete from v_emp3 where ename = 'ALLEN';
    COMMIT;
    
    select * from v_emp3;
    select * from emp;
    
-- < 뷰를 통한 데이터의 추가, 수정, 삭제 - 복합 뷰  >
-- 문제4) v_emp6을 사용하여 데이터를 추가
    insert into v_emp6(eno, ename, job) values(9100, 'LEE', 'SALESMAN');
    commit;
    
    select * from v_emp6;
    select * from emp;

-- 문제5) v_emp6을 사용하여 데이터를 수정
    update v_emp6
    set job = 'SALESMAN'
    where  ename = 'JAMES';
    commit;
    
    select * from v_emp6;
    select * from emp;

-- 문제 6) v_emp6을 사용하여 데이터를 삭제
    delete v_emp6 where ename = 'BLAKE';
    commit;
    
    select * from v_emp6;
    select * from emp;
    

-- ##########
-- < 다양한 뷰 >
-- 문제7) 아래의 조건에 부합하는 뷰 v_emp_salary를 생성하시오.
-- 각 부서별 총급여와 평균급여를 구하는 뷰를 생성하시오.

    truncate table emp;
    desc emp;
    insert into emp select * from employee;
    commit;
    select * from emp;

-- #####
-- 그룹 함수의 결과는 가상 컬럼으로 존재하고, 가상 컬럼은 뷰에서 사용 불가
-- 가상 컬럼은 그대로 사용 불가, 알리아스를 지정하여 사용 가능.
-- 그룹함수를 가상 컬럼으로 갖는 뷰는 DML을 사용할 수 없음.
    create view v_emp_salary
    as
    select dno, sum(salary) sum_sal, round(avg(salary),2) avg_sal 
    from emp
    group by dno;
    
    select dno, sum(salary), round(avg(salary),2) 
    from emp
    group by dno;
    
    desc v_emp_salary;
    select * from v_emp_salary;

-- 데이터 추가
-- ORA-01733: virtual column not allowed here
    insert into v_emp_salary values(50, 3000, 1000);

-- 뷰 제거
-- 뷰 제거해도 기본 테이블에는 영향을 미치지 않음.
    drop view v_emp_salary;
    
    select * from user_views;

-- 뷰 생성 방법에 대한 옵션
    create or replace view v_emp3
    as
    select eno, ename, dno, job from emp
    where job = 'MANAGER';
    
    select * from v_emp3;

-- 2. create or replace force
-- noforce: 기본 테이블이 존재하지 않으면 뷰의 생성 불가, 기본값
-- force: 기본 테이블이 존재하지 않아도 뷰를 생성

-- ORA-00942: table or view does not exist
    create or replace view v_emp_noforce
    as
    select eno, ename, job, dno from emp_notable
    where job = 'MANAGER';
    
    -- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.
    create or replace force view v_emp_force
    as
    select eno, ename, job, dno from emp_notable
    where job = 'MANAGER';
    
    select * from user_views;
    
    select * from v_emp_force;

-- 생성했던 view 전부 삭제. 남은 table => department, employee, dept, emp, salgrade
-- #####
/*
< 뷰의 문제점과 중요한 옵션>
1. with check option
 - 서브쿼리의 where절 뒤에 사용
 - 조건에 명시된 이외의 데이터는 추가, 수정, 삭제가 불가하도록 하는 옵션
 - 뷰를 통해서 데이터를 추가, 수정, 삭제할 때 일관된 정보를 볼 수 있도록 하는 옵션

2. with read only
 - 서브쿼리의 where절 뒤에 사용
 - 뷰를 통해서는 읽기만 가능함.

*/
    create or replace view v_emp1
    as
    select eno, ename, job, dno
    from emp
    where job = 'MANAGER';
    
    desc v_emp1;
    select * from v_emp1;

-- v_emp1 뷰는 업무(job)가 MANAGER인 사원의 정보를 확인하는 뷰
--> 업무가 MANAGER인 사원의 데이터를 추가, 수정, 삭제하는 것이 합당하다.

-- 문제점 발현) v_emp1을 통해서 MANAGER가 아닌 사원도 입력이 가능
    insert into v_emp1 values(8000, 'KIM', 'CLERK', 40);
    commit;
--> MANAGER가 아닌 CLERK를 추가하면 추가는 가능하지만 v_emp1에는 보여지지 않고 emp에는 추가된것이 확인 가능.
-- ㄴ> MANAGER만 추가, 수정, 삭제 되도록?

    select * from v_emp1;
    select * from emp;

-- MANAGER만 입력가능한 뷰를 생성
    create or replace view v_emp1
    as
    select eno, ename, job, dno from emp
    where job = 'MANAGER' with check option;

-- MANAGER가 아닌 사원의 데이터를 v_emp1에 추가 -> 불가
-- ORA-01402: view WITH CHECK OPTION where-clause violation
    insert into v_emp1 values(8100, 'LEE', 'SALESMAN', 30);

-- MANAGER인 사원의 데이터를 v_emp1에 추가 -> 가능
    insert into v_emp1 values(8100, 'LEE', 'MANAGER', 30);
    commit;

-- #####
    create or replace view v_emp2
    as
    select eno, ename, job, salary from emp
    where salary between 1000 and 3000;
    
    select * from v_emp2;
    
    insert into v_emp2 values(8200, 'CHOI', 'ANALYST', 2500);
commit;

-- 문제점 발현) 연봉이 1000~3000 사이가 아닌 데이터도 추가가 가능.
-- v_emp2 연봉이 1000~3000 사이의 데이터를 확인하는 뷰, 데이터의 추가도 연봉이 1000~3000 사이의 데이터만 가능하도록 하는 것이 합당.
    insert into v_emp2 values(8300, 'SONG', 'MANAGER', 3500);
    commit;

-- #####
    create or replace view v_emp2
    as
    select eno, ename, dno, job, salary from emp
    where salary between 1000 and 4000 with check option;

    insert into v_emp2 values(8400, 'PARK', 'MANAGER',3500);
    insert into v_emp2 values(8400, 'PARK', 'MANAGER', 3000);
    COMMIT;
    
-- #####
    create or replace view v_emp3
    as
    select eno, ename, job, dno from emp
    where job = 'MANAGER' with read only;
    
-- 데이터의 추가 불가
-- SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view
    insert into v_emp3 values(8500, 'JUNG', 'MANAGER', 10);

-- 데이터의 수정 불가
-- SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view
    update v_emp3
    set dno=40
    where job = 'MANAGER';

-- 데이터의 삭제 불가
-- SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view
delete v_emp3 where job = 'MANAGER';

/*
< 인라인 뷰 >
 - inline view
 - create를 통해서 view라는 객체를 생성하는 것이 아니라, SQL문에서 일회용으로 만들어서 사용하는 뷰
 

 < pseudo column(의사 컬럼) >
  - 실제로 존재하지는 않지만, 특정한 목적을 위해서 가상으로 만들어낸 일시적인 컬럼.
  
 < rownum >
  - 조회한 행에 대해서 일련번호를 붙여주는 의사 컬럼.
  - 데이터를 추가할 때 매기는 일련번호이므로, order by를 해도 원래의 일련번호를 그대로 유지하는 특성을 가짐.
*/

-- 조회한 행에 대해서 rownum으로 일련번호를 붙여줌.
    select rownum, e.* from emp e;
    
-- 문제점) 정렬한 순서가 rownum에 반영되지 않음.
    select rownum, e.* from emp e
    order by salary desc;

-- 해결책) 인라인 뷰를 사용하여 정렬한 결과가 rownum에 반영되도록 함.
    select rownum , e.* from (select * from emp e order by salary desc) e;

-- 응용) 조회한 건수 중에서 상위 3건만 노출하려면
 -- 1번 방법
    select rownum , e.* 
    from (select * from emp e order by salary desc) e
    where rownum <= 3;
    
 -- 2번 방법
    with e as (select * from emp e order by salary desc)
    select rownum , e.* 
    from e
    where rownum <= 3;

-- ###################
/*
< 시퀀스 > sequence
 - 자동으로 생성되는 유일한 일련번호
 - 테이블에 기본키로 설정된 컬럼의 값을 생성할 때 주로 사용.
 - ex) 상품 번호, 게시판 번호 ...

create sequence 시퀀스이름 
start with 시작번호, 생략하면 기본값 1
increment by 증감값, 생략하면 기본값 1
maxvalue 최대값 --> 오름차순 기본값 10의 27승, 내림차순 기본값 -1
minvalue 최소값 --> 오름차순 기본값 1, 내림차순 기본값 -10의 26승
cycle | nocycle --> 시퀀스의 값이 최대값을 넘어서게 될 때, cycle 다시 처음부터 시작, nocycle은 에러 발생, 기본값 nocycle
cache 캐시값 | nocache --> 캐시를 사용하는지의 여부, 기본값은 20

--> 
*/

-- 시퀀스 생성, 10부터 시작해서 10씩 증가하는 시퀀스
    create sequence test_seq start with 10 increment by 10;
       
-- 시퀀스 확인
    select * from user_sequences;

-- 시퀀스의 새로운 값 생성
    select test_seq.nextval from dual;

-- 시퀀스의 현재 값 확인
    select test_seq.currval from dual;

-- 시퀀스 삭제
    drop sequence test_seq;

-- 시퀀스를 사용할 테이블 생성
    create table dept1 (
    dno number(2) constraint dept1_dno_pk primary key,
    dname varchar2(20),
    loc varchar2(30)
    );

    desc dept1;
    select * from dept1;

-- dept1 테이블의 dno에서 사용할 시퀀스를 생성
-- 10부터 시작해서 10씩 증가
    create sequence dept1_seq start with 10 increment by 10;
    
    select * from user_sequences;

-- 시퀀스 사용
    insert into dept1 values(dept1_seq.nextval, 'ACCOUNTING', 'NEW YORK');
    commit;
    insert into dept1 values(dept1_seq.nextval, 'RESEARCH', 'DALLAS');
    COMMIT;
    insert into dept1 values(dept1_seq.nextval, 'SALES', 'CHICAGO');
    COMMIT;
    insert into dept1 values(dept1_seq.nextval, 'MARKETING', 'SEOUL');
    COMMIT;
    
    select * from user_sequences;
    select dept1_seq.currval from dual;
    
-- 시퀀스 수정 - dept1_seq의 증감값을 5로 수정
    alter sequence dept1_seq
    increment by 5;

-- 시작번호 수정이 변경이 불가
-- ORA-02283: cannot alter starting sequence number
    alter sequence dept1_seq
    start with 40;
    
-- ORA-02283: cannot alter starting sequence number
    alter sequence dept1_seq
    start with 1000;
    
-- 시퀀스 삭제
-- 시퀀스를 삭제해도 시퀀스를 통해 만들어진 값은 삭제되지 않음.
    drop sequence dept1_seq;
    
    select * from dept1;

-- ##########
/*
< 인덱스 > index
- 테이블의 검색 속도를 향상시키기 위해서 테이블의 컬럼에 사용하는 객체.
- 테이블의 특정 행의 주소, 위치 정보 등을 목록으로 만들어 놓은 것.
- 오라클에서 자동으로 만들어 사용하는 인덱스와 사용자를 만들어 사용하는 인덱스가 존재함.
- 기본키(primary key)와 고유키(unique)는 자동으로 인덱스를 생성
- 사용빈도가 낮은 컬럼에 인덱스를 생성하게 되면, 오히려 검색 성능의 저하를 야기할 수 있다.

< 인덱스의 종류 - 유일한 값의 여부 >
 - 고유 인덱스 : 기본키나 고유키처럼 유일한 값을 갖는 컬럼에 생성하는 인덱스
 - 비고유 인덱스 : 중복 데이터를 허용하는 컬럼에 생성하는 인덱스

< 인덱스의 종류 - 컬럼의 개수에 따른 분류 >
 - 단일 인덱스 : 한 개의 컬럼으로 구성된 인덱스
 - 결합 인덱스 : 두 개 이상의 컬럼으로 구성된 인덱스
 
< 기타 인덱스 >
 - 함수 기반 인덱스 : 함수나 수식에 지정하는 인덱스
*/

-- 인덱스 확인 1
    select * from user_indexes;
    
-- 인덱스 확인 2
    select * from user_ind_columns;

    drop table emp;
    drop table dept;
    create table emp as select * from employee;
    create table dept as select * from department;
    alter table dept modify dno constraint dept_dno_pk primary key;
    alter table emp modify dno constraint emp_dno_fk references dept;
    alter table emp modify eno constraint emp_eno_pk primary key;
    
    select * from user_indexes where table_name in('EMP', 'DEPT');
    
-- 고유 인덱스 생성
-- dname이 유일한 값을 가지기 때문에 가능
    create unique index idx_dept_dno on dept(dname);
    
-- ORA-01452: cannot CREATE UNIQUE INDEX; duplicate keys found
-- job은 유일한 값을 가지는 컬럼이 아니기 때문에 고유 인덱스 생성 불가
    create unique index idx_emp_job on emp(job);

-- 인덱스 제거 
    drop index idx_dept_dno;
    
-- 비고유 인덱스 생성
    create index idx_emp_job on emp(job);
    
    select * from user_indexes where table_name in('EMP', 'DEPT');
    select * from user_ind_columns where table_name in ('EMP', 'DEPT');
    
-- 결합 인덱스 생성
    create index idx_dept_comp on dept(dname, loc);
    
-- 함수 기반 인덱스 생성
-- 함수나 수식에 인덱스 생성
    create index idx_salary_month on emp(salary/12);
    

    
    
    
    