-- 데이터베이스 사용
use db01;

--데이터베이스 확인
show databases;
-- 사용중인 데이터베이스 확인
select database();

-- 모든 테이블 확인
show tables;

desc member;
select * from member;