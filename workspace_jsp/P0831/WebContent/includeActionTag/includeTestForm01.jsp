<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>includeTestForm01</title>
</head>
<%--
< 액션 태그 (Action Tag) >
 - JSP의 스크립트 요소를 사용하지 않고, 다른 페이지로 이동할 수 있고, 다른 페이지를 포함할 수 있는 기능을 태그 형태로 만들어 놓은 것.

< 액션 태그의 종류 >
 1. include 액션 태그
 	- 다른 페이지를 포함하는 역할
 2. forward 액션 태그
 	- 다른 페이지로 이동하는 역할
 3. useBean 액션 태그
 	- 자바빈으로 작성된 클래스를 사용하는 역할
 4. setProperty 액션 태그
 	- 자바빈에 데이터를 설정하는 역할
 5. getProperty 액션 태그
 	- 자바빈으로 생성한 데이터를 확인하는 역할
 6. plug-in 액션 태그
 	- 자바 애플릿을 사용하는 역할, 사용하지 않음
 	
-> include, forward : 다른 페이지의 이동과 다른 페이지의 포함에 관한 기능을 함.
-> useBean, setProperty, getProperty : 자바빈과 관련한 기능을 함.
-> 자바빈(JAVA Bean) : JSP에서 사용하는 자바 클래스

 --%>
<body>
	<h2>include 액션 태그 폼 </h2>
	<form action="includeTestPro01.jsp" method="post">
		사용자 이름 : <input type="text" name="name"><br> 
		페이지 이름 : <input type="text" name="pageName" value="includeTest02.jsp"><br>
		<input type="submit" value="전송">
	</form>
</body>
</html>