<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ifTestFrom01</title>
</head>
<%--
< form 태그의 메소드 방식 >
 1. get 방식
  - 장점 : 속도가 빠름.
  - 단점 : url에 값이 노출됨. 보안에 취약함
 
 2. post 방식
  - 장점 : 값을 웹페이지 내부에 숨겨서 이동함. 보안에 효율적임.
  - 단점 : 속도가 느림.
--%>
<body>
	<h2>숫자 입력 폼</h2>
	<form action="ifTestPro01.jsp" method="get">
		정수 입력 : <input type="text" name="number" ><br>
		<input type="submit" value="입력완료">
	</form>
</body>
</html>
