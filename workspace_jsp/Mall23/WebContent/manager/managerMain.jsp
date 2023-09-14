<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인 폼</title>
<style>
#container { width : 300px; margin : 20px auto;}
h2 { text-align : center;}
a { text-decoration : none; color : #1e94be;}
a:hover { text-decoration : underline; color : #c84557;}
table { width : 100%; border : 1px solid lightgray; border-collapse : collapse;}
tr { height : 50px;}
th, td { border : 1px solid lightgray;}
.title { background : #dbf4e6;}
</style>
</head>
<body>
<%
	// 관리자 아이디 세션 확인
	String managerId = (String)session.getAttribute("managerId");

	// 관리자 아이디 세션이 없을 때
	if(managerId == null) {
		response.sendRedirect("./managerLogin/managerLoginForm.jsp");
	}
%>
<div id="container">
	<h2>쇼핑몰 관리자 메인 페이지</h2>
	<table>
		<tr class="title"><th><%=managerId %>관리자님</th></tr>
		<tr><th><a href="./managerLogin/managerLogout.jsp">로그아웃</a></th></tr>
		<tr class="title"><th>상품 관리</th></tr>
		<tr><th><a href="./productProcess/productList.jsp">상품 목록(등록/수정/삭제)</a></th></tr>
		<tr class="title"><th>주문 관리</th></tr>
		<tr><th><a href="">주문 목록(수정/삭제)</a></th></tr>
		<tr class="title"><th>회원 관리</th></tr>
		<tr><th><a href="">회원 목록(수정/강퇴)</a></th></tr>
	</table>
</div>
</body>
</html>