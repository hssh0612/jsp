-- < 교재 10장 문제 풀이 >

    create table chap10hw_emp 
    as select * from employee;
    create table chap10hw_dept 
    as select * from department;
    create table chap10hw_salgrade
    as select * from salgrade;
    commit;
-- 1. 
    insert into chap10hw_dept values(50, 'ORACLE','BUSAN');
    insert into chap10hw_dept values(60, 'SQL','ILSAN');
    insert into chap10hw_dept values(70, 'SELECT','INCHEON');
    insert into chap10hw_dept values(80, 'DML','BUNDANG'); 
    commit;
    
-- 2.
    insert into chap10hw_emp values(7201,'TEST_USER1','MANAGER',7566,'2016/01/02',4500,null,50);
    insert into chap10hw_emp values(7202,'TEST_USER2','CLERK',7201,'2016/02/21',1800,null,50);
    insert into chap10hw_emp values(7203,'TEST_USER3','ANALYST',7201,'2016/04/11',3400,null,60);
    insert into chap10hw_emp values(7204,'TEST_USER4','SALESMAN',7201,'2016/05/31',2700,null,60);
    insert into chap10hw_emp values(7205,'TEST_USER5','CLERK',7201,'2016/07/20',2600,null,70);
    insert into chap10hw_emp values(7206,'TEST_USER6','CLERK',7201,'2016/09/08',2600,null,70);
    insert into chap10hw_emp values(7207,'TEST_USER7','LECTURER',7201,'2016/10/28',2300,null,80);
    insert into chap10hw_emp values(7208,'TEST_USER8','STUDENT',7201,'2016/03/09',1200,null,80);
    
    COMMIT;
    SELECT * FROM chap10hw_emp
    order by eno;
    
-- 3.
    update chap10hw_emp
    set dno = 70
    where salary > (select avg(salary) from chap10hw_emp where dno = 50);
    commit;
    
-- 4.
    update chap10hw_emp
    set salary = salary+salayr*0.1, dno = 50
    where hiredate > (select min(hiredate) from chap10hw_emp where dno = 60);
    commit;

-- 5. 
    delete from chap10hw_emp
    where eno in (
    select eno
    from chap10hw_emp e, chap10hw_salgrade s
    where salary between losal and hisal
    and grade = 5
    );
    
    commit;
    
-- < 12장 문제풀이 >
-- 1.
    create table emp_hw(
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2)
    );

-- 2.
    alter table emp_hw add bigo varchar2(20);
    
-- 3. 
    alter table emp_hw modify bigo varchar2(30);

-- 4. 
    alter table emp_hw rename column bigo to remark;
    
-- 5. 
    insert into emp_hw(empno, ename, job, mgr, hiredate, sal, comm, deptno, remark)
    select eno, ename, job, manager, hiredate, salary, commission, dno, null from employee;
    commit;
-- 6.
    drop table emp_hw;

 -------------------
 /*
 트랜잭션(transaction), 무결성(integrity), 제약사항(constraints)
 
 < 트랜잭션 >
  - 데이터의 추가, 수정, 삭제 시에 작업의 일관성을 보장하기 위한 것.
  - 여러 가지의 작업을 하나의 단위로 처리를 하는 것
  - 여러 가지 작업이 모두 성공했다면 작업이 완료된 것이고, 중간에 문제가 발생했다면 시작되기 이전 작업으로 
    되돌려서 작업의 일관성을 보장해 줌.
  - all or nothing
  - commit(확정), rollback(취소), savepoint(롤백의 위치를 선정)
  
  은행 업무 - 계좌 이체
  
  --> 시작
  나의 통장 출금
  ...
  ... -> 에러
  ...
  상대방 통장 입금
  --> 종료
 */
    drop table emp;
    commit;
    
    create table emp 
    as select eno, ename, job, salary from employee;
    
