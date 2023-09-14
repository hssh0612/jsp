<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>error404</title>
</head>
<body>
	<%-- 에러페이지 설정 --%>
	<% response.setStatus(HttpServletResponse.SC_OK); %>
	<h2>404 에러 처리 페이지</h2>
	
	<h3>시스템 점검 중입니다.</h3>
	<p>오전 9시부터 사용이 가능합니다.</p>
</body>
</html>