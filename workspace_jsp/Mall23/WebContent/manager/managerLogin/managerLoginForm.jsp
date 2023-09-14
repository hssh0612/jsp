<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 폼</title>
<style>
#container { width : 300px; margin : 20px auto;}
h2 { text-align : center;}
table { width : 100%; border : 1px solid black; border-collapse : collapse;}
tr { height : 50px;}
th, td { border : 1px solid black;}
th { }
td { padding-left : 5px;}
input[type="text"], input[type="password"] { width : 190px; height : 30px; border : none;}
.top_row { background : #dbf4e6;}
.th_row { color : #1e94be;}
.btns { margin-top : 15px; text-align : center;}
.btns input { width : 110px; height : 40px; background : #1e9faa; color : #fff; border : none;
		border-radius : 3px; font-size : 16px; font-weight : 700; cursor : pointer;}	
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.loginForm;
		form.managerId.focus();
		
		// 로그인 버튼 처리, 유효성 검사
		let btnLogin = document.getElementById("btnLogin");
		btnLogin.addEventListener("click", function() {
			if(!form.managerId.value) {
				alert("관리자 아이디를 입력하시오.");
				form.managerId.focus();
				return
			}
			if(!form.managerPwd.value) {
				alert("관리자 비밀번호를 입력하시오.");
				form.managerPwd.focus();
				return
			}
			form.submit();
		})
	})
</script>
</head>
<body>
<div id="container">
	<h2>SOL MALL23</h2>
	<form action="managerLoginPro.jsp" method="post" name="loginForm">
		<table>
			<tr><th colspan="2" class="top_row">관리자 로그인</th></tr>
			<tr>
				<th width="30%" class="th_row">아이디</th>
				<td width="70%"><input type="text" name="managerId" size="24"></td>
			</tr>
			<tr>
				<th class="th_row">비밀번호</th>
				<td><input type="password" name="managerPwd" size="24"></td>
			</tr>
		</table>
		<div class="btns">
			<input type="button" value="로그인" id="btnLogin">
		</div>
	</form>
</div>
</body>
</html>