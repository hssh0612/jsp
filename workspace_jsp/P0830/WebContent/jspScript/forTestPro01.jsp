<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forTestPro01</title>
<style>
	table { width : 200px; border : 1px solid black; border-collapse : collapse;}
	tr { height : 30px;}
	th,td { border : 1px solid black; text-align : center;}
	
</style>
</head>
<body>
	<h2>구구단의 단을 출력하는 페이지</h2>
	<%
		request.setCharacterEncoding("utf-8");
		
		int dan = Integer.parseInt(request.getParameter("dan"));
		
	%>
	
	<%-- 테이블을 이용해서 입력한 단을 출력 --%>
	<%-- 1. 스크립틀릿, 표현식 --%>
	<table>
	<tr><th><%=dan %>단</th></tr>
	<%
		for(int i=1; i<=9; i++){ %>
			<tr><td><%=dan %> * <%=i %> = <%=dan*i %></td></tr>
	<%	} %>
	</table>
	
	<hr>
	
	<%-- 2. 스크립틀릿, out 내장객체 --%>
	<%
		out.println("<table>");
		out.println("<tr><th>" + dan + "단</th></tr>");
		for(int i=1;i<=9;i++) {
			out.println("<tr><td>" + dan + " * " + i + " = " + (dan*i) + "</td></tr>");
		}
		out.println("</table>");
	%>
</body>
</html>