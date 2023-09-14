<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forwardTestPro01</title>
</head>
<body>
	<h2>포워딩하는 페이지</h2>
	<%-- 
		포워딩 : 객체에 대한 제어를 유지함. 포워딩하는 페이지의 URL을 보여줌.
	--%>
	<%-- <jsp:forward page="forwardTestTo01.jsp" /> --%>
	
	<%-- 
		리다이렉팅 : 객체에 대한 제어를 유지하지 않음. 최종적으로 이동된 페이지 URL을 보여줌.
	--%>
	<%-- <% response.sendRedirect("forwardTestTo01.jsp");%> --%>
	<p>
		이 페이지는 화면에 나타나지 않습니다.<br>
		대신에 url에는 나타나고, 이동한 페이지에서도 제어권은 유지됩니다.
	</p>
</body>
</html>