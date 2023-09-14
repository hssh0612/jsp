<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forwardTestTo01</title>
</head>
<body>
	<h2>포워딩된 페이지</h2>
	<%
		request.setCharacterEncoding("utf-8");
	
		String id = request.getParameter("id");
		String hobby = request.getParameter("hobby");
	%>
	
	<h3>포워딩된 페이지 forwardTestTo01.jsp페이지입니다.</h3>
	<b><%=id %></b>님의 취미는 <b><%=hobby %></b>입니다.<br>
</body>
</html>