<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>includedTest01</title>
</head>
<body>
	<h2></h2>
	<%
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
	%>
	포함되는 페이지 includeTest02.jsp입니다. <br>
	<%=name %>님이 입장하셨습니다.<br>
</body>
</html>