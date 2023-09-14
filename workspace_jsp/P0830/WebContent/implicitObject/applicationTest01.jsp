<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>applicationTest01</title>
</head>
<%--
< 6. application 내장 객체 >
 - 웹애플리케이션이 실행되는 서버의 설정 정보 및 자원에 관한 정보를 얻거나, 
   웹애플리케이션이 실행되고 있는 동안 발생할 수 있는 이벤트에 대한 로그 정보와 관련된 기능을 제공하는 내장 객체
   
 - getMajorVersion() : Servlet의 major버전을 리턴
 - getMinorVersion() : Servlet의 miner버전을 리턴
 - getServerInfo() : 서블릿/JSP 컨테이너의 이름과 버전을 리턴
 - getMimeType() : 서버에 존재하는 file의 MIME 타입을 리턴
 - getResource(path) : path로 지정된 경로의 URL을 리턴
 - getResourceAsStream(path) : path로 지정된 경로의 자원을 InputStream으로 리턴
 - getRealPath(path) : path로 지정된 경로의 실제 시스템 상의 경로를 리턴
 - log() : 서블릿의 로그 기록을 저장

 --%>
<body>
	<h2>applicationTest01</h2>
	JSP 버전 : <%=application.getMajorVersion() %>.<%=application.getMinorVersion() %><br>
	Servlet/JSP 컨테이너 정보 : <%=application.getServerInfo() %><br>
	웹애플리케이션의 경로 : <%=application.getResource("/") %><br>
	웹애플리케이션의 실제 경로 : <%=application.getRealPath("/") %>
</body>
</html>