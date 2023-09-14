<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pageContextTest02</title>
</head>
<body>
	<h2>pageContextTest02</h2>
	지금 보고 있는 페이지는 <b>pageContextTest02.jsp</b>페이지 입니다.
	
	<%
		pageContext.include("pageContextTest03.jsp");
	%>
</body>
</html>