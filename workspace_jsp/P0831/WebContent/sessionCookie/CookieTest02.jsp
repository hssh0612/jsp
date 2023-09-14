<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CookieTest02</title>
</head>
<body>
	<h2>쿠키 테스트 2번</h2>
	
	<%
		// 쿠키 확인
		String name = "";
		String value = "";
		String cookie = request.getHeader("cookie"); // 쿠키를 얻어옴.
		
		if(cookie != null) {
			Cookie[] cookies = request.getCookies(); // 쿠키의 배열을 가져옴.
			
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("name")) { // 해당 쿠키를 찾음.
					name = cookies[i].getName();
					value = cookies[i].getValue();
				}
			}
		}
	%>
	
	<h3>쿠키 확인</h3>
	쿠키 이름 : <%=name %><br>
	쿠키 값 : <%=value %><br>
	
</body>
</html>