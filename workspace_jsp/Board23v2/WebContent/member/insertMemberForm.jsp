<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 폼</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
#container { width: 550px; margin: 20px auto;}
h2 { text-align : center; margin-bottom : 50px;}
table { width : 100%; border: 1px solid black; border-collapse : collapse;}
tr { height : 50px;}
th, td { border : 1px solid black;}
th { font-size : 15px; background : #f1f3f5;}
td { padding-left : 10px;}
.first_row { height : 70px;}
.first_row #btnCheck { width : 80px; height : 27px; background : #99424f; border : none; color : #fff;
		font-weight : bold; border-radius : 5px; margin-left : 10px;}
.first_row .s_id { font-size : 12px; font-weight : bold;}
.first_row .s_1 { color : #c84557;}
.first_row .s_0 { color : #1e94be;}
.end_row { height : 100px;}
.end_row>td>input { margin : 4px 0;}
.end_row #btnAddress { width : 80px; height : 27px; background : #1e94be; border : none;
		color : #fff; font-weight : bold; border-radius : 5px;}
.btns { text-align : center;}
.btns>input { width : 100px; height : 40px; background : #000; color : #fff; border : none;
		font-weight : bold; font-size : 16px; margin : 20px;}

</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		
		let form = document.insertForm;
		
		// 회원가입 버튼, 유효성 검사
		let btnInsert = document.getElementById("btnInsert");
		btnInsert.addEventListener("click", function() {
			
			
			if(!form.id.value) {
				alert("아이디를 입력하시오");
				form.id.focus();
				return;
			}
			
			if(!form.pwd.value) {
				alert("비밀번호를 입력하시오");
				form.pwd.focus();
				return;
			}
			if(!form.pwd2.value) {
				alert("비밀번호를 확인하시오");
				form.pwd2.focus();
				return;
			}
			
			// 비밀번호 확인
			if(form.pwd.value != form.pwd2.value) {
				alert("같은 비밀번호를 입력하시오.");
				form.pwd2.focus();
				return;
			}
			
			if(!form.name.value) {
				alert("이름을 입력하시오");
				form.name.focus();
				return;
			}
			if(!form.birthday.value) {
				alert("생년월일을 입력하시오");
				form.birthday.focus();
				return;
			}
			if(!form.email.value) {
				alert("이메일을 입력하시오");
				form.email.focus();
				return;
			}
			if(!form.tel.value) {
				alert("전화번호를 입력하시오");
				form.tel.focus();
				return;
			}
			if(!form.address1.value) {
				alert("기본주소를 입력하시오");
				form.address1.focus();
				return;
			}
			if(!form.address2.value) {
				alert("상세주소를 입력하시오");
				form.address2.focus();
				return;
			}
			form.submit();
		})
		
		// 중복 아이디 체크
		let btnCheck = document.getElementById("btnCheck");
		btnCheck.addEventListener("click", function() {
			if(!form.id.value) {
				alert("ID 중복 체크하기위한 아이디를 입력하시오.");
				form.id.focus();
				return;
			}
			location = "idCheckPro.jsp?id=" + form.id.value;
		})
		
		// 주소 찾기 버튼
		let btnAddress = document.getElementById("btnAddress");
		btnAddress.addEventListener("click", function() {
			new daum.Postcode({
				oncomplete: function(data) {
					form.address1.value = data.address;
				}
			}).open();
		})
		
		// 취소 버튼
		let btnCancel = document.getElementById("btnCancel");
		btnCancel.addEventListener("click", function() {

			location = "logonForm.jsp";
		})
		
		
	})
</script>
</head>
<body>
<%
	// 아이디 중복 체크 값 획득
	// check가 1일 때 -> 아이디가 이미 존재할 때 -> 입력한 아이디는 사용불가
	// check가 0일 때 -> 아이디가 존재하지않을 때 -> 입력한 아이디는 사용가능
	String check = request.getParameter("check");
	if(check == null) check = "-1";
%>
<div id="container">
	<h2>회원 가입</h2>
	<form action="insertMemberPro.jsp" method = "post" name="insertForm">
	<table>
		<tr class="first_row">
			<th width="20%">아이디</th>
			<td width="80%">
				<input type="text" name="id" value="">
				<input type="button" value="ID중복체크" id="btnCheck"><br>
				<% if(check.equals("-1")) { %>
					<span class="s_id">중복 아이디를 체크하시오.</span>
				<% } else if(check.equals("1")) {%>
					<span class="s_id s_1">사용중인 아이디입니다. 아이디를 다시 입력하시오.</span>
				<% } else if(check.equals("0")) {%>
					<span class="s_id s_0">사용가능한 아이디입니다.</span>
				<% } %>

			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="pwd"></td>
		</tr>
	
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" name="pwd2"></td>
		</tr>
	
		<tr>
			<th>이름</th>
			<td><input type="text" name="name"></td>
		</tr>
	
		<tr>
			<th>생년월일</th>
			<td><input type="date" name="birthday"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="email" name="email"></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="text" name="tel"></td>
		</tr>
		<tr class = "end_row">
			<th>주소</th>
			<td>
				<input type="button" value="주소 찾기" id="btnAddress"><br>
				<input type="text" name="address1" size="55" placeholder="기본주소 입력"><br>
				<input type="text" name="address2" size="55" placeholder="상세주소 입력">
			</td>
		</tr>
	</table>
	<div class="btns">
		<input type="button" value="회원가입" id="btnInsert"> 
		<input type="button" value="취소" id="btnCancel">
	</div>
	</form>
</div>
</body>
</html>