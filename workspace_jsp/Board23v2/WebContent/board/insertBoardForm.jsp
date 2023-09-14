<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글작성 폼</title>
<style>
#container { width: 500px; margin: 20px auto;}
h2 { text-align: center;}
table { width: 100%; border: 1px solid black; border-collapse: collapse;}
tr { height: 40px;}
th, td { border: 1px solid black;}
th { width: 20%; background-color: #f1f3f5;}
td { width: 80%; padding-left: 10px;}
input:readonly {background : #dee2e6;}
textarea { margin-top: 5px;}
.end_row { background-color: #fff; height: 60px;}
.end_row input { width: 100px; height: 40px; font-size: 14px; font-weight: 700; cursor: pointer; margin: 0 5px;}
.end_row input[type="button"] { background: #495057; color: #fff; border: none;}
.end_row input[type="reset"] { background: #fff; color: #343a40; border:2px solid #343a40;}
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
	
	// 페이지 번호
	let pageNum = document.getElementById("pageNum");
	
	// 글등록 버튼
	let btnInsert = document.getElementById("btnInsert");
	btnInsert.addEventListener("click", function() {
		let form = document.insertForm;
		
		if(!form.writer.value) { // form.writer.value.length == 0
			alert("작성자를 입력 하시오.");
			form.writer.focus();
			return;
		}
		
		if(!form.subject.value) { // form.subject.value.length == 0
			alert("제목을 입력 하시오.");
			form.subject.focus();
			return;
		}
		
		if(!form.email.value) { // form.email.value.length == 0
			alert("이메일을 입력 하시오.");
			form.email.focus();
			return;
		}
		
		if(!form.content.value) { // form.content.value.length == 0
			alert("내용을 입력 하시오.");
			form.content.focus();
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
	
	// 아이디 세션값 획득
	String id = (String)session.getAttribute("id");
	
	// member DB 연결, 처리
	MemberDBBean memberPro = MemberDBBean.getInstance();
	MemberDataBean member = memberPro.getMember(id);
	
	// 페이지 번호 획득
	String pageNum = request.getParameter("pageNum".trim());

	// 초기값 -> 원글
	int num = 0, ref = 1, re_step = 0, re_level = 0;
	
	// 댓글이라면 -> 댓글 처리
	if(request.getParameter("num") != null) {
	   num = Integer.parseInt(request.getParameter("num"));
	   ref = Integer.parseInt(request.getParameter("ref"));
	   re_step = Integer.parseInt(request.getParameter("re_step"));
	   re_level = Integer.parseInt(request.getParameter("re_level"));
	      
	}
%>
<div id="container">
   <h2>게시판 글쓰기</h2>
   <form action="insertBoardPro.jsp" method="post" name="insertForm">
   <input type="hidden" name="num" value="<%=num%>">
   <input type="hidden" name="ref" value="<%=ref %>">
   <input type="hidden" name="re_step" value="<%=re_step %>">
   <input type="hidden" name="re_level" value="<%=re_level %>">
   <input type="hidden" name="pageNum" value="<%=pageNum %>" id="pageNum">
   <table>
      <tr>
         <th>작성자</th>
         <td><input type="text" name="writer" size="49" maxlength="30" value="<%=member.getName() %>"></td>
      </tr>
      <tr>
         <th>제목</th>
         <td><input type="text" name="subject" size="49"></td>
      </tr>
      <tr>
         <th>이메일</th>
         <td><input type="email" name="email" size="49" maxlength="30" value="<%=member.getEmail() %>"></td>
      </tr>
      <tr>
         <th>내용</th>
         <td><textarea name="content" cols="51" rows="20"></textarea></td>
      </tr>
      <tr>
         <th colspan="2" class="end_row">
            <input type="button" value="글등록" id="btnInsert">
            <input type="reset" value="다시작성">
            <input type="button" value="글목록" id="btnList">
         </th>
      </tr>
   </table>
   </form>
</div>
</body>
</html>