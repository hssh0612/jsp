<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sessionTest01</title>
</head>
<%--
< http와 session의 차이점 >
 1. http (HyperText Transfer Protocol, 하이퍼텍스트 전송 프로토콜)
 	- 웹페이지의 전송 규약
 	- 특징 : 페이지를 이동하면 연결을 해제함. 상태를 유지하지 않음(stateless 속성)
 	- 장점 : 부하가 걸리지 않고, 빠른 이동이 가능함.
 	- 단점 : 연결을 계속 유지해야 하는 경우에 사용이 불가함.
 2. session  
 	- 특징 : 연결을 계속 유지함. 상태를 유지함.(state 속성)
 	- ex) 로그인, 장바구니 ...
 	
< 4. session 내장객체 >
 - 웹페이지의 연결을 유지하도록 하는 객체
 
 
 - getId() : 웹브라우저의 고유한 id를 리턴
 - getCreationTime() : 세션이 생성된 시간을 리턴
 - getLastAccessedTime() : 웹브라우저의 마지막 접근 시간을 리턴
# 세션의 만료시간을 설정하고, 리턴하는 메소드
 - setMaxInactiveInterval() : 세션의 만료시간을 설정하는 메소드, 기본시간 : 1800초(30분)
 - getMaxInactiveInterval() : 세션의 만료시간을 리턴하는 메소드
 
 
 - isNew() : 새로 생성된 세션인지의 여부
# 세션의 생성과 삭제
 - invalidate() : 모든 세션을 제거하는 메소드
 - setAttribute(key, value) : 세션을 설정하는 메소드
 - getAttribute(key) : 키를 통해 세션의 값을 리턴하는 메소드
 - removeAttribute(key) : 지정한 세션을 제거하는 메소드

 --%>
<body>
	<h2>세션의 생성과 확인</h2>
	<%
		// 세션의 만료시간 설정 : 10초
		session.setMaxInactiveInterval(10);
	%>
	
		isNew() : <%=session.isNew() %><br>
		생성시간 : <%=session.getCreationTime() %><br>
		최종접속시간 : <%=session.getLastAccessedTime() %><br>
		세션ID : <%=session.getId() %>
	
	
</body>
</html>