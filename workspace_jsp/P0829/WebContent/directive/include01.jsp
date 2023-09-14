<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포함 페이지 1번</title>
</head>
<body>
	<%
		Timestamp now = new Timestamp(System.currentTimeMillis());
	%>
	
	<h3>include 1번 파일입니다.</h3>
	핸재 날짜와 시간 : <%=now %>
</body>
</html>