<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "manager.product.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<style>
#container { width : 1200px; margin : 20px auto; font-size : 0.8em;}
h3 { text-align : center; font-size : 1.5em;}
/* 상단 */
.top1>.t1 { float : left;}
.top1>.t1>b { color : #99424f; display : inline-block; width : 40px; text-align : right;}
.top1>.t2, .top1>.t3 { float : right;}
.top1 a { text-decoration : none; color : #59637f; font-weight : 700; margin-left : 45px;}
.top1 a:hover { color : #c84557; text-decoration : underline;}
.clear { clear : both;}

.top2 { margin-top : 10px; margin-bottom : 40px;}
.top2>.t1> #btnDelete { float : left; background : #c84557; color : #fff; border : none; border-radius : 5px;
		width : 60px; height : 25px; font-size : 13px; cursor : pointer;}

.top2>.t2 { float : left; margin-left : 130px;}
.top2>.t2>select { width : 150px;}

.top2>.t3 { float : right;}
.top2>.t3>a { text-decoration : none; color : #1e94be; font-weight : 700;}
.top2>.t3>a:hover { color : #c84557; text-decoration : underline;}	

/* 상품 목록 테이블 */
table { width : 100%; border : 1px solid black; border-collapse : collapse;}
tr { height : 30px;}
th, td { border : 1px solid black;}
th { background : #e9ecef;}
tr a { text-decoration : none; color : #495057; font-weight : 700;}
tr a:hover { text-decoration : underline; color : #c84557;}
.lbl_check{ paddiong_bottom : 10px;}
.center { text-align : center;}
.left { text-align : left; padding-left : 5px;}
.right { text-align : right; padding-right : 5px;}


/* 페이징 영역 */
#paging { margin-top : 20px; text-align : center; font-weight : 700;}
.pbox { display : inline-block; width : 22px; height : 22px; border-radius : 50%;
	margin: 0 5px; padding : 5px; background : #fff; color : #1e94be; text-align : center; }
.pbox:hover { background : #1e94be; color : #fff;}
.cbox { background :#1e94be; color : #fff; font-weight : 700;}
.arrow {width : 10px; height :10px;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		
		// 페이지번호(pageNum), 상품 분류(kind)
		let pageNum = document.getElementById("pageNum");
		let kind = document.getElementById("kind");
	
		// 상품 분류 - select 태그
		let product_kind = document.getElementById("product_kind");
		product_kind.addEventListener("change", function() {
			location = "productList.jsp?kind=" + product_kind.value;
		})
		
		/*
		// 체크박스 선택 또는 해제 처리
		let idList = [];
		let p_check = document.getElementsByName("p_check"); // 배열
		console.log(p_check);

		for(let i of p_check) {
			i.addEventListener("change", function(e) {
				
				if(e.currentTarget.checked) { // 체크했을 때 -> 배열에 추가
					idList.push(i.value);
				} else { // 해제했을 때 -> 배열에서 삭제
					idList.splice(idList.indexOf(i.value), 1);
				}
				console.log(idList);
			})
		}
		*/
		
		// 체크박스 선택 또는 해제 처리 -> Set 사용 :  중복을 허용하지 않음.
		let idSet = new Set();
		let p_check = document.getElementsByName("p_check"); // 배열
		console.log(p_check);
		
		for(let i of p_check) {
			i.addEventListener("change", function(e) {
				
				if(e.currentTarget.checked) { // 체크했을 때 -> 배열에 추가
					idSet.push(i.value);
				} else { // 해제했을 때 -> 배열에서 삭제
					idSet.delete(i.value);
				}
				console.log(idSet);
			})
		}
		/*
		// 전체 선택 또는 해제 체크박스 처리
		let p_check_all = document.getElementById("p_check_all");
		p_check_all.addEventListener("change", function(e) {
			if(e.currentTarget.checked) { // 체크되었을 때
				for(let i of p_check) {
					i.checked = true;
					idList.push(i.value);
				}
			} else { // 해제되었을 때 
				for(let i of p_check) {
					i.checked = false;
					idList.splice(idList.indexOf(i.value), 1);
				}
			}
			console.log(idList);
		})
		*/
		
		// 전체 선택 또는 해제 체크박스 처리 -> Set 사용
		let p_check_all = document.getElementById("p_check_all");
		p_check_all.addEventListener("change", function(e) {
			if(e.currentTarget.checked) { // 체크되었을 때
				for(let i of p_check) {
					i.checked = true;
					idSet.push(i.value);
				}
			} else { // 해제되었을 때 
				for(let i of p_check) {
					i.checked = false;
					idSet.delete(i.value);
				}
			}
			console.log(idSet);
		})
		
		// 삭제 버튼 처리
		let btnDelete = document.getElementById("btnDelete");
	    btnDelete.addEventListener("click", function() {
	    	if(idSet.size == 0) {
	    		alert("삭제할 상품을 체크하세요.")
	    		return;
	    	}
	    	
	    	// 셋을 배열로 변경
	    	let idSet = new Array();
	    	for(let i of idList) {
	    		idList.push(i);
	    	}
	    	
	    	let isDeleted = confirm(idSet.size + "개의 상품을 삭제하겠습니까?");
	    	if(!isDeleted) return;
	    	location = "productDeletePro.jsp?idList=" + idList + "&pageNum=" + pageNum.value + "&kind=" + kind.value;
	    })
	})
</script>
</head>
<body>
<%
	// 관리자 아이디 세션 획득
	String managerId = (String)session.getAttribute("managerId");
	
	// 관리자 아이디 세션이 없을 때
	if(managerId == null) response.sendRedirect("../managerLogin/managerLoginForm.jsp");
	
	// 페이징(paging) 처리
	int pageSize = 10; // 1페이지에 보여줄 건수, 10건
	String pageNum = request.getParameter("pageNum"); // 페이지번호 획득
	
	if(pageNum == null) pageNum = "1"; // 페이지 번호가 없을 때 pageNum을 1페이지 설정
	
	int currentPage = Integer.parseInt(pageNum.trim()); // 현재 페이지 <- 페이지번호
	int startRow = (currentPage - 1) * pageSize + 1; // 현재 페이지에서 보여줄 첫번째 행
	int endRow = currentPage * pageSize; // 현재 페이지에서 보여줄 마지막 행
	
	// 전체 목록 또는 상품 분류별 목록
	// 000 -> 전체 목록
	String kind = request.getParameter("kind");
	if(kind == null) kind = "000";
	
	// DB 연결, 상품 목록 처리
	ProductDAO productPro = ProductDAO.getInstance();
	List<ProductVO> productList = null;
	
	// 전체 상품 개수 또는 분류별 상품 개수
	int count = 0;
	
	
	if(kind.equals("000")) { // 전체 목록
		productList = productPro.getProductAll(startRow, pageSize);
		count = productPro.getProductCount();
	} else { // 상품 분류별 목록
		productList = productPro.getProductKind(kind, startRow, pageSize);
		count = productPro.getProductKindCount(kind);
	}
		
	// 번호를 해당 페이지 번호
	int tCount = count - ((currentPage-1) * pageSize);
	
	// 상품 분류 처리
	String[] p_k = {"100", "110", "200", "210", "220", "230", "240", "250", "300", "310", "320", "330",
			"400", "410", "420", "500", "510", "520", "530", "600", "610", "700", "710", "720"};
	
	String[] p_v = {"소설/시", "에세이", "인문", "역사", "예술", "종교", "사회", "과학", "경제/경영", "자기계발", "여행", "잡지",
			"어린이", "유아", "청소년", "요리", "육아", "가정/살림", "건강/취미", "국어", "외국어", "수험서", "자격증", "초등참고서"};
	
	
	// 날짜, 숫자 처리
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("#,###.##");
	
%>
<div id="container">
	<h3>상품 목록</h3>
	<input type="hidden" id="pageNum" value="<%=pageNum %>">
	<input type="hidden" id="kind" value="<%=kind %>">
	<div class="top1">
		<div></div>
		<div class="t1">상품수 : <b><%=count %></b>개</div>
		<div class="t2"><a href="../managerLogin/managerLogout.jsp">로그아웃</a></div>
		<div class="t3"><a href=""><%=managerId %>관리자님</a></div>
	</div>
	<div class="clear"></div>
	<div class="top2">
		<div class="t1"><input type="button" value="삭제" id="btnDelete"></div>
		<div class="t2">
			<select name ="product_kind" id="product_kind">
				<option value="000" <%if(kind.equals("000")) { %> selected <%} %>>전체 상품</option>
				<option value="100" <%if(kind.equals("100")) { %> selected <%} %>>소설/시</option>
				<option value="110" <%if(kind.equals("110")) { %> selected <%} %>>에세이</option>
				<option value="200" <%if(kind.equals("200")) { %> selected <%} %>>인문</option>
				<option value="210" <%if(kind.equals("210")) { %> selected <%} %>>역사</option>
				<option value="220" <%if(kind.equals("220")) { %> selected <%} %>>예술</option>
				<option value="230" <%if(kind.equals("230")) { %> selected <%} %>>종교</option>
				<option value="240" <%if(kind.equals("240")) { %> selected <%} %>>사회</option>
				<option value="250" <%if(kind.equals("250")) { %> selected <%} %>>과학</option>
				<option value="300" <%if(kind.equals("300")) { %> selected <%} %>>경제/경영</option>
				<option value="310" <%if(kind.equals("310")) { %> selected <%} %>>자기계발</option>
				<option value="320" <%if(kind.equals("320")) { %> selected <%} %>>여행</option>
				<option value="330" <%if(kind.equals("330")) { %> selected <%} %>>잡지</option>
				<option value="400" <%if(kind.equals("400")) { %> selected <%} %>>어린이</option>
				<option value="410" <%if(kind.equals("410")) { %> selected <%} %>>유아</option>
				<option value="420" <%if(kind.equals("420")) { %> selected <%} %>>청소년</option>
				<option value="500" <%if(kind.equals("500")) { %> selected <%} %>>요리</option>
				<option value="510" <%if(kind.equals("510")) { %> selected <%} %>>육아</option>
				<option value="520" <%if(kind.equals("520")) { %> selected <%} %>>가정/살림</option>
				<option value="530" <%if(kind.equals("530")) { %> selected <%} %>>건강/취미</option>
				<option value="600" <%if(kind.equals("600")) { %> selected <%} %>>국어</option>
				<option value="610" <%if(kind.equals("610")) { %> selected <%} %>>외국어</option>
				<option value="700" <%if(kind.equals("700")) { %> selected <%} %>>수험서</option>
				<option value="710" <%if(kind.equals("710")) { %> selected <%} %>>자격증</option>
				<option value="720" <%if(kind.equals("720")) { %> selected <%} %>>초등참고서</option>
			</select>
		</div>
		<div class="t3"><a href="productInsertForm.jsp?kind=<%=kind %>">상품등록</a></div>
	</div>
	<div class="clear"></div>
	<table>
		<tr>
			<th width="5%"><input type="checkbox" id="p_check_all"><label for="p_check_all" class="lbl_check">전체</label></th>
			<th width="4%">번호</th>
			<th width="7%">상품 분류</th>
			<th width="22%">상품 이름</th>
			<th width="7%">상품 이미지</th>
			<th width="6%">가격</th>
			<th width="5%">수량</th>
			<th width="14%">저자</th>
			<th width="10%">출판사</th>
			<th width="8%">출판일</th>
			<th width="4%">할인율</th>
			<th width="8%">등록일</th>
		</tr>
		<% if(count == 0) { // 등록된 상품이 없을 때 
			out.print("<tr><td colspan='11' class='center'>등록된 상품이 없습니다.</td></tr>");	
		 } else { // 등록된 상품이 있을 때
				for(ProductVO product : productList) {
					int product_id = product.getProduct_id();
					// 상품 종류 변경 : ex) 100 -> 소셜/시
					String product_kind = product.getProduct_kind();
					String p_kind = null;
					for(int i = 0 ; i < p_k.length ; i++) {
						if(p_k[i].equals(product_kind)) p_kind = p_v[i];
					}
				
		 
		%>
		<tr>
			<td class="center"><input type="checkbox" name="p_check" value="<%=product_id %>"></td>
			<td class="center"><%=tCount-- %></td>
			<td class="center">
				<a href="productList.jsp?kind=<%=product_kind %>"><%=p_kind %></a>
			</td>
			<td class="left">
				<a href="productContent.jsp?product_id=<%=product_id %>&pageNum=<%=pageNum%>&kind=<%=kind %>"><%=product.getProduct_name() %></a>
			</td>
			<td class="center">
				<a href="productContent.jsp?product_id=<%=product_id %>&pageNum=<%=pageNum%>&kind=<%=kind %>"><img src="/imageFile/<%=product.getProduct_image() %>" width = "50" height="80"></a>
			</td>
			<td class="right"><%=df.format(product.getProduct_price()) %> 원</td>
			<td class="right"><%=df.format(product.getProduct_count()) %> 개</td>
			<td class="left"><%=product.getAuthor() %></td>
			<td class="left"><%=product.getPublishing_com() %></td>
			<td class="center"><%=product.getPublishing_date() %></td>
			<td class="right"><%=product.getDiscount_rate() %>%</td>
			<td class="center"><%=sdf.format(product.getReg_date()) %></td>
		</tr>
		<% } } %>
	</table>
	<%-- 페이징 처리 --%>
	<div id="paging">
	<%
		if(count > 0) {
			
			// 전체 페이지 수
			// 예를 들어, 개수가 265건, 페이지사이즈가 10이라면 27개의 페이지 생성 
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
				out.println("<a href='productList.jsp?pageNum=1&kind=" + kind + "'><div class='pbox'><img src='../../icons/left2.png' class='arrow' width='15px' height='15px' style='bold' title='처음 페이지'></div></a>");
				//out.println("<a href='productList.jsp?pageNum=1'><div class='pbox' title='처음 페이지' style='bold'>&lt;&lt;</div></a>");
			}
			
			// 이전 페이지 블럭 처리
			if(startPage > 10) {
				//out.println("<a href='productList.jsp?pageNum=" + (startPage - pageBlock) + "'><div class='pbox'>&lt</div></a>");
				out.println("<a href='productList.jsp?pageNum=" + (startPage - pageBlock) + "&kind=" + kind + "'><div class='pbox'><img src='../../icons/left1.png' class='arrow' width='15px' height='15px' class='ibox' title='10페이지 이전'></div></a>");
				//out.println("<a href='productList.jsp?pageNum=" + (startPage - pageBlock) + "'><div class='pbox' title='10페이지 이전' style='bold'>&lt;</div></a>");
			}
			
			// 페이지 블럭 처리
			for(int i=startPage; i<=endPage; i++) {
				
				if(i == currentPage) { // i가 현재 페이지라면 이동할 필요가 없음
					out.println("<div class='pbox cbox'>" + i + "</div>");
				} else { // i가 현재 페이지와 같지 않다면 이동함.
					out.println("<a href='productList.jsp?pageNum=" + i + "&kind="+ kind + "'><div class='pbox'>" + i + "</div></a>");
				}
				
			}
			
			// 다음 페이지 블럭 처리
			if(endPage < pageCount) {
				//out.println("<a href='productList.jsp?pageNum=" + (startPage + pageBlock) + "'><div class='pbox'>&gt</div></a>");
				out.println("<a href='productList.jsp?pageNum=" + (startPage + pageBlock) + "&kind=" + kind + "'><div class='pbox'><img src='../../icons/right1.png' class='arrow' width='15px' height='15px' class='ibox' title='10페이지 다음'></div></a>");
				//out.println("<a href='productList.jsp?pageNum=" + (startPage + pageBlock) + "'><div class='pbox' title='10페이지 다음' style='bold'>&gt;</div></a>");
			}
			
			// 마지막 페이지 처리
			if(endPage < pageCount) {
				out.println("<a href='productList.jsp?pageNum=" + pageCount + "&kind=" + kind + "'><div class='pbox'><img src='../../icons/right2.png' class='arrow' width='15px' height='15px' class='ibox' title='마지막 페이지'></div></a>");
				//out.println("<a href='productList.jsp?pageNum=" + pageCount + "'><div class='pbox' title='마지막 페이지' style='bold'>&gt;&gt;</div></a>");
				
			}
		}
	
	%>

	
	</div>
	
</div>
</body>
</html>