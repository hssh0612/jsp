<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forTestPro02</title>
<style>
	table { width : 450px; border : 1px solid black; border-collapse : collapse;}
	tr { height : 40px;}
	th,td { width : 33%;border : 1px solid black; text-align : center;}	
</style>
</head>
<body>
	<h2>게시판 처리 페이지</h2>
	<%
		request.setCharacterEncoding("utf-8");
	
		int num = Integer.parseInt(request.getParameter("number"));
		String[] content = {"", "제목","내용"};
	%>
	<%-- 1번 방법 --%>
	<table>
	<tr><th>글번호</th><th>글제목</th><th>글내용</th></tr>
	<%
		for(int i = num ; i>0;i--) { %>
			<tr>
		<%	for(int j=0; j<3; j++) { %>
				<td> <%=content[j]+i %> </td>
		<% 	} %>
			</tr>
	<%	} %>
	</table>
	<%-- 2번 방법 --%>
	<%
		out.println("<table>");
		out.println("<tr><th>글번호</th><th>글제목</th><th>글내용</th></tr>");
		for(int i = num ; i>0;i--) {
			out.println("<tr>");
			for(int j=0; j<3; j++) {
				out.println("<td>" + (content[j]+i) + "</td>");
			}
			out.println("</tr>");
		}
		out.println("</table>");
	%>
</body>
</html>