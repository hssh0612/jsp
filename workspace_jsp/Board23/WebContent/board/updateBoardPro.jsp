<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정 처리</title>
</head>
<body>
	<% request.setCharacterEncoding("utf-8"); %>

	<jsp:useBean id="board" class="board.BoardDataBean"/>
	<jsp:setProperty property="*" name="board"/>
	
	<%
	
		// 페이지 번호 확인
		String pageNum = request.getParameter("pageNum");
	
		BoardDBBean dbPro = BoardDBBean.getInstance();
		int count = dbPro.updateBoard(board); // 1: 수정 성공, 0 : 수정 실패
		
		if(count > 0) { // 수정 성공
			response.sendRedirect("listBoard.jsp?pageNum=" + pageNum);

		} else { // 수정 실패
			out.println("<script>alert('패스워드가 일치하지 않습니다.');history.back();</script>");
		}
	%>
</body>
</html>