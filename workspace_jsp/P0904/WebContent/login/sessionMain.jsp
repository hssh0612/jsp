<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sessionMain</title>
<style>
#container { width : 400px; margin : 20px auto;}
h2, p { text-align : center;}
a { text-decoration : none; color : darkgray;}
</style>
</head>
<body>
	<div id="container">
		<h2>로그인 확인(세션 확인)</h2>
		<%
			// 세션 확인
			String id = (String)session.getAttribute("id");
		
			// 세션값이 없을 때의 처리
			if(id == null || id.equals("")) {
				response.sendRedirect("sessionLoginForm.jsp");
			}
		%>
		<p><b><%=id %></b>님이 로그인 하였습니다.</p>
		<p><a href="sessionLogout.jsp">로그아웃</a></p>
	</div>
</body>
</html>