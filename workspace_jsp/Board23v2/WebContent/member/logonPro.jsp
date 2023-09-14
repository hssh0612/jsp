<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그온 처리</title>
</head>
<body>
<%
	// 아이디, 비밀번호 획득
	String id = request.getParameter("id");	
	String pwd = request.getParameter("pwd");
	
	// DB 연결, 처리
	MemberDBBean dbPro = MemberDBBean.getInstance();
	int check = dbPro.loginCheck(id, pwd);
	
	// check가 1일 때 -> 로그인 성공 -> 세션을 생성, 게시판 목록 페이지로 이동.
	// check가 0일 때 -> 로그인 실패 -> 로그인 폼으로 이동
	out.print("<script>");
	if(check == 1) {
		// 세션 설정 - 아이디, 비밀번호
		session.setAttribute("id", id);
		session.setAttribute("pwd", pwd);
		out.print("location = '../board/listBoard.jsp'");
	} else {
		out.print("alert('로그인에 실패하였습니다. 다시 로그인하세요.');history.back();");
	}
	out.print("</script>");
%>
</body>
</html>