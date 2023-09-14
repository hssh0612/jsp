<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그온 폼</title>
<style>
#container { width : 400px; margin : 50px auto;}
h2 { text-align : center;  margin-bottom : 30px;}
table { width : 100%; border : 1px solid black; border-collapse : collapse;}
tr { height : 60px;}
th, td { border : 1px solid black;}
th { background : #f8f9fa;}
td { padding-left : 10px;}
.in { height : 30px; font-size : 1.1em; padding-left : 5px; border : none;}
.end_row>td { text-align : center;  padding-left :0;}
.end_row input { width : 100px; height : 40px; background : #000; color : #fff; border : none;
		font-size : 15px; font-weight: bold; margin : 0 20px; border-radius : 5px; cursor : pointer;}
.etc { margin-top : 15px; text-align : center;}
.etc>a, .etc>label { text-decoration : none; color : #495057; margin : 0 5px; font-size : 14px;}
.etc>a:hover { font-weight : bold;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.loginForm;
		form.id.focus();
		
		// 로그인 버튼, 유효성 검사
		let btnLogin = document.getElementById("btnLogin");
		btnLogin.addEventListener("click", function() {
			
			if(!form.id.value) {
				alert("아이디를 입력하세요.");
				form.id.focus();
				return;
			}
			
			if(!form.pwd.value) {
				alert("비밀번호를 입력하세요.");
				form.pwd.focus();
				return;
			}
			form.submit();
		})
		
		// 회원가입 버튼
		let btnInsert = document.getElementById("btnInsert");
		btnInsert.addEventListener("click", function() {
			location = "insertMemberForm.jsp";
		})
		
		
		// * Javascript에서 쿠키를 사용하는 방법
		// 쿠키 저장 - 아이디 저장 체크박스를 체크했을 때
		// 쿠키 저장 정보 -> 이름, 값, 유지시간
		// escape() : *, -, _, +, ., /를 제외한 모든 문자를 16진수로 변경
		let id_save = document.getElementById("id_save");
		id_save.addEventListener("click", function() {
			let now = new Date(); // 오늘 날짜
			let name = "cookieId"; // 쿠키 이름
			let value = form.id.value; // 쿠키 값
			
			if(form.id_save.checked == true) { // 체크박스를 체크했을 때 쿠키 생성
				now.setDate(now.getDate() + 7); // 쿠키 유지시간 설정, 7일
				document.cookie = name + "=" + escape(value) +  ";path=/;expires=" + now.toGMTString() + ";";
			
			} else { // 체크박스를 해제했을 때 쿠키 삭제
				now.setDate(now.getDate() + 0); // 쿠키삭제, 유지 시간 0
				document.cookie = name + "=" + escape(value) +  ";path=/;expires=" + now.toGMTString() + ";";
			}
		})
		
		// 쿠키 사용(확인)
		if(document.cookie.length > 0) {
			let search = "cookieId=";
			let idx = document.cookie.indexOf(search);
			if(idx != -1) { // cookieId가 존재한다면
				idx += search.length;
				let end = document.cookie.indexOf(";", idx);
				if(end == -1) {
					end = document.cookie.length;
				}
				form.id.value = document.cookie.substring(idx, end); // 쿠키 값
				form.id_save.checked = true;
			}
		}
		
		
	})
</script>
</head>
<body>
<div id="container">
	<h2>SOLDESK COMMUNITY</h2>
	<form action="logonPro.jsp" method="post" name = "loginForm">
	<table>
		<tr>
			<th width= "30%">아이디</th>
			<td width= "70%"><input type="text" name="id" size="23" class="in"></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="pwd" size="23" maxlength="16" class="in"></td>
		</tr>
		<tr class="end_row">
			<td colspan="2">
				<input type="button" value="로그인" id="btnLogin">
				<input type="button" value="회원가입" id="btnInsert">
			</td>
		</tr>
	</table>
	<div class="etc">
		<input type="checkbox" name="id_save" id="id_save">
		<label for="id_save">아이디 저장</label> |
		<a href="">아이디 찾기</a> |
		<a href="">비밀번호 찾기</a>
	</div>
	</form>
	
</div>
</body>
</html>