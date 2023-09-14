<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forTestForm02</title>
</head>
<body>
<%--
	문제2) 게시판 건수를 입력하여, 아래의 형태(테이블)로 출력
	< 입력화면 설계 >
	게시판 건수 : 5
	< 출력화면 설계 >
	글번호 | 글제목 | 글내용
	5번    | 제목 5 | 내용5
	4번    | 제목 4 | 내용4
	3번    | 제목 3 | 내용3
	2번    | 제목 2 | 내용2
	1번    | 제목 1 | 내용1
	
 --%>
	<h2>게시판 건수 입력</h2>
	<form action="forTestPro02.jsp" method="post">
		게시판 건수 입력 : <input type="text" name="number"><br>
		<input type="submit" value="입력 완료">
	</form>
</body>
</html>