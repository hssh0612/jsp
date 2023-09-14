<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateTestForm</title>
</head>
<body>
	<h2>member 데이터 수정 폼</h2>
	<%-- 아이디와 패스워드를 확인하여  --%>
	<form action="updateTestPro.jsp" method="post">
		아이디 : <input type="text" name = "id"><br> 
		패스워드 : <input type="password" name = "pwd"><br> 
		이름 : <input type="text" name = "name"><br> 
		나이 : <input type="text" name = "age"><br> 
		<input type ="submit" value="입력완료">
		
	</form>
	
</body>
</html>