-- 트랜잭션 작업
    insert into emp values (9000, 'KIM', 'MANAGER', 5000);
    delete emp where job = 'SALESMAN'; 
    savepoint spl;
    
    insert into emp values(9100,'LEE','SINGER',5500);
    delete emp where job = 'CLERK';
    
    rollback to spl;
    
    commit;
    
    select * from emp;
    
/*
  < 데이터 무결성 제약 조건 >
  - Data Integrity Constraint Rule
  - 테이블에 유효하지 않은 데이터가 입력되는 것을 방지하기 위해서 테이블을 생성할 때 각 컬럼에 정의하는 
    여러 가지 규칙.
  - 데이터가 추가, 수정, 삭제될 때 적용되는 규칙
  - not null, unique, primary key, foreign key, check
  
1. not null
 - 컬럼의 값이 null을 가지지 않도록 하는 제약 조건
 
2. unique
 - 컬럼의 값이 유일한 값을 가지도록 하는 제약 조건

3. primary key, 기본키, 주키, PK
 - 컬럼의 값이 null을 가지지 않도록 하고, 유일한 값을 갖도록 하는 제약 조건
 - 테이블에서 행을 구분하는 유일한 컬럼에 부여함.
 - 인덱스를 생성함.
 
4. foreign key, 외래키, FK
 - 테이블 사이의 참조 무결성을 설정하는 제약 조건
 
# 참조 무결성 (Reference Integrity)
 - 부모 테이블 : 다른 테이블에게 참조되는 테이블 ex) department
 - 자식 테이블 : 다른 테이블을 참조하는 테이블 ex) employee
 - 자식 테이블에서 컬럼은 항상 부모 테이블에서 참조가 가능하도록 해야 함.
 - 사원 테이블에서 부서번호 컬럼의 값은 항상 부서 테이블의 부서번호 컬럼에 존재해야 함.
 - 부모 테이블인 부서 테이블의 부서번호 컬럼은 반드시 primary key 또는 unique가 되어야 함.
 - 자식 테이블인 사원 테이블의 부서번호 컬럼은 부서 테이블의 부서번호 컬럼을 참조하는 foreign key가 되어야 함.
 
5. check 제약 조건
 -- user_constraints 테이블에서 constraint_type 필드의 값
 -- C: not null or check, U: unique, P: primary key, R: foreign key
*/
 -- 1. not null 제약 조건
    create table emp1(
    eno number(4) not null,
    ename varchar(10) not null,
    job varchar2(9)
    );
    
    COMMIT;
    
    desc emp1;
    
    insert into emp1(ename, job) values('KIM', 'MANAGER');
    -- ORA-01400: cannot insert NULL into ("SOL23"."EMP1"."ENO")
    
    insert into emp1(eno, job) values(1000, 'CLERK');
    -- ORA-01400: cannot insert NULL into ("SOL23"."EMP1"."ENAME")
    
    insert into emp1(eno, ename) values(1000, 'KIM');
    COMMIT;

    select * from emp1;

-- 2. unique 제약조건
    create table emp2(
    eno number(4) unique,
    ename varchar(10) not null,
    job varchar2(9)
    );
    
    insert into emp2(eno, ename, job) values(1000, 'KIM', 'MANAGER');
    insert into emp2(eno, ename, job) values(1100, 'LEE', 'CLERK');
    insert into emp2(eno, ename, job) values(1100, 'PARK', 'SALESMAN');
    -- ORA-00001: unique constraint (SOL23.SYS_C007024) violated
    insert into emp2(eno, ename, job) values(null, 'SONG', null);
    insert into emp2(ename) values('JUNG');
    commit;

-- 사용자 제약조건 데이터 사전
-- C: not null or check, U: unique, P : primary key
    select * from user_constraints;
    
    select table_name, constraint_name, constraint_type, status 
    from user_constraints
    where table_name = 'EMP2';
    
