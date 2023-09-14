<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sessionLoginPro02</title>
</head>
<body>
	<h2>로그인 처리</h2>
	<% request.setCharacterEncoding("utf-8"); %>
	
	<%
		// 폼에서 넘어오는 값 획득
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		
		// DB 처리
		LoginDBBean login = LoginDBBean.getInstance();
		boolean check = login.userCheck(id, pwd);
		
		// 2번 방법 - 2개의 값
		// check값이 true: 아이디도 존재하고, 패스워드도 일치, false : 아이디는 존재하지만 패스워드 불일치
		if(check) { // 아이디와 패스워드 모두 일치
			// 세션 설정
			session.setAttribute("id", id);
			response.sendRedirect("sessionMain.jsp");
		} else { // 아이디 또는 패스워드가 불일치
			out.println("<script>alert('로그인 정보가 일치하지 않습니다.');history.back();</script>");
		}
	%>
</body>
</html>