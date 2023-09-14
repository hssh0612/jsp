<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertTestForm</title>
</head>
<body>
	<h2>member 테이블 데이터 입력 폼</h2>
	<form action="insertTestPro.jsp" method="post">
		아이디 : <input type = "text" name = "id" ><br>
		패스워드 : <input type = "password" name = "pwd" ><br>
		이름 : <input type = "text" name = "name" ><br>
		나이 : <input type = "number" name = "age" ><br>
		<input type = "submit" value = "입력완료">
	</form>
	
</body>
</html>