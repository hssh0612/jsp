<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 폼</title>
<style>
#container { width: 600px; margin: 20px auto;}
h3 { text-align: center;}
table { width: 100%; border: 1px solid black; border-collapse: collapse;}
tr { height: 30px;}
th, td {border: 1px solid black;}
td { padding-left: 5px;}
th { background: #e4dfd1;}
select { width : 200px;}
.acc { background : #dbf4e6;}
textarea { margin-top: 5px;}
input[type="number"] { width: 110px; text-align: right; padding-right: 5px;}

/* number 속성에서 화살표를 없앰 */
input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button {
-webkit-appearance: none; margin: 0;}

/* file 속성 커스터마이징 */
input[type="file"]::file-selector-button { width : 90px; height : 28px; background : #1e9faa; color : #fff;
	border : 1px solid #1e9faa; border-radius : 5px; cursor : pointer;}
input[type="file"]::file-selector-button:hober { background : #c84557; border : #c84557; font-weight : 700;}

.first_row { text-align: center; height: 40px;}
.first_row a { text-decoration: none; color: #495057; font-size: 1.1em; font-weight: 700;}
.first_row a:hover { text-decoration: underline; color: #c84557;}
.btns_row { text-align: center; margin: 20px 10px;}
.btns_row input { width: 110px; height: 35px; border: none; font-size: 14px; font-weight: bold; 
cursor: pointer; margin: 10px;}
.btns_row input[type="button"] { background: #000; color: #fff;}
.btns_row input[type="reset"] { background: #fff; color: #000; border: 2px solid #000;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.insertForm;
		// 상품 분류 번호(kind)
		let kind = document.getElementById("kind");
		
		// 상품 등록 버튼
		let btnInsert = document.getElementById("btnInsert");
		btnInsert.addEventListener("click", function() {
			
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
			location = "productList.jsp?kind=" + kind.value;
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
	
	// 상품 분류 번호(kind) 획득
	String kind = request.getParameter("kind");
%>
<div id="container">
	<h3>상품 등록</h3>
	<form action="productInsertPro.jsp" method="post" enctype="multipart/form-data" name="insertForm">
	<input type="hidden" name="kind" id="kind" value="<%=kind %>">
	<table>
		<tr class="first_row">
			<td colspan="2"><a href="">관리자 메인</a></td>
		</tr>
		<tr>
			<th width="25%">상품 분류</th>
			<td width="75%">
			<select name="product_kind">
				<option value="100" <%if(kind.equals("100")) {%> selected class='acc' <%} %>>소설/시</option>
				<option value="110" <%if(kind.equals("110")) {%> selected class='acc' <%} %>>에세이</option>
				<option value="200" <%if(kind.equals("200")) {%> selected class='acc' <%} %>>인문</option>
				<option value="210" <%if(kind.equals("210")) {%> selected class='acc' <%} %>>역사</option>
				<option value="220" <%if(kind.equals("220")) {%> selected class='acc' <%} %>>예술</option>
				<option value="230" <%if(kind.equals("230")) {%> selected class='acc' <%} %>>종교</option>
				<option value="240" <%if(kind.equals("240")) {%> selected class='acc' <%} %>>사회</option>
				<option value="250" <%if(kind.equals("250")) {%> selected class='acc' <%} %>>과학</option>
				<option value="300" <%if(kind.equals("300")) {%> selected class='acc' <%} %>>경제/경영</option>
				<option value="310" <%if(kind.equals("310")) {%> selected class='acc' <%} %>>자기계발</option>
				<option value="320" <%if(kind.equals("320")) {%> selected class='acc' <%} %>>여행</option>
				<option value="330" <%if(kind.equals("330")) {%> selected class='acc' <%} %>>잡지</option>
				<option value="400" <%if(kind.equals("400")) {%> selected class='acc' <%} %>>어린이</option>
				<option value="410" <%if(kind.equals("410")) {%> selected class='acc' <%} %>>유아</option>
				<option value="420" <%if(kind.equals("420")) {%> selected class='acc' <%} %>>청소년</option>
				<option value="500" <%if(kind.equals("500")) {%> selected class='acc' <%} %>>요리</option>
				<option value="510" <%if(kind.equals("510")) {%> selected class='acc' <%} %>>육아</option>
				<option value="520" <%if(kind.equals("520")) {%> selected class='acc' <%} %>>가정/살림</option>
				<option value="530" <%if(kind.equals("530")) {%> selected class='acc' <%} %>>건강/취미</option>
				<option value="600" <%if(kind.equals("600")) {%> selected class='acc' <%} %>>국어</option>
				<option value="610" <%if(kind.equals("610")) {%> selected class='acc' <%} %>>외국어</option>
				<option value="700" <%if(kind.equals("700")) {%> selected class='acc' <%} %>>수험서</option>
				<option value="710" <%if(kind.equals("710")) {%> selected class='acc' <%} %>>자격증</option>
				<option value="720" <%if(kind.equals("720")) {%> selected class='acc' <%} %>>초등참고서</option>
			</select>
			</td>
		</tr>
		<tr>
			<th>상품 이름</th>
			<td><input type="text" name="product_name" size="57"></td>
		</tr>
		<tr>
			<th>상품 가격</th>
			<td><input type="number" name="product_price" min="0" max="100000000"> 원</td>
		</tr>
		<tr>
			<th>상품 수량</th>
			<td><input type="number" name="product_count" min="0" max="10000"> 권</td>
		</tr>
		<tr>
			<th>저자</th>
			<td><input type="text" name="author" size="57"></td>
		</tr>
		<tr>
			<th>출판사</th>
			<td><input type="text" name="publishing_com" size="57"></td>
		</tr>
		<tr>
			<th>출판일</th>
			<td><input type="date" name="publishing_date"></td>
		</tr>
		<tr>
			<th>상품 이미지</th>
			<td>
				<input type="file" name="product_image">
			</td>
		</tr>
		<tr>
			<th>상품 내용</th>
			<td><textarea name="product_content" cols="59" rows="15"></textarea></td>
		</tr>
		<tr>
			<th>할인율</th>
			<td><input type="number" name="discount_rate" min="0" max="90"> %</td>
		</tr>
		<tr class="btns_row">
			<td colspan="2">
				<input type="button" value="상품 등록" id="btnInsert">
            	<input type="reset" value="다시 입력">
            	<input type="button" value="상품 목록" id="btnList">
            </td>
        </tr>
   </table>
   </form>
</div>
</body>
</html>