<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sessionLoginForm</title>
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
		let btnLogin = document.getElementById("btnLogin");
		btnLogin.addEventListener("click", function() {
			let form = document.LoginForm;
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
			form.submit();
		})
	})
</script>
</head>
<body>
<div id="container">
	<h2>로그인 폼</h2>
	<fieldset>
	<form action="sessionLoginPro02.jsp" method="post" name="LoginForm"> 
		<ul>
			<li>
				<label for="id">아이디</label>
				<input type="text" name="id" id="id">
			</li>
			<li>
				<label for="pwd">패스워드</label>
				<input type="password" name="pwd" id="pwd">
			</li>
		</ul>
		<div class="btns">
			<input type="button" value="로그인" id="btnLogin">&nbsp;&nbsp;&nbsp;
			<input type="reset" value="다시입력">
		</div>
	</form>
	</fieldset>
</div>
</body>
</html>