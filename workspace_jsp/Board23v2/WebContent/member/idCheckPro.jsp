<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중복 아이디 체크</title>
</head>
<body>
<%
	// 아이디 획득
	String id = request.getParameter("id");
	
	// DB 연결, 처리
	MemberDBBean dbPro = MemberDBBean.getInstance();
	int check = dbPro.idCheck(id);
	
	// check가 1일 때 -> 아이디가 이미 존재할 때 -> 입력한 아이디는 사용불가
	// check가 0일 때 -> 아이디가 존재하지않을 때 -> 입력한 아이디는 사용가능
%>
<script>
<% if(check == 1) {%>
	alert('이미 사용중인 아이디가 있습니다. 다른 아이디를 입력하세요.');
	location = 'insertMemberForm.jsp?check=1';
<% } else if (check == 0) { %>
	alert('사용 가능한 아이디입니다.');
	location = 'insertMemberForm.jsp?check=0';
<% } %>
</script>

</body>
</html>