<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ifTestPro01</title>
</head>
<body>
	<h2>홀수 짝수 판별 처리 페이지</h2>
	<%-- 스크립틀릿의 활용 방법 --%>
	
	<%
		String strNumber = request.getParameter("number");
		int number = Integer.parseInt(strNumber);
		
		if(number%2 == 1) {
	%>
		<%=number %>는 홀수입니다.
	<%	
		} else { %>
		<%=number %>는 짝수입니다.
	<% } %>
</body>
</html>