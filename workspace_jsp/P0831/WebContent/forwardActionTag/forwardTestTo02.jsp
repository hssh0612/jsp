<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forwardTestTo02</title>
<style>
	table { width : 400px; border : 1px solid black; border-collapse : collapse;}
	tr { height : 40px;}
	th { width : 20%;}
	td { width : 80%;}
	th, td { border :1px solid black;}
</style>
</head>
<body>
	<h2>포워딩 받는 페이지</h2>
	<%
		request.setCharacterEncoding("utf-8");
	%>
	<table>
		<tr><th colspan="2">입력한 정보 확인</th></tr>
		<tr>
			<th>이름</th>
			<td><%=request.getParameter("name") %></td>
		</tr>
		<tr>
			<th>나이</th>
			<td><%=request.getParameter("age") %></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><%=request.getParameter("addr") %></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><%=request.getParameter("tel") %></td>
		</tr>
		
	</table>
</body>
</html>