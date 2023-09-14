<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>outTest01</title>
</head>
<%--
< out 내장객체 >
 - 실행 결과를 웹브라우저 화면으로 출력하는 객체
 - isAutoFlush() : 출력 버퍼의 처리 여부를 결정하는 메소드
 - getBufferSize() : 버퍼의 크기를 리턴하는 메소드
 - getRemaining() : 현재 남아있는 버퍼의 크기를 리턴하는 메소드
 - clearBuffer() : 버퍼를 비우는 메소드
 - flush() : 버퍼의 내용을 웹브라우저의 출력화면으로 보내는 메소드
 - close() : 버퍼의 내용을 웹브라우저의 출력화면으로 보내고, 출력 스트링을 닫는 메소드
 - println() : 주어진 값을 웹브라우저 화면으로 출력하는 메소드
 --%>
<body>
	<h2>out 내장 객체</h2>
	<%
		String name = "Park";
	%>
	
	<%-- 1번 : 표현식 --%>
	이름 : <%=name %><br>
	
	<hr>
	
	<%-- 2번 : out 내장객체 --%>
	<%
	out.println("이름 : " + name + "<br>");
	%>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>