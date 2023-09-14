<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forwardTestForm01</title>
</head>
<body>
	<h2>forward 테스트 폼</h2>
	<form action="forwardTestPro01.jsp" method="post">
		아이디 : <input type="text" name="id"><br>
		취미 : 
		<select name="hobby">
			<option>헬스</option>
			<option>수영</option>
			<option>축구</option>
			<option>등산</option>
			<option>캠핑</option>
		</select><br>
		<input type="submit" value="입력 완료">
	</form>
</body>
</html>