<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글삭제 처리</title>
</head>
<body>
<%
	// 페이지 번호 획득
	String pageNum = request.getParameter("pageNum");

	// 폼에서 넘어오는 값 획득
	int num = Integer.parseInt(request.getParameter("num"));
	String pwd = request.getParameter("pwd");
	
	// DB 연결, 글삭제 처리
	BoardDBBean dbPro = BoardDBBean.getInstance();
	int count = dbPro.deleteBoard(num, pwd); // 삭제되었다면 1, 삭제되지 않았다면 0
	
	// 삭제 성공 여부
	if(count > 0) { // 삭제 성공 -> 글목록 페이지로 이동
		response.sendRedirect("listBoard.jsp?pageNum=" + pageNum);
	} else { // 삭제 실패 -> 이전 페이지(글 삭제폼 페이지)로 이동
		out.println("<script>alert('패스워드가 일치하지 않습니다.');history.back();</script>");
	}

%>
</body>
</html>