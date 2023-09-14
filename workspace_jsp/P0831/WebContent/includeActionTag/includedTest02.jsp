<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>includedTest02</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String pageName = request.getParameter("pageName");
	%>
	이 페이지는 파라미터의 값을 받아서 처리하는 페이지입니다.<br>
	포함되는 페이지 <%=pageName %>입니다.<br>
	<b><%=name %></b>님이 입장하였습니다.<br>
	
</body>
</html>