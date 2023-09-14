<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.login.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 처리</title>
</head>
<body>
<%
	// 관리자 아이디와 비밀번호 획득
	String managerId = request.getParameter("managerId");
	String managerPwd = request.getParameter("managerPwd");
	
	// DB 연결, 관리자 인증 처리
	ManagerDAO managerPro = ManagerDAO.getInstance();
	int check = managerPro.managerCheck(managerId, managerPwd);

	// check가 1이면 관리자 인증, check가 0이면 관리자 불인증
	if(check == 0) { // 관리자 불인증
		out.print("<script>alert('관리자로 인증되지 않았습니다.');history.back();</script>");
	} else { // 관리자 인증
		session.setAttribute("managerId", managerId);
		response.sendRedirect("../managerMain.jsp");
	}
%>
</body>
</html>