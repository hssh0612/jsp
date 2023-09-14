<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>includeTest02</title>
</head>
<body>
	<h2>include 액션 태그 테스트 02</h2>
	<%
		request.setCharacterEncoding("utf-8");
		String name = "홍길동";
		String pageName = "includedTest02.jsp";
	%>
	
	포함하는 페이지 <%=pageName %>입니다. <br>
	포함되는 페이지에 파라미터값을 전달할 수 있습니다.<br>
	<hr>
	
	<jsp:include page="<%=pageName %>">
		<jsp:param name="name" value="<%=name %>"/>
		<jsp:param name="pageName" value="<%=pageName %>"/>
	</jsp:include>
</body>
</html>