-- 3. primary key
    -- 3-1. 제약조건의 이름을 지정하지 않은 경우 
    --> 오라클이 SYS_C번호의 형태로 제약조건 이름을 생성
    --> 사용자가 관리하기에 어려움
    
    create table emp3 (
    eno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(9)
    );
    
    drop table emp3;
    -- 3-2. 제약 조건의 이름을 사용자가 지정하는 경우
    -- 1) 컬럼 레벨로 지정하는 경우
    create table emp3(
    emp number(4) constraint emp3_eno_pk primary key,
    ename varchar2(10) constraint emp3_ename_nn not null,
    job varchar2(9)
    );
    
    -- 2) 테이블 레벨로 지정하는 방법
    -- not null은 테이블 레벨로 지정할 수 없음.
    create table emp3 (
    eno number(4),
    ename varchar2(10) constraint emp3_ename_nn not null,
    job varchar2(9),
    constraint emp3_eno_pk primary key(eno)
    );
    
    select table_name, constraint_name, constraint_type, status
    from user_constraints
    where table_name = 'EMP3';
    
    select table_name, constraint_name, status
    from user_constraints
    where table_name = 'EMP3';
    
    insert into emp3(eno, ename, job) values(1000,'KIM', 'MANAGER');
    insert into emp3(ename) values('KIM');
    -- ORA-01400: cannot insert NULL into ("SOL23"."EMP3"."ENO")
    insert into emp3(eno, ename) values(1000,'LEE');
    -- ORA-00001: unique constraint (SOL23.SYS_C007026) violated
    
    COMMIT;
    
-- 4. foreign key
-- 부모 테이블 : dept 테이블
-- 자식 테이블 : emp 테이블
 -- 1. 컬럼 레벨  
    create table dept(
    dno number(4) constraint dept_dno_pk primary key,
    dname varchar2(15),
    loc varchar2(20)
    );
    
 -- 2. 테이블 레벨
    create table dept (
    dno number(2),
    dname varchar2(15),
    loc varchar2(20),
    constraint dept_dno_pk primary key(dno)
    );
 
    -- 1. 컬럼 레벨 - 제약조건을 컬럼을 지정할 때 함께 주는 방법
    create table emp (
    eno number(4) constraint emp_eno_pk primary key,
    ename varchar2(10) constraint emp_ename_nn not null,
    job varchar2(9),
    dno number(2) constraint emp_dno_fk references dept
    );
    
    DROP TABLE emp;
    -- 2. 테이블 레벨 - 컬럼을 지정하고 나서, 테이블의 마지막에 제약조건을 지정하는 방법
    create table emp (
    eno number(4),
    ename varchar2(10) constraint emp_ename_nn not null,
    job varchar2(9),
    dno number(2),
    constraint emp_eno_pk primary key(eno),
    constraint emp_dno_fk foreign key(dno) references dept
    );
    
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('DEPT', 'EMP');
    
    -- 참조 무결성 검증
    insert into dept select * from department;
    commit;
    
    insert into emp(eno, ename, job, dno) values(1000, 'KIM','MANAGER', 20);
    commit;
    
    -- ORA-00001: unique constraint (SOL23.EMP_ENO_PK) violated
    -- primary key 위배
    insert into emp(eno, ename, job, dno) values(1000, 'LEE','SALESMAN', 30);
    
    -- ORA-01400: cannot insert NULL into ("SOL23"."EMP"."ENAME")
    -- not null 위배
    insert into emp(eno, job, dno) values(1100,'CLERK',10);

    -- ORA-02291: integrity constraint (SOL23.EMP_DNO_FK) violated - parent key not found
    -- 참조 무결성 위배
    insert into emp(eno, ename, job, dno ) values(1200, 'SONG', 'SALESMAN', 50);

    -- dept 테이블에 50부서를 삽입하고 난후, 다시 테스트
    insert into dept values(50,'MARKETING','SEOUL');
    COMMIT;
    
    insert into emp(eno, ename, job, dno) values(1200,'SONG','SALESMAN',50);
    commit;
    
    delete from dept where dno = 10;
    
    -- emp 테이블에서 부서번호가 10번인 데이터를 모두 삭제후, 다시 테스트
    delete from emp where dno = 10;
    
