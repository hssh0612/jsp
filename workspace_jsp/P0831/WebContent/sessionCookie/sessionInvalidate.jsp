<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sessionInvalidate</title>
</head>
<body>
	<h2>전체 세션 무효화</h2>
	
	<%
		session.invalidate();
	%>
	
	<script>
		location.href = "sessionTest.jsp";
	</script>
	
</body>
</html>