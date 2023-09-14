<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.Enumeration, manager.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품정보 수정처리</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	// 파일 업로드 객체와 변수 선언
	MultipartRequest multi = null;
	
	//String saveFolder = "/imageFile"; // 실제 저장 폴더
	String encType = "utf-8"; // 인코딩 방법
	int maxSize = 5* 1024 * 1024; // 최대 업로드 파일 크기
	
	// 파일 업로드 위치 설정
	// 문제점
	// 1. 업로드되는 실제 위치를 웹서버에서 인식하지 못하는 문제 발생.
	// 2. 위의 경로는 접근하기도 어려움
	
	/*
	ServletContext context = getServletContext();
	String realFolder = context.getRealPath(saveFolder); // 업로드 파일 위치
	*/
	
	// 해결책 -> 접근하기 쉬운 위치로 변경
	String realFolder = "c:/imageFile";
	String fileName ="";
	
	// 파일 업로드 처리
	try { 
	   multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	   
	   Enumeration<?> files = multi.getFileNames();
	   while(files.hasMoreElements()) {
	      String name = (String)files.nextElement();
	      fileName =  multi.getFilesystemName(name); // 실제 업로드된 파일 이름
	      //System.out.println("파일이름: " + fileName);
	   }
	} catch(Exception e) {
	   e.printStackTrace();
	   System.out.println("# error: 파일 업로드 중에 예외 발생...");
	}
	
	// pageNum(페이지 번호),kind(상품 분류) 획득
	String pageNum = multi.getParameter("pageNum");
	String kind = multi.getParameter("kind");
	
	
	// product_id도 획득
	// 폼에서 넘어오는 파일 획득(10개) + 업로드 이미지 파일 처리(1개) -> 11개
	int product_id = Integer.parseInt(multi.getParameter("product_id"));
	String product_kind = multi.getParameter("product_kind");
	String product_name = multi.getParameter("product_name");
	int product_price = Integer.parseInt(multi.getParameter("product_price"));
	int product_count = Integer.parseInt(multi.getParameter("product_count"));
	String author = multi.getParameter("author");
	String publishing_com = multi.getParameter("publishing_com");
	String publishing_date = multi.getParameter("publishing_date");
	String product_content = multi.getParameter("product_content");
	int discount_rate = Integer.parseInt(multi.getParameter("discount_rate"));
	
	// 이미지 업로드
	/*
	String product_image = multi.getParameter(fileName);
	String product_content = multi.getParameter("product_content");
	*/
	
	// ProductVO 객체에 저장
	ProductVO product = new ProductVO();
	product.setProduct_id(product_id);
	product.setProduct_kind(product_kind);
	product.setProduct_name(product_name);
	product.setProduct_price(product_price);
	product.setProduct_count(product_count);
	product.setAuthor(author);
	product.setPublishing_com(publishing_com);
	product.setPublishing_date(publishing_date);
	product.setProduct_image(fileName); // 업로드 이미지 처리한 파일명
	product.setProduct_content(product_content);
	product.setDiscount_rate(discount_rate);
	
	// 확인
	//System.out.println(product);
	
	//DB 연결, 처리
	ProductDAO productPro = ProductDAO.getInstance();
	productPro.updateProduct(product);
	
	// 이동 -> 상품 목록
	response.sendRedirect("productList.jsp?pageNum=" + pageNum + "&kind=" + kind);
%>
</body>
</html>