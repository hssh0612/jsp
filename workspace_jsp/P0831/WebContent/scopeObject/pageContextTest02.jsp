<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pageContextTest02</title>
</head>
<body>
	<h2>pageContext 객체와 request 객체비교 2번</h2>
	
	pageContext 값: <%=pageContext.getAttribute("pageScope") %><br>
	request 값: <%=request.getAttribute("requestScope") %><br>
	
	
</body>
</html>