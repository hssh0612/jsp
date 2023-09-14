<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "manager.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세</title>
<style>
#container { width: 600px; margin: 20px auto;}
h3 { text-align: center; font-size : 1.5em;}
table { width: 100%; border: 1px solid black; border-collapse: collapse;}
tr { height: 30px;}
th, td {border: 1px solid black;}
td { padding-left: 5px;}
th { background: #e6c9e1;}
select { width : 200px;}
textarea { margin-top: 5px;}
input[type="number"] { width: 110px; text-align: right; padding-right: 5px;}

/* number 속성에서 화살표를 없앰 */
input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button {
-webkit-appearance: none; margin: 0;}

/* file 속성 커스터마이징 */
input[type="file"]::file-selector-button { width : 90px; height : 28px; background : #1e9faa; color : #fff;
	border : 1px solid #a6615a; border-radius : 5px; cursor : pointer;}
input[type="file"]::file-selector-button:hober { background : #c84557; border : #c84557; font-weight : 700;}

.first_row { text-align: center; height: 40px;}
.first_row a { text-decoration: none; color: #495057; font-size: 1.1em; font-weight: 700;}
.first_row a:hover { text-decoration: underline; color: #c84557;}
.btns_row { text-align: center; margin: 20px 10px;}
.btns_row input { width: 110px; height: 35px; border: none; font-size: 14px; font-weight: bold; 
cursor: pointer; margin: 10px;}
.btns_row input[type="button"] { background: #705e7b; color: #fff;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		
		let form = document.contentForm;
		
		// 페이지 번호(pageNum), 상품 분류 번호(kind)
		let pageNum = document.getElementById("pageNum");
		let kind = document.getElementById("kind");
		
		// 상품 수정 버튼
		let btnUpdate = document.getElementById("btnUpdate");
		btnUpdate.addEventListener("click", function() {
			
			if(!form.product_kind.value) {
				alert("상품 분류를 선택하시오.");
				form.product_kind.focus();
				return;
			}
			
			if(!form.product_name.value) {
				alert("상품 이름을 입력하시오.");
				form.product_name.focus();
				return;
			}
			
			if(!form.product_price.value) {
				alert("상품 가격을 입력하시오.");
				form.product_price.focus();
				return;
			}
			
			if(!form.product_count.value) {
				alert("상품 수량을 입력하시오.");
				form.product_count.focus();
				return;
			}
			
			if(!form.author.value) {
				alert("저자를 입력하시오.");
				form.author.focus();
				return;
			}
			
			if(!form.publishing_com.value) {
				alert("출판사를 입력하시오.");
				form.publishing_com.focus();
				return;
			}
			
			if(!form.publishing_date.value) {
				alert("출판일을 입력하시오.");
				form.publshing_date.focus();
				return;
			}
			
			if(!form.product_image.value) {
				alert("상품 이미지를 선택하시오.");
				form.product_image.focus();
				return;
			}
			
			if(!form.product_content.value) {
				alert("상품 내용을 입력하시오.");
				form.product_content.focus();
				return;
			}
			
			if(!form.discount_rate.value) {
				alert("할인율을 입력하시오.");
				form.discount_rate.focus();
				return;
			}
			form.submit();
		})
		
		// 상품 목록 버튼
		let btnList = document.getElementById("btnList");
		btnList.addEventListener("click", function() {
			location = "productList.jsp?pageNum=" + pageNum.value + "&kind=" + kind.value;
			//location = "productList.jsp";
	   	})
	})
</script>
</head>
<body>
<%

	// 관리자 아이디 세션 획득
	String managerId = (String)session.getAttribute("managerId");
	
	// 관리자 아이디 세션이 없을 때
	if(managerId == null) response.sendRedirect("../managerLogin/managerLoginForm.jsp");
	
	// product_id 값이 없을 때
	//String p_id = request.getParameter("product_id")== null? "" : request.getParameter("product_id");
	//if(p_id.equals("")) out.print("<script>location='../managerLogin/managerLoginForm.jsp';</script>");
	
	// product_id 값 획득
	int product_id = Integer.parseInt(request.getParameter("product_id"));

	// pageNum(페이지 번호), kind(상품 분류) 획득
	String pageNum = request.getParameter("pageNum");
	String kind = request.getParameter("kind");

	// DB 연결, 상품 정보 1개 보기 처리
	ProductDAO productPro = ProductDAO.getInstance();
	ProductVO product = productPro.getProduct(product_id);
	
	// 상품 분류
	String product_kind = product.getProduct_kind();
%>

<div id="container">
	<h3>상품 내용</h3>
	<form action="productUpdatePro.jsp" method="post" enctype="multipart/form-data" name="contentForm">
	<input type="hidden" name="product_id" value="<%=product.getProduct_id() %>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>" id="pageNum">
	<input type="hidden" name="kind" value="<%=kind %>" id="kind">
	<table>
		<tr class="first_row">
			<td colspan="2"><a href="">관리자 메인</a></td>
		</tr>
		<tr>
			<th width="25%">상품 분류</th>
			<td width="75%">
				<select name="product_kind">
					<option value="100" <%if(product_kind.equals("100")) {%> selected <%} %>>소설/시</option>
					<option value="110" <%if(product_kind.equals("110")) {%> selected <%} %>>에세이</option>
					<option value="200" <%if(product_kind.equals("200")) {%> selected <%} %>>인문</option>
					<option value="210" <%if(product_kind.equals("210")) {%> selected <%} %>>역사</option>
					<option value="220" <%if(product_kind.equals("220")) {%> selected <%} %>>예술</option>
					<option value="230" <%if(product_kind.equals("230")) {%> selected <%} %>>종교</option>
					<option value="240" <%if(product_kind.equals("240")) {%> selected <%} %>>사회</option>
					<option value="250" <%if(product_kind.equals("250")) {%> selected <%} %>>과학</option>
					<option value="300" <%if(product_kind.equals("300")) {%> selected <%} %>>경제/경영</option>
					<option value="310" <%if(product_kind.equals("310")) {%> selected <%} %>>자기계발</option>
					<option value="320" <%if(product_kind.equals("320")) {%> selected <%} %>>여행</option>
					<option value="330" <%if(product_kind.equals("330")) {%> selected <%} %>>잡지</option>
					<option value="400" <%if(product_kind.equals("400")) {%> selected <%} %>>어린이</option>
					<option value="410" <%if(product_kind.equals("410")) {%> selected <%} %>>유아</option>
					<option value="420" <%if(product_kind.equals("420")) {%> selected <%} %>>청소년</option>
					<option value="500" <%if(product_kind.equals("500")) {%> selected <%} %>>요리</option>
					<option value="510" <%if(product_kind.equals("510")) {%> selected <%} %>>육아</option>
					<option value="520" <%if(product_kind.equals("520")) {%> selected <%} %>>가정/살림</option>
					<option value="530" <%if(product_kind.equals("530")) {%> selected <%} %>>건강/취미</option>
					<option value="600" <%if(product_kind.equals("600")) {%> selected <%} %>>국어</option>
					<option value="610" <%if(product_kind.equals("610")) {%> selected <%} %>>외국어</option>
					<option value="700" <%if(product_kind.equals("700")) {%> selected <%} %>>수험서</option>
					<option value="710" <%if(product_kind.equals("710")) {%> selected <%} %>>자격증</option>
					<option value="720" <%if(product_kind.equals("720")) {%> selected <%} %>>초등참고서</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>상품 이름</th>
			<td><input type="text" name="product_name" size="57" value="<%=product.getProduct_name() %>"></td>
		</tr>
		<tr>
			<th>상품 가격</th>
			<td><input type="number" name="product_price" min="0" max="100000000" value="<%=product.getProduct_price() %>"> 원</td>
		</tr>
		<tr>
	        <th>상품 수량</th>
	        <td><input type="number" name="product_count" min="0" max="10000" value="<%=product.getProduct_count() %>"> 권</td>
		</tr>
		<tr>
	         <th>저자</th>
	         <td><input type="text" name="author" size="57" value="<%=product.getAuthor() %>"></td>
      	</tr>
      	<tr>
         	<th>출판사</th>
         	<td><input type="text" name="publishing_com" size="57" value="<%=product.getPublishing_com() %>"></td>
     	</tr>
     	<tr>
     		<th>출판일</th>
     		<td><input type="date" name="publishing_date" value="<%=product.getPublishing_date() %>"></td>
     	</tr>
     	<tr>
     		<th>상품 이미지</th>
     		<td>
     			<input type="file" name="product_image">
     		</td>
     	</tr>
     	<tr>
     		<th>상품 내용</th>
     		<td><textarea name="product_content" cols="59" rows="15"><%=product.getProduct_content() %></textarea></td>
     	</tr>
     	<tr>
			<th>할인율</th>
			<td><input type="number" name="discount_rate" min="0" max="90" value="<%=product.getDiscount_rate() %>"> %</td>
		</tr>
		<tr class="btns_row">
			<td colspan="2">
				<input type="button" value="상품 수정" id="btnUpdate">
				<input type="button" value="상품 목록" id="btnList">
			</td>
		</tr>
	</table>
	</form>
</div>
</body>
</html>