-- 5. check 제약조건
    create table emp5 (
    eno number(4) constraint emp5_eno_pk primary key,
    ename varchar2(10) constraint emp5_ename_nn not null,
    job varchar2(9),
    salary number(7,2) constraint emp5_salary_c check (salary between 1000 and 3000)
    );

    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name = 'EMP5';
    
    select * from user_constraints
    where table_name = 'EMP5';
    
    insert into emp5 values(1000, 'KIM', 'MANAGER', 2000);
    COMMIT;
    
    -- ORA-02290: check constraint (SOL23.EMP5_SALARY_C) violated
    -- check 제약조건에 위배
    insert into emp5 values(1100, 'LEE', 'CLERK' , 500);

    -- ORA-02290: check constraint (SOL23.EMP5_SALARY_C) violated
    -- check 제약조건에 위배
    insert into emp5 values(1100, 'LEE', 'CLERK', 3100);

-- 
    delete dept where dno = 10;
    
-- 6. default 옵션
-- 아무값을 입력하지 않아도 자동으로 입력되는 값을 설정
    
    create table emp6 (
    eno number(4) constraint emp6_eno_pk primary key,
    ename varchar2(10) constraint emp6_ename_nn not null,
    job varchar2(9),
    salary number(7,2) default 1000
    );

-- 제약 조건 확인
    select * from user_constraints
    where table_name = 'EMP6';
    
-- default 확인
    select * from user_tab_columns;
    select * from user_tab_columns where table_name = 'EMP6';
    select data_default from user_tab_columns where table_name = 'EMP6';
    
    insert into emp6 values(1000,'KIM','MANAGER',1500);
    COMMIT;
    
    insert into emp6(eno, ename, job) values(1100,'LEE', 'CLERK');
    COMMIT;
    
-- #############
-- < 제약 조건의 추가, 변경, 삭제 >
    drop table emp;
    drop table dept;
    create table emp as select * from employee;
    create table dept as select * from department;
    
    
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('EMPLOYEE', 'DEPARTMENT');

    -- 제약조건은 복사할 수 없음.
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('EMP', 'DEPT');

    --1. 제약조건의 추가
    -- 1-1. dept 테이블에 primary key 추가
    -- 부모에 대한 제약조건을 먼저 추가해야 함.
    -- 1번 : add constraint절 사용
    alter table dept
    add constraint dept_dno_pk primary key(dno);
    
    -- 2번 : modify절
    alter table dept
    modify dno constraint dept_dno_pk primary key;
    
    -- 1-2. emp 테이블에 primary key 추가
    -- 그 다음에 자식에 대한 제약조건을 추가함.
    alter table emp
    add constraint emp_eno_pk primary key(eno);
    
    insert into emp(eno, ename, dno) values(9000, 'KIM', 50);
    COMMIT;

-- 방법 1. dept 테이블에 50번 부서를 추가
    insert into dept values(50, 'MARKETING' ,'SEOUL'); 
    COMMIT;
    
-- 방법 2. emp 테이블에서 50번 부서를 가진 사원 정보를 삭제
    delete emp where dno =50;
-- 1-3. emp 테이블에 foreign key 추가
-- ORA-02298: cannot validate (SOL23.EMP_DNO_FK) - parent keys not found
    alter table emp
    add constraint emp_dno_fk foreign key(dno) references dept;

-- 2. not null 제약 조건 추가
-- emp 테이블의 ename 컬럼에 not null 제약조건을 추가
-- not null 제약 조건은 add constraint 절을 사용하지 않음. -> modify 절을 사용함.
-- 에러 : 사용 불가
    alter table emp
    add constraint emp_ename_nn not null(ename);

    alter table emp
    modify ename constraint emp_ename_nn not null;

