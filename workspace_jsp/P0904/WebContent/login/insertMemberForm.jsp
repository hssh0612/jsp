<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertMemberForm</title>
<style>
	#container { width : 500px; margin : 20px auto;}
	h2 { text-align : center;}
	fieldset { margin : 10px;}
	ul { list-style-type : none;}
	ul li { margin : 10px;}
	ul li label { width : 150px; float : left;}
	.btns { text-align : center; margin-top : 20px;}
	.btns>input { width : 100px; height : 35px; border : none; font-size : 13px; font-weight : bold;
	cursor : pointer;}
	input[type="button"] { background-color : #000; color : #fff;}
	input[type="reset"] { background-color : #fff; color : #000; border : 2px solid #000;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let btnInsert = document.getElementById("btnInsert");
		btnInsert.addEventListener("click", function() {
			let form = document.insertForm;
			if(!form.id.value.length) {
				alert("아이디를 입력하시오.");
				form.id.focus();
				return;
			}
			if(!form.pwd.value.length) {
				alert("패스워드를 입력하시오.");
				form.pwd.focus();
				return;
			}
			if(!form.name.value.length) {
				alert("이름을 입력하시오.");
				form.name.focus();
				return;
			}
			if(!form.age.value.length) {
				alert("나이를 입력하시오.");
				form.age.focus();
				return;
			}
			form.submit();
		})
	})
</script>
</head>
<body>
<div id="container">
	<h2>회원가입 폼</h2>
	<fieldset>
		<form action="insertMemberPro.jsp" method="get" name = "insertForm">
			<ul>
				<li>
					<label for="id">아이디</label>
					<input type="text" name="id" id="id">
				</li>
				<li>
					<label for="pwd">패스워드</label>
					<input type="password" name="pwd" id="pwd">
				</li>
				<li>
					<label for="name">이름</label>
					<input type="text" name="name" id="name">
				</li>
				<li>
					<label for="age">나이</label>
					<input type="text" name="age" id="age">
			</ul>
			<div>
				<input type="button" value="회원가입" id="btnInsert">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="다시입력">
			</div>
		</form>
	</fieldset>
</div>
</body>
</html>