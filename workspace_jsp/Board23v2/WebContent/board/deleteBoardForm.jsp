<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글삭제 폼</title>
<style>
#container { width : 300px; margin : 20px auto;}
h2 { text-align : center;}
table { width : 100%; border : 1px solid black; border-collapse : collapse;}
tr { height : 40px;}
th, td { border : 1px solid black;}
.second_row>th { background : #e9ecef;}
.second_row>td { padding-left : 10px;}
.end_row>td { text-align : center; height : 60px; margin : 0 5px;}
.end_row input { width : 90px; height : 35px; background : #343a40; color : #fff;
				 border : none; font-size : 15px; font-wight : bold; margin : 0 5px;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		
		// 페이지 번호
		let pageNum = document.getElementById("pageNum");

		// 글삭제 버튼, 패스워드 유효성 검사
		let btnDelete = document.getElementById("btnDelete");
		btnDelete.addEventListener("click", function() {
			let form = document.deleteForm;
			
			if(!form.pwd.value) {
				alert("패스워드를 입력하세요.");
				form.pwd.focus();
				return;
			}
			form.submit();
		})
		
		// 글목록 버튼
		let btnList = document.getElementById("btnList");
		btnList.addEventListener("click", function() {
			location = "listBoard.jsp?pageNum=" + pageNum.value;
		})
	})
</script>
</head>
<body>
<%

	//페이지 번호 획득
	String pageNum = request.getParameter("pageNum");

	// 글번호 획득
	int num = Integer.parseInt(request.getParameter("num"));
	
%>
<div id="container">
	<h2>글 삭제</h2>
	<form action="deleteBoardPro.jsp" method="post" name="deleteForm">
	<input type="hidden" name="num" value="<%=num %>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>" id="pageNum">
	<table>
		<tr><th colspan="2">패스워드를 입력하시오.</th></tr>
		<tr class = "second_row">
			<th width = "30%">패스워드</th>
			<td width = "70%"><input type="password" name="pwd" size="22" maxlength="12"></td>
		</tr>
		<tr class = "end_row">
			<th colspan="2">
				<input type="button" value="글삭제" id="btnDelete">
				<input type="button" value="글목록" id="btnList">
			</th>
		</tr>
	</table>
	</form>
</div>
</body>
</html>