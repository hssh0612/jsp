<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*,java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글전체 목록</title>
<style>
#container { width : 800px; margin : 20px auto;}
/* 상단 영역 */
h2 { text-align : center;}
.top1>.t1{ float : left;}
.top1>.t2, .top1>.t3 , .top1>.t4 { float : right; margin : 0 10px;}
.top1 { margin-bottom : 50px;}
.top1 a { text-decoration : none; color : #1e94be; font-weight : 700;}
.top1 a:hover { text-decoration : underline; color : #705e7b;}

/* 테이블 영역 */
table { width : 100%; border : 1px solid black; border-collapse : collapse;}
tr { height : 35px;}
th,td { border : 1px solid black;}
th { background-color : #e9ecef;}
.center { text-align : center;}
.left { padding-left : 10px;}
.left>a { text-decoration : none; color : #32708d; font-weight : 700;}
.left>a:hover { color : #cd4d4d; text-decoration: underline;}
.count_zero { text-align : center;}

/* 페이징 영역 */
#paging { margin-top : 30px; text-align : center; font-weight : 700;}
.pbox { display : inline-block; width : 22px; height : 22px; border-radius : 30%;
	margin: 0 6px; padding : 5px; background : #fff; color : #343a40;}
.cbox { background :#343a40; color : #fff; font-weight : 700;}
.pbox:hover { background : #343a40; color : #fff;}
.arrow {width : 15px; height :15px;}
</style>
</head>
<body>
<%
	// 아이디 세션값 획득
	String id = (String)session.getAttribute("id");

	// 날짜 포맷
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	// 페이징(paging) 처리
	int pageSize = 10; // 1페이지에 보여줄 건수, 10건
	String pageNum = request.getParameter("pageNum"); // 페이지번호 획득
	
	if(pageNum == null) pageNum = "1"; // 페이지 번호가 없을 때 pageNum을 1페이지 설정
	
	int currentPage = Integer.parseInt(pageNum.trim()); // 현재 페이지 <- 페이지번호
	int startRow = (currentPage - 1) * pageSize + 1; // 현재 페이지에서 보여줄 첫번째 행
	int endRow = currentPage * pageSize; // 현재 페이지에서 보여줄 마지막 행
	
	

	// DB 연결, 글전체 보기 처리
	BoardDBBean dbPro = BoardDBBean.getInstance();
	List<BoardDataBean> boardList = dbPro.getBoards(startRow, pageSize);
	
	// 전체 글수 확인 -> 글번호
	int count = dbPro.getBoardCount();
	
	// 글번호를 해당 페이지 번호
	int tCount = count - ((currentPage-1) * pageSize);

%>
<div id="container">
	<h2>게시판 글목록</h2>
	<div class="top1">
		<div class="t1">전체 글수: <b><%=count %></b>건</div>
		<div class="t2"><a href="insertBoardForm.jsp?pageNum=1">글등록</a></div>
		<div class="t3"><a href="../member/logout.jsp">로그아웃</a></div>
		<%-- 회원정보 확인 --%>
		<div class="t4"><a href="../member/infoMember.jsp"><%=id %></a>님</div>
   	</div>
   	
	<table>
		<tr>
			<th width="8%">번호</th>
			<th width="50%">제목</th>
			<th width="14%">작성자</th>
			<th width="20%">등록일</th>
			<th width="8%">조회수</th>
		</tr>
		<% if(count == 0) { // 등록된 글이 없을 때 %>
		<tr><td colspan="5" class="count_zero">등록된 글이 없습니다.</td></tr>
		<% } else { // 등록된 글이 있을 때
		for( BoardDataBean board : boardList) { %>
		<tr>
			<td class="center"><%=tCount-- %></td>
			<td class="left">
				<%-- 댓글의 레벨 : 0: 원글, 1: 댓글, 2: 댓글에 댓글 --%>
				<%
					if(board.getRe_level() > 0 ) {
						int width = board.getRe_level() * 15;
						out.println("<img src='../icons/level.png' height='16' width='" + width +"'>");
						out.println("<img src='../icons/reply.png' height='16' width='16'>");
					}
				%>
				<a href="contentBoard.jsp?num=<%=board.getNum() %> &pageNum= <%=pageNum %>"><%=board.getSubject() %></a>
				<%-- 조회수가 30이 넘으면 hot.png 이미지를 붙임 --%>
				<%
					if(board.getReadcount() > 30) {
						out.println("<img src='../icons/best.png' height='16'>");
					}
				%>
			</td>
			<td class="center"><%=board.getWriter() %></td>
			<td class="center"><%=sdf.format(board.getReg_date()) %></td>
			<td class="center"><%=board.getReadcount() %></td>
		
		</tr>
		<% } } %>
	</table>
	<%-- 페이징 처리 --%>
	<div id="paging">
	<%
		if(count > 0) {
			
			// 전체 페이지 수
			// 265건, 페이지사이즈 10이라면 27개의 페이지 생성 
			int pageCount = count / pageSize + (count%pageSize==0 ? 0: 1);
			
			int startPage = 1; // 시작페이지 번호
			int pageBlock = 10; // 페이징의 개수
			
			// 시작 페이지 설정
			if(currentPage % 10 != 0) {
				startPage = (currentPage/10) * 10 + 1;
			} else {
				startPage = (currentPage/10-1) * 10 + 1;
			}
			
			// 끝 페이지 설정
			int endPage = startPage + pageBlock -1;
			
			// 끝 페이지가 전체 페이지 수보다 크다면 끝 페이지를 전체 페이지 수로 설정
			if(endPage > pageCount) endPage = pageCount;
			
			// 처음 페이지 처리
			if(startPage > 10) {
				out.println("<a href='listBoard.jsp?pageNum=1'><div class='pbox'><img src='../icons/left2.png' class='arrow' width='15px' height='15px' style='bold' title='처음 페이지'></div></a>");
				//out.println("<a href='listBoard.jsp?pageNum=1'><div class='pbox' title='처음 페이지' style='bold'>&lt;&lt;</div></a>");
			}
			
			// 이전 페이지 블럭 처리
			if(startPage > 10) {
				//out.println("<a href='listBoard.jsp?pageNum=" + (startPage - pageBlock) + "'><div class='pbox'>&lt</div></a>");
				out.println("<a href='listBoard.jsp?pageNum=" + (startPage - pageBlock) + "'><div class='pbox'><img src='../icons/left1.png' class='arrow' width='15px' height='15px' class='ibox' title='10페이지 이전'></div></a>");
				//out.println("<a href='listBoard.jsp?pageNum=" + (startPage - pageBlock) + "'><div class='pbox' title='10페이지 이전' style='bold'>&lt;</div></a>");
			}
			
			// 페이지 블럭 처리
			for(int i=startPage; i<=endPage; i++) {
				
				if(i == currentPage) { // i가 현재 페이지라면 이동할 필요가 없음
					out.println("<div class='pbox cbox'>" + i + "</div>");
				} else { // i가 현재 페이지와 같지 않다면 이동함.
					out.println("<a href='listBoard.jsp?pageNum=" + i + "'><div class='pbox'>" + i + "</div></a>");
				}
				
			}
			
			// 다음 페이지 블럭 처리
			if(endPage < pageCount) {
				//out.println("<a href='listBoard.jsp?pageNum=" + (startPage + pageBlock) + "'><div class='pbox'>&gt</div></a>");
				out.println("<a href='listBoard.jsp?pageNum=" + (startPage + pageBlock) + "'><div class='pbox'><img src='../icons/right1.png' class='arrow' width='15px' height='15px' class='ibox' title='10페이지 다음'></div></a>");
				//out.println("<a href='listBoard.jsp?pageNum=" + (startPage + pageBlock) + "'><div class='pbox' title='10페이지 다음' style='bold'>&gt;</div></a>");
			}
			
			// 마지막 페이지 처리
			if(endPage < pageCount) {
				out.println("<a href='listBoard.jsp?pageNum=" + pageCount + "'><div class='pbox'><img src='../icons/right2.png' class='arrow' width='15px' height='15px' class='ibox' title='마지막 페이지'></div></a>");
				//out.println("<a href='listBoard.jsp?pageNum=" + pageCount + "'><div class='pbox' title='마지막 페이지' style='bold'>&gt;&gt;</div></a>");
				
			}
		}
	
	%>

	
	</div>
</div>
</body>
</html>