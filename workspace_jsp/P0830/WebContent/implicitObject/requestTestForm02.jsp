<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>requestTestForm02</title>
</head>
<%--
문제) 이름, 성별, 취미를 입력하여 그 내용을 화면에 출력
 - 성별은 라디오 버튼, 취미는 체크박스로 만드시오
 - 결과는 테이블 형태로 출력

 --%>
<body>
	<h2>이름, 성별, 취미를 입력하는 폼</h2>
	<form action="requestTestPro02.jsp" method="get">
	이름 : <input type="text" name="name"><br>
	성별 : 
		<input type="radio" name="sex" value="남">남&ensp;
		<input type="radio" name="sex" value="여">여<br>
	취미 : 
		<input type="checkbox" name="hobby"  value="헬스">헬스&ensp;
		<input type="checkbox" name="hobby"  value="수영">수영&ensp;
		<input type="checkbox" name="hobby"  value="자전거">자전거&ensp;
		<input type="checkbox" name="hobby"  value="바이크">바이크&ensp;
		<input type="checkbox" name="hobby"  value="등산">등산&ensp;
		<input type="checkbox" name="hobby"  value="독서">독서&ensp;
		<input type="checkbox" name="hobby"  value="축구">축구&ensp;
		<input type="checkbox" name="hobby"  value="낚시">낚시&ensp;
		<input type="checkbox" name="hobby"  value="캠핑">캠핑&ensp;
		<input type="checkbox" name="hobby"  value="기타">기타<br>
		<input type="submit" value="입력 완료">
	</form>
</body>
</html>