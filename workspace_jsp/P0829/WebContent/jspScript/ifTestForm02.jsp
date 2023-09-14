<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ifTestForm02</title>
</head>
<%--
 문제1) 폼에서 이름과 나이를 입력하여 나이에 따라 청년, 중년, 장년, 노년을 판별하시오
 청소년 : 19세 미만, 청년 : 19~34세, 중년 : 35~49, 장년 : 50~64, 노년 : 65세 이상
 
 < 출력화면 >
 홍길동님은 38세이므로 중년에 속합니다.
 
 --%>
<body>
	<h2>이름과 나이를 입력하는 폼</h2>
	<form action="ifTestPro02.jsp" method="post">
		이름 입력 : <input type="text" name="name" ><br>
		나이 입력 : <input type="text" name="age" ><br>
		<input type="submit" value="입력완료">
	</form>
</body>
</html>