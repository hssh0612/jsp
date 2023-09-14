<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ifTestForm04</title>
</head>
<body>
	<%-- 
	문제1) 아이디와 패스워드를 입력하고,
	처리하는 페이지에서는 DB에 저장된 아이디와 패스워스를 비교하여 로그인의 성공여부 출력
	DB에 저장된 아이디는 abcd, 패스워드는 1234로 가정하고, 처리하시오.
	< 출력화면 설계 >
	로그인에 성공하였습니다. or 로그인에 실패하였습니다.
	
	 --%>
	 <h2> 아이디와 패스워드를 입력하는 폼 </h2>
	 <form action="ifTestPro04.jsp" method="post">
	 	아이디 입력 : <input type="text" name="id"><br>
	 	비밀번호 입력 : <input type="password" name="password"><br>
	 	<input type="submit" value="입력 완료">
	 </form>
</body>
</html>