<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sessionDel</title>
</head>
<body>
	<h2>세션값 삭제</h2>
	
	<%
		session.removeAttribute("name");
	%>
	
	<script>
		location.href = "sessionTest.jsp";
	</script>
	
</body>
</html>