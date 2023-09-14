<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scopeTest02</title>
</head>
<body>
	<h2>영역 객체 처리 페이지 2번</h2>
	<%
		request.setCharacterEncoding("utf-8");
		
		// request 영역
		String email = request.getParameter("email");
		String addr = request.getParameter("addr");
		String tel = request.getParameter("tel");
		
		// session 영역 객체 저장
		if(email != null && addr != null && tel != null) {
			session.setAttribute("email", email);
			session.setAttribute("addr", addr);
			session.setAttribute("tel", tel);
		}
		
		String name = (String)application.getAttribute("name");
	%>
	
	<%=name %>님의 정보가 모두 저장되었습니다.<br>
	
	<a href="scopeTest03.jsp"><%=name %>님의 전체 정보 확인</a>
</body>
</html>