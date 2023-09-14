<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글상세 보기</title>
<style>
#container { width: 500px; margin: 20px auto;}
h2 { text-align: center;}
table { width: 100%; border: 1px solid black; border-collapse: collapse;}
tr { height: 40px;}
th, td { border: 1px solid black;}
th { background: #e9ecef;}
.center { text-align: center;}
.left { padding-left: 15px;}
.end_row { height: 200px;}
.btns { margin-top: 10px; text-align: center;}
.btns>input { width: 100px; height:35px; margin: 5px; background: #000; color: #fff;
border: none; font-size: 15px; font-weight: bold; cursor: pointer;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		
		// 글 번호, 댓글 그룹화 변수, 댓글 그룹 순서, 댓글 그룹 단계
		let num = document.getElementById("num");
		let ref = document.getElementById("ref");
		let re_step = document.getElementById("re_step");
		let re_level = document.getElementById("re_level");
		
		//페이지 번호
		let pageNum = document.getElementById("pageNum");
		
		// 글 목록 버튼
		let btnList = document.getElementById("btnList");
		btnList.addEventListener("click", function() {
			location = "listBoard.jsp?pageNum=" + pageNum.value;
		})
		
		// 글 삭제 버튼
		let btnDelete = document.getElementById("btnDelete");
		btnDelete.addEventListener("click", function() {
		   location = "deleteBoardForm.jsp?num=" + num.value + "&pageNum=" + pageNum.value;
		})
		
	    // 글 수정 버튼
	    let btnUpdate = document.getElementById("btnUpdate");
		btnUpdate.addEventListener("click" , function() {
			location = "updateBoardForm.jsp?num=" + num.value + "&pageNum=" + pageNum.value;
		})
		
		// 댓글쓰기 버튼 - num, ref, re_step, re_level
		let btnReply = document.getElementById("btnReply");
		btnReply.addEventListener("click", function() {
			location = "insertBoardForm.jsp?num="+num.value+"&ref="+ref.value+"&re_step="+re_step.value
					+"&re_level="+re_level.value + "&pageNum=" +pageNum.value;

		})
	})
</script>
</head>
<body>
<%
	// 글번호 확인
	int num = Integer.parseInt(request.getParameter("num").trim());

	// 페이지 번호 확인
	String pageNum = request.getParameter("pageNum");

	
	// DB 연결, 글번호로 글1건 상세보기 조회
	BoardDBBean dbPro = BoardDBBean.getInstance();
	BoardDataBean board = dbPro.getBoard(num);
	
	// 원글의 정보 획득
	int ref = board.getRef();
	int re_step = board.getRe_step();
	int re_level = board.getRe_level();
	
	// 날짜 처리
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");

%>
<div id="container">
   <h2>글상세 보기</h2>
   <table>
   		<input type="hidden" id="pageNum" value="<%=pageNum %>">
	 	<input type="hidden" id="num" value="<%=num %>">
	 	<input type="hidden" id="ref" value="<%=ref %>">
	 	<input type="hidden" id="re_step" value="<%=re_step %>">
	 	<input type="hidden" id="re_level" value="<%=re_level %>">
	    <tr>
	       <th width="15%">번호</th>
	       <td width="35%" class="center"><%=board.getNum() %></td>
	       <th width="15%">조회수</th>
	       <td width="35%" class="center"><%=board.getReadcount() %></td>
	    </tr>
	    <tr>
	       <th width="15%">작성자</th>
	       <td width="85%" colspan="3" class="left"><%=board.getWriter()%></td>
	    </tr>
	    <tr>
	       <th>등록일</th>
	       <td colspan="3" class="left"><%=sdf.format(board.getReg_date()) %></td>
	    </tr>
	    <tr>
	       <th>제목</th>
	       <td colspan="3" class="left"><%=board.getSubject() %></td>
	    </tr>
	    <tr class="end_row">
	       <th>내용</th>
	       <td colspan="3" class="left"><%=board.getContent() %></td>
	    </tr>
   </table>
   <div class="btns">
      <input type="button" value="글수정" id="btnUpdate">
      <input type="button" value="글삭제" id="btnDelete">
      <input type="button" value="댓글쓰기" id="btnReply">
      <input type="button" value="글목록" id="btnList">
   </div>
</div>
</body>
</html>