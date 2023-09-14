<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forwardTestPro02</title>
</head>
<body>
	<h2>포워딩하는 페이지</h2>
		<jsp:forward page="forwardTestTo02.jsp">
			<jsp:param name="tel" value="010-1111-2222" />
		</jsp:forward>
</body>
</html>