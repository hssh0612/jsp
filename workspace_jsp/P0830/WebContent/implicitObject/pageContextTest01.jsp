<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pageContextTest01</title>
</head>
<%--
< 5. pageContext 내장 객체 >
 - JSP 페이지에 관한 정보를 가지는 내장 객체
 - 다른 내장 객체의 정보를 얻거나, 현재 페이지의 request와 response 객체의 제어권을 다른 페이지로 넘기는 기능을 가진 객체
 
 - getOut() : 응답 출력 스트림을 리턴
 - getServletConfig() : 서블릿의 초기 설정 정보를 리턴
 - getServletContext() : 서블릿의 실행 환경 정보를 담은 객체를 리턴
 
 - getRequest() : request 내장객체를 리턴
 - getResponse() : response 내장객체를 리턴
 - getSession() : session 내장객체를 리턴
 
 - forward() : 페이지를 이동하는 메소드, 
 - include() : 페이지를 포함하는 메소드,
	
 --%>
<body>
	<h2>pageContextTest01</h2>
	현재 페이지는<b>pageContextTest01.jsp</b>페이지입니다.<br>
	
	<%
		pageContext.forward("pageContextTest02.jsp");
	
	%>
	
</body>
</html>