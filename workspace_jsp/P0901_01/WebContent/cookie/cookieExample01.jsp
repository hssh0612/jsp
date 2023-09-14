<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cookieExample01</title>
</head>
<body>
	<h2>쿠키를 사용한 한글/영어 전환 프로그램</h2>
	<%
	// 쿠키의 사용
	String language = "korea";
		// 1. 쿠키의 정보를 획득
		String cookie = request.getHeader("Cookie");
		
		if(cookie != null) {
			// 2. 전체 쿠키를 배열로 저장
			Cookie[] cookies = request.getCookies();
			// 3. 찾고자 하는 쿠키를 획득
			for(int i=0;i<cookies.length;i++) {
				if(cookies[i].getName().equals("language")) {
					language = cookies[i].getValue();
				}
			}
		}
	%>
	
	<%-- 한글/영어 전환 --%>
	<% if(language.equals("korea")) { %>
		<h3>안녕하세요. 쿠키 예제입니다.</h3>
	<% } else { %>
		<h3>Hello. This is Cookie Example.</h3>
	<% } %>
	
	<form action="cookieExample02.jsp" method="post">
		<input type = "radio" name="language" value = "korea"
		<% if(language.equals("korea")) { %> checked <% } %> >  한국어 페이지 보기
		<input type = "radio" name="language" value = "english"
		<% if(language.equals("english")) { %> checked <% } %>> 영어 페이지 보기
		<input type = "submit" value="설정">
	</form>
</body>
</html>