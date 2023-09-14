<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, logon.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertMemberPro</title>
</head>
<body>
	<h2>회원가입 처리</h2>
	<% request.setCharacterEncoding("utf-8"); %>
	
	<%-- 폼에서 넘어오는 값 획득 --%>
	<jsp:useBean id="member" class="logon.LogonDataBean"/>
	<jsp:setProperty property="*" name="member"/>
	
	<% member.setRegDate(new Timestamp(System.currentTimeMillis()));%>
	
	<% 
		// DB 처리
		LogonDBBean logon = LogonDBBean.getInstance();
		logon.insertMember(member);
		
	%>
	
	<%=member.getId() %>님의 회원가입을 축하합니다.
	
</body>
</html>