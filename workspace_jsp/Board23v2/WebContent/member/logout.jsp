<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>
<%
	// 아이디 세션 삭제
	session.removeAttribute("id");

	// 이동
	response.sendRedirect("logonForm.jsp");

%>
</body>
</html>