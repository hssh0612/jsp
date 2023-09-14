<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>includeTestPro01</title>
</head>
<body>
	<h2>include 액션 태그 처리 페이지</h2>
	<%
		String name = request.getParameter("name");
		String pageName = request.getParameter("pageName");
	%>
	
	포함하는 페이지 includeTestPro01.jsp입니다. <br>
	<hr>
	
	<%-- 1번 : 정식 --%>
	<%-- <jsp:include page="<%=pageName %>"></jsp:include> --%>
	
	<%-- 2번 : 약식 --%>
	<%--
		page 속성 : 포함할 페이지
		flush 속성 : 버퍼에 있는 내용을 비우고, 실행할지의 여부, 기본값 : false, 대게는 기본값을 사용
	 --%>
	<jsp:include page="<%=pageName %>"/>
</body>
</html>