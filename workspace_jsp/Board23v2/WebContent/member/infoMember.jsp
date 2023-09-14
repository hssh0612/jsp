<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 확인 폼</title>
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
.end_row { height : 100px;}
.end_row>td>input { margin : 4px 0;}
.end_row #btnAddress { width : 80px; height : 27px; background : #1e94be; border : none;
		color : #fff; font-weight : bold; border-radius : 5px;}
.btns { text-align : center;}
.btns>input { width : 100px; height : 40px; background : #000; color : #fff; border : none;
		font-weight : bold; font-size : 14px; margin : 20px;}

</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		
		let form = document.infoForm;
		
		// 회원정보수정 버튼, 유효성 검사
		let btnUpdate = document.getElementById("btnUpdate");
		btnUpdate.addEventListener("click", function() {
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

		// 주소 찾기 버튼
		let btnAddress = document.getElementById("btnAddress");
		btnAddress.addEventListener("click", function() {
			new daum.Postcode({
				oncomplete: function(data) {
					form.address1.value = data.address;
				}
			}).open();
		})
		
		// 회원탈퇴 버튼 - 아이디(세션)와 비밀번호(리퀘스트)를 가지고 이동
		let btnDelete = document.getElementById("btnDelete");
		let pwd = document.getElementById("pwd");
		btnDelete.addEventListener("click", function() {
			
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
			
			// 회원 탈퇴 여부 재확인
			let isDelete = confirm("정말 탈퇴하시겠습니까?");
			if(!isDelete) return;
			location = "deleteMemberPro.jsp?pwd=" + pwd.value;
		})
		
		// 글목록 버튼
		let btnList = document.getElementById("btnList");
		btnList.addEventListener("click", function() {
			location = "../board/listBoard.jsp";
		})
		
	})
</script>
</head>
<body>
<%
	// 아이디 세션값 획득
	String id = (String)session.getAttribute("id");

	// 날짜 처리
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
	
	// DB 연결, 처리
	MemberDBBean dbPro = MemberDBBean.getInstance();
	MemberDataBean member = dbPro.getMember(id);
	
%>
<div id="container">
	<h2>회원 정보 확인</h2>
	<form action="updateMemberPro.jsp" method = "post" name="infoForm">
	<table>
		<tr>
			<th width="20%">아이디</th>
			<td width="80%">
				<%=member.getId() %>
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="text" name="pwd" value="<%=member.getPwd() %>" id="pwd"></td>
		</tr>
	
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" name="pwd2"></td>
		</tr>
	
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" value="<%=member.getName() %>"></td>
		</tr>
	
		<tr>
			<th>생년월일</th>
			<td><input type="date" name="birthday" value="<%=member.getBirthday() %>"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="email" name="email" value="<%=member.getEmail() %>"></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="text" name="tel" value="<%=member.getTel() %>"></td>
		</tr>
		<tr class = "end_row">
			<th>주소</th>
			<td>
				<input type="button" value="주소 찾기" id="btnAddress"><br>
				<input type="text" name="address1" size="55" value = "<%=member.getAddress1() %>"><br>
				<input type="text" name="address2" size="55" value = "<%=member.getAddress2() %>">
			</td>
		</tr>
		<tr>
			<th>가입일</th>
			<td><%=sdf.format(member.getReg_date()) %></td>
		</tr>
	</table>
	<div class="btns">
		<input type="button" value="회원정보 수정" id="btnUpdate"> 
		<input type="button" value="회원탈퇴" id="btnDelete">
		<input type="button" value="글 목록" id="btnList">
	</div>
	</form>
</div>
</body>
</html>