-- not null 제약 조건 검증
-- ORA-01400: cannot insert NULL into ("SOL23"."EMP"."ENAME")
    insert into emp(eno, ename, dno) values( 8000, null,30);

-- 3. not null을 null로 변경
    alter table emp modify ename null;

-- 제약조건 확인
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('EMP', 'DEPT');

-- 4. unique 제약 조건 추가
-- emp 테이블에 ename에 unique 제약 조건 추가
-- 1번
    alter table emp
    add constraint emp_ename_u unique(ename);

-- 2번
    alter table emp
    modify ename constraint emp_ename_u unique;
-- unique 제약 조건 검증
    insert into emp(eno, ename, dno) values(9100, 'LEE', 10);
    commit;
    -- ORA-00001: unique constraint (SOL23.EMP_ENAME_U) violated
    insert into emp(eno, ename, dno) values(9200,'LEE',20);

    insert into emp(eno, ename, dno) values(9300,null,30);
    commit;
    insert into emp(eno, ename, dno) values(9400,null,40);
    commit;

-- 5. check 제약 조건 추가
-- emp 테이블에 salary에 check 제약 조건 추가
-- 1번
    alter table emp
    add constraint emp_salary_ck check (salary between 1000 and 3000);

-- 2번
    alter table emp
    modify salary  constraint emp_salary_ck check (salary between 1000 and 3000);
    
-- check 제약조건 검증
    insert into emp(eno, ename, salary, dno) values(9500,'CHOI',3000, 40);
    COMMIT;
    -- ORA-02290: check constraint (SOL23.EMP_SALARY_CK) violated
    insert into emp(eno, ename, salary, dno) values(9600, 'PARK',3500,20);
    
    --ORA-02290: check constraint (SOL23.EMP_SALARY_CK) violated
    update emp
    set salary = 4000
    where job = 'SALESMAN';

-- 제약조건 확인
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('EMP', 'DEPT');

-- #################
-- < 제약 조건의 이름 변경 >
    alter table emp
    rename constraint emp_ename_u to emp_ename_uq;
    
-- < 제약 조건의 변경 >
-- ORA-02264: name already used by an existing constraint
-- 제약 조건을 삭제하고, 변경된 제약조건을 다시 생성함.
    alter table emp
    modify salary constraint emp_salary_ck check (salary between 500 and 5000);

-- < 제약 조건의 삭제 >
    alter table emp drop constraint emp_salary_ck;
    alter table emp drop constraint emp_ename_uq;

-- < 참조 무결성의 삭제 >
-- 자식 테이블의 제약조건을 먼저 삭제하고, 부모 테이블의 제약조건을 삭제함.

-- ORA-02273: this unique/primary key is referenced by some foreign keys
    alter table dept drop constraint dept_dno_pk;

-- 1번 : emp 테이블의 fk를 먼저 삭제
    alter table emp drop constraint emp_dno_fk;
    alter table emp drop constraint emp_eno_pk;

-- 2번 : 그 다음에 dept 테이블의 pk를 삭제 
    alter table dept drop constraint dept_dno_pk;

-- < 참조 무결성의 제약조건 부여 >
-- 1. dept의 dno의 PK 추가
    alter table dept
    modify dno constraint dept_dno_pk primary key;

-- 2. emp의 eno의 PK 추가
    alter table emp
    modify eno constraint emp_eno_pk primary key;
    
-- 3. emp의 dno의 FK 추가
    alter table emp
    modify dno constraint emp_dno_fk references dept;
    
-- 제약조건 확인
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('EMP', 'DEPT');

-- 종속적으로 삭제
-- 2) cascade로 삭제하는 방법 - 부모의 제약조건을 삭제하면 자식의 제약조건까지 한꺼번에 삭제
    alter table dept drop constraint dept_dno_pk cascade;
    
    alter table dept drop primary key cascade;






