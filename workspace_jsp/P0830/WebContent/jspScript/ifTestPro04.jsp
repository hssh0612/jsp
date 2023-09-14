<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ifTestPro04</title>
</head>
<body>
	<h2>로그인 처리 페이지</h2>
	<%
	
		//DB 아이디와 패스워드
		String dbId = "abcd";
		String dbPwd = "1234";
		
		
		String id = request.getParameter("id");
		String pwd = request.getParameter("password");
		
	%>
	<%-- 1번 : 스크립틀릿, 표현식 --%>
	<%--
	<% if( id.equals(dbId) && pwd.equals(dbPwd)) { %>
			<p>로그인에 성공하였습니다.</p>
	
	<% } else { %> 
			<p>로그인에 실패하였습니다.</p>
	<% } %>
	--%>
	<%-- 2번 : 스크립틀릿, out 내장객체 --%>
	
	<%
	if( id.equals(dbId) && pwd.equals(dbPwd)) {
		out.println("로그인에 성공하였습니다.");
	} else {
		out.println("로그인에 실패하였습니다.");
	}
	%>
</body>
</html>