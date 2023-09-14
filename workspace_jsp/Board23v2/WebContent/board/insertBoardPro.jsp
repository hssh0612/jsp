<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글추가 처리</title>
</head>
<body>
	<% request.setCharacterEncoding("utf-8"); %>
	<%-- 폼에서 넘어오는 데이터 --%>
	<jsp:useBean id="board" class="board.BoardDataBean"/>
	<jsp:setProperty property="*" name="board"/>
	
	<%
		// 페이지 번호 획득
		String pageNum = request.getParameter("pageNum");
	
		if(pageNum == null) pageNum = "1";

		// DB 연동, 데이터 추가 처리
		BoardDBBean dbPro = BoardDBBean.getInstance();
		dbPro.insertBoard(board);
		
		// 이동
		response.sendRedirect("listBoard.jsp?pageNum=" + pageNum);
	%>
</body>
</html>