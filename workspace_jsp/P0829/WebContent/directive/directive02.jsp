<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>directive 02번</title>
</head>
<%--
 2. include directive
  - 여러 페이지에서 공통적으로 사용하는 내용에 따로 정의해 놓고, 필요한 JSP 페이지에서 삽입하여 사용하는 기능을 제공
--%>
<body>
	<%
		String name = "홍길동";
	%>
	<%@ include file="include01.jsp" %>
	<hr>
	<h2> directive 02번 - include directive </h2>
	<h2>directive 2번 페이지입니다.</h2>
	<hr>
	
	<%@ include file="include02.jsp" %>
	
</body>
</html>