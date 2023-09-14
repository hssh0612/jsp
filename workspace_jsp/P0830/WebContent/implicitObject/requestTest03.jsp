<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Enumeration" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>requestTest03</title>
</head>
<%--
< 1. request 내장객체의 메소드 >
 - getProtocol() : 사용중인 프로토콜을 리턴
 - getServerName() : 서버의 도메인 이름을 리턴
 - getMethod() : 요청에 사용된 방식을 리턴
 - getQueryString() : 요청에 사용된 QueryString을 리턴
 - getRemoteHost() : 웹브라우저의 호스트 이름을 리턴
 - getRemoteAddr() : 웹브라우저의 IP 주소를 리턴
 - getServerPort() : 서버의 포트 번호를 리턴
 - getHeader() : HTTP 요청 헤더 이름인 name의 속성값을 리턴
 - getHeaderNames() : HTTP 요청 헤더에 있는 모든 헤더 이름을 리턴

# 경로를 리턴하는 메소드
 - getRequestURI() : 요청에 사용된 URL로부터 URI 값을 리턴
 - getRequestURL() : 요청에 사용된 URL경로를 리턴
 - getContextPath() : 웹애플리케이션의 컨텍스트 경로를 리턴
 
# localhost : 연구용을 사용하는 IP 주소, 127.0.0.1
# URL(Uniform Resource Locator) : 프로젝트의 전체 경로명
# URI(Uniform Resource Indentifier) : 프로젝트명부터 파일명까지의 경로명
# Context Path : 프로젝트명 
 --%>
<body>
	<h2>request 내장객체의 메소드</h2>
	<h3>웹브라우저와 웹서버의 정보</h3>
	<%
		String[] names = {
				"프로토콜", "서버 이름", "메소드 방식",  "호스트 이름", "IP 주소",
				"포트 번호", "URL 주소", "URI 주소", "컨텍스트 경로"
		};
		String[] values = {
				request.getProtocol(), request.getServerName(), request.getMethod(), request.getRemoteHost(), request.getRemoteAddr(),      
		        request.getServerPort()+"", request.getRequestURL().toString(), request.getRequestURI(),request.getContextPath()
				
		};
		
		for(int i=0; i<names.length; i++) {
			out.println(names[i] + " : " + values[i] + "<br>");
		}
	%>
	
	<hr>
	
	<h3>HTTP 헤더 정보</h3>
	<%
		Enumeration<String> e = request.getHeaderNames();
		while(e.hasMoreElements()) {
			String headerName = e.nextElement();
			String headerValue = request.getHeader("headerName");
			out.println(headerName +" : " + headerValue + "<br>");
		}
	%>
	
</body>
</html>