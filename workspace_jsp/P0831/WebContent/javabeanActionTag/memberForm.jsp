<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberForm</title>
</head>
<body>
	<h2>멤버 정보 입력 폼</h2>
	<form action="memberPro.jsp" method="post">
		아이디 : <input type="text" name= "id"><br>
		패스워드 : <input type="password" name= "userpass"><br>
		이름 : <input type="text" name= "username"><br>
		나이 : <input type="text" name= "age"><br>
		생일 : <input type="text" name= "birthday"><br>
		이메일 : <input type="text" name= "email"><br>
		주소 : <input type="text" name= "address"><br>
		직업 : <input type="text" name= "job"><br>
		전화번호 : <input type="text" name= "tel"><br>
		취미 : 
		<select name="hobby">
			<option>헬스</option>
			<option>수영</option>
			<option>축구</option>
			<option>등산</option>
			<option>캠핑</option>
		</select><br>
		<input type="submit" value= "입력 완료">
	</form>
</body>
</html>