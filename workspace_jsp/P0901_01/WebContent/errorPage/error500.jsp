<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>error500</title>
</head>
<body>
	<%-- 에러 페이지 설정 --%>
	<% response.setStatus(HttpServletResponse.SC_OK); %>
	
	<h2>500 에러 처리 페이지</h2>
	<h3>
		서비스 사용에 불편을 끼쳐드려서 죄송합니다.
	</h3>
</body>
</html>