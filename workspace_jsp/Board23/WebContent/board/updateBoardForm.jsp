<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정 폼</title>
<style>
#container { width: 500px; margin: 20px auto;}
h2 { text-align: center;}
table { width: 100%; border: 1px solid black; border-collapse: collapse;}
tr { height: 40px;}
th, td {border: 1px solid black;}
th { background: #e9ecef;}
td>input, td>textarea { margin-left: 10px;}
td>textarea { margin-top: 5px;}
.read { background: #e9ecef;}
.accent { font-size: 11px; font-weight: 700; color: #f00; margin-left: 10px;}
.btns { margin-top: 5px; text-align: center;}
.btns>input { width: 100px; height: 35px; background: #000; color: #fff; border: none;
font-size: 15px; font-weight: 700; cursor: pointer; margin: 10px;}
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
	
	// 페이지 번호
	let pageNum = document.getElementById("pageNum");
	
	// 글수정 버튼, 유효성 검사
	let btnUpdate = document.getElementById("btnUpdate");
	btnUpdate.addEventListener("click", function() {
	
		let form = document.updateForm;
	
		if(!form.pwd.value) {
			alert("패스워드를 입력하시오.");
			form.pwd.focus();
			return;
		}
		
		if(!form.writer.value) {
			alert("작성자를 입력하시오.");
			form.writer.focus();
			return;
		}
		
		if(!form.email.value) {
			alert("이메일을 입력하시오.");
			form.email.focus();
			return;
		}
	      
		if(!form.subject.value) {
			alert("제목을 입력하시오.");
			form.subject.focus();
			return;
		}
	      
		if(!form.content.value) {
			alert("내용을 입력하시오.");
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
	// 글번호 획득
	int num = Integer.parseInt(request.getParameter("num"));

	// 페이지 번호 획득
	String pageNum = request.getParameter("pageNum");
	
	// DB 연결, 글번호에 따라 1건 조회
	BoardDBBean dbPro = BoardDBBean.getInstance();
	BoardDataBean board = dbPro.getBoardUpdate(num);

%>
<div id="container">
   <h2>글수정</h2>
   <form action="updateBoardPro.jsp" method="post" name="updateForm">
   <input type="hidden" name="pageNum" id="pageNum" value="<%=pageNum %>">
   <table>
      <tr>
         <th width="15%">글번호</th>
         <td width="85%"><input type="text" name="num" value="<%=board.getNum() %>" size="52" readonly class="read"></td>      
      </tr>
      <tr>
         <th>패스워드</th>
         <td>
            <input type="text" name="pwd" value="" size="52" maxlength="12">
            <span class="accent">패스워드는 사용자 확인을 위해 사용합니다.(수정 불가)</span>
         </td>      
      </tr>
      <tr>
         <th>작성자</th>
         <td><input type="text" name="writer" value="<%=board.getWriter() %>" size="52" maxlength="30"></td>      
      </tr>
      <tr>
         <th>이메일</th>
         <td><input type="email" name="email" value="<%=board.getEmail() %>" size="52" maxlength="30"></td>      
      </tr>
      <tr>
         <th>제목</th>
         <td><input type="text" name="subject" value="<%=board.getSubject() %>" size="52" maxlength="30"></td>      
      </tr>
      <tr>
         <th>내용</th>
         <td><textarea name = "content" cols="54.5" rows="15"><%=board.getContent() %></textarea></td>      
      </tr>
   </table>
   <div class="btns">
      <input type="button" value="글수정" id="btnUpdate">
      <input type="button" value="글목록" id="btnList">
   </div>
   </form>   
</div>
</body>
</html>