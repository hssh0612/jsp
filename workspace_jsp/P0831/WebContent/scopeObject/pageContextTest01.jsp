<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pageContextTest01</title>
</head>
<body>
	<h2>pageContext 객체와 request 객체비교 1번</h2>
	<%
	pageContext.setAttribute("pageScope", "페이지 영역 값");
	request.setAttribute("requestScope", "리퀘스트 영역 값");
	%>
	
	pageContext 값: <%=pageContext.getAttribute("pageScope") %><br>
	request 값: <%=request.getAttribute("requestScope") %><br>
	
	
	<jsp:forward page="pageContextTest02.jsp"></jsp:forward>
</body>
</html>