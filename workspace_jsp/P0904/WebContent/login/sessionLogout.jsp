<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sessionLogout</title>
</head>
<body>
	<h2>로그아웃 페이지</h2>
	<%-- 세션 삭제 --%>
	<% session.removeAttribute("id"); %>
	<script>
		alert("로그아웃 하였습니다.");
		location.href = "sessionLoginForm.jsp";
	</script>
	
</body>
</html>