<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scopeTestPro01</title>
<style>
	table { width : 300px; border : 1px solid black; border-collapse: collapse;}
	tr { height : 40px;}
	th, td { border : 1px solid black;}
</style>
</head>
<body>
	<h2>영역 객체 처리 페이지 1번</h2>
	<%
		request.setCharacterEncoding("utf-8");
		
		// request 영역
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		
		// application 영역 객체로 저장
		if(name != null && id != null) {
			application.setAttribute("name",name);
			application.setAttribute("id", id);	
		}
		
	%>
	
	<h3><%=name %>님 환영합니다.<br><%=name %>님의 아이디는 <%=id %>입니다.</h3>
	
	<form action="scopeTest02.jsp" method="get">
		<table>
			<tr><th colspan="2">Session 영역에 저장할 값</th></tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="addr"></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="tel"></td>
			</tr>
			<tr><th colspan="2"><input type="submit" value="전송"></th></tr>
		</table>
	</form>
</body>
</html>