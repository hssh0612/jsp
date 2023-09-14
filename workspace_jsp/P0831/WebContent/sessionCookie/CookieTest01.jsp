<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CookieTest01</title>
</head>
<%--
< 쿠키를 생성하는 방법 >
 1. 쿠키 객체를 생성
 2. 쿠키의 만료시간을 설정
 3. 쿠키 추가
 
< 쿠키를 사용(확인)하는 방법 >
 1. 쿠키를 얻어옴.
 2. 쿠키의 배열의 찾고자 하는 쿠키를 가져옴.
 3. 쿠키의 이름을 통해서 값을 얻음.
--%>
<body>
	<h2>쿠키 테스트 1번</h2>
	
	<%
		// 쿠키 생성
		Cookie cookie = new Cookie("name", "Park"); // 쿠키 객체 생성
		cookie.setMaxAge(10); // 쿠키 만료시간 설정 (10초)
		response.addCookie(cookie); // 쿠키 추가
	--%>
	
	<h3>쿠키 정보 확인</h3>
	쿠키 이름 : <%=cookie.getName() %><br>
	쿠키 값 :  <%=cookie.getValue() %><br>
	쿠키 만료시간 : <%=cookie.getMaxAge() %><br>
	
	<a href="cookieTest02.jsp">쿠키값 불러오기</a>
	
</body>
</html>