<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>errorCreate</title>
</head>
<%--
< HTTP 에러의 종류 >
 1. 400 : 요청에 대한 실패, 문법상의 오류가 있어서 서버가 해석하지 못함.
 2. 401.1 : 접속 권한이 없어서 접속 실패
 3. 401.2 : 서버 설정으로 인한 접속 실패
 4. 404 : 경로나 파일명이 잘못되었을 때
 5. 408 : 요청 시간이 지남
 6. 414 : 요청한 URL이 너무 길 때
 7. 500 : 문법 오류
 8. 502 : 게이트웨이 상태가 불안정할 때
 9. 503 : 웹서비스가 제공이 불가할 때
 10. 504 : 게이트웨이의 접근 요청 시간이 지남

 --%>
<body>
	<h2>에러 발생 페이지</h2>
	
	<%-- 1. 404 에러 발생  --%>
	<%-- 404 에러 : 파일의 경로, 이름이 잘못되었을 때 --%>
	<%--
	<script>
		location.href = "test.jsp";
	</script>
	 --%>
	 
	<%-- 2. 500 에러 발생 --%>
	<%-- 500에러 : JAVA, JSP의 문법 오류 --%>
	<%--
	<%
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		String date = sdf.format(now);
	%>
	
	오늘 날짜는 <%=date %>입니다.
	--%>
</body>
</html>