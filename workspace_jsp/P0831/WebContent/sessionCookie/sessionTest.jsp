<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sessionTest</title>
</head>
<%--
< 세션과 쿠키 >
 - 연결 상태를 유지
 
 1. 세션 (Session)
  - 연결정보를 서버 측에서 관리
  - 보안에 안전
  - 보안을 유지할 필요가 있는 정보는 세션으로 저장
  
  
 2. 쿠키 (Cookie)
  - 연결정보를 클라이언트 측에서 관리
  - 보안에 취약
  - 보안을 유지할 필요가 없는 정보는 쿠키로 저장

 --%>
<body>
	<h2>세션 테스트</h2>
	
	<%
		String name = "";
	
		if(session.getAttribute("name") != null) {
			name = (String)session.getAttribute("name");
		} else {
			name = "세션값 없음";
		}
		
	%>
	
	<input type="button" onclick="location='sessionSet.jsp'" value="세션값 저장"><br>
	<input type="button" onclick="location='sessionDel.jsp'" value="세션값 삭제"><br>
	<input type="button" onclick="location='sessionInvalidate.jsp'" value="세션값 초기화"><br>

	세션값 확인 : <%=name %><br>
</body>
</html>