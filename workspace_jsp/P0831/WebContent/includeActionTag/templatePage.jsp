<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>templatePage</title>
<style>
	table { width: 1200px; border : 1px solid black; border-collapse : collapse;}
	tr { height : 150px;}
	th, td { border : 1px solid black; }
</style>
</head>
<body>
	<table>
		<tr>
			<td colspan="2"><jsp:include page="topPage.jsp"/></td>
		</tr>
		<tr>
			<td width = "20%"><jsp:include page="leftPage.jsp"/></td>
			<td width = "80%"><jsp:include page="contentPage.jsp"/></td>
		</tr>
		<tr>
			<td colspan="2"><jsp:include page="bottomPage.jsp"/></td>
		</tr>
	</table>
</body>
</html>