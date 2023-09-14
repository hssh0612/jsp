<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "manager.product.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 삭제 처리</title>
</head>
<body>
<%
	// 삭제할 아이디들의 값 -> 문자열
	String idList = request.getParameter("idList");
	System.out.println("삭제 아이디 : " + idList);
	
	// 문자열 -> 잘라서 배열로 저장
	List<Integer> ids = new ArrayList<Integer>();
	StringTokenizer st = new StringTokenizer(idList, ",");
	while(st.hasMoreTokens()) {
		ids.add(Integer.parseInt(st.nextToken()));
	}
	
	// 페이지 번호, 상품 분류 번호
	String pageNum = request.getParameter("pageNum");
	String kind = request.getParameter("kind");

	// DB 연결, 삭제 처리
	ProductDAO productPro = ProductDAO.getInstance();
	productPro.deleteProduct(ids);

	// 이동
	response.sendRedirect("productList.jsp?pageNum=" + pageNum + "&kind=" + kind);
	
%>
</body>
</html>