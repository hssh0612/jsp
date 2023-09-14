<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 처리</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="member" class="member.MemberDataBean"/>
<jsp:setProperty property="*" name="member"/>


<%
	// DB 연결, 처리
	MemberDBBean dbPro = MemberDBBean.getInstance();
	dbPro.insertMember(member);
	
	// 이동
	response.sendRedirect("logonForm.jsp");
%>
</body>
</html>