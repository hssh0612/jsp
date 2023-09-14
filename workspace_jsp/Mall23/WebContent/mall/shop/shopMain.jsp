<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 메인</title>
<style>
#container { width : 1200px; margin : 0 auto;}
</style>
</head>
<body>
<div id="container">
	<%-- 상단 --%>
	<div>
		<header><jsp:include page="../common/shopTop.jsp"/></header>
	</div>
	<%-- 본문 --%>
	<div>
		<main>
		
		<%-- 1. 상품 전체 또는 상품 분류별로 상품 노출 --%>
		<article><jsp:include page="../shop/shopAll.jsp"/></article>
			
		</main>
	</div>
	<%-- 하단 --%>
	<div>
		<footer><jsp:include page="../common/shopBottom.jsp"/></footer>
	</div>
</div>
</body>
</html>