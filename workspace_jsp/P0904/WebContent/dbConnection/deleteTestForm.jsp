<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteTestForm</title>
</head>
<body>
	<h2>member 데이터 삭제 폼</h2>
	<%-- 아이디와 패스워드가 일치할 때 멤버 정보 삭제 --%>
	<form action="deleteTestPro.jsp" method = "post" >
		아이디 : <input type = "text" name = "id"><br>
		패스워드 : <input type = "password" name = "pwd"><br>
		<input type = "submit" value = "입력완료">
	</form>
</body>
</html>