<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sessionSet</title>
</head>
<body>
	<h2>세션값 설정</h2>
	
	<%
		session.setAttribute("name", "Session Test!");
	%>
	
	<script>
		location.href = "sessionTest.jsp";

	</script>
	
</body>
</html>