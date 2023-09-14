<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cookieExample02</title>
</head>
<body>
	<h2>쿠키의 생성</h2>
	<%
		// 1. 쿠키 생성
		Cookie cookie = new Cookie("language", request.getParameter("language"));
		// 2. 쿠키 만료 시간 설정
		cookie.setMaxAge(60*60*24); // 24시간
		// 3. 쿠키를 클라이언트에 저장
		response.addCookie(cookie);
	%>
	
		<script>
			location.href = "cookieExample01.jsp";
		</script>
</body>
</html>