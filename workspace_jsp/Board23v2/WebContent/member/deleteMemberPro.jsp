<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 삭제(탈퇴) 처리</title>
</head>
<body>
<%
	// 아이디 세션값 획득
	String id = (String)session.getAttribute("id");
	
	// 비밀번호 리퀘스트값 획득
	String pwd = request.getParameter("pwd");
	
	//DB 연결, 처리
	MemberDBBean dbPro = MemberDBBean.getInstance();
	int check = dbPro.deleteMember(id, pwd);
	
	// 이동
	// check가 1이면 삭제 성공 -> 아이디 세션 삭제, 로그온 페이지로 성공
	// check가 0이면 삭제 실패 -> 실패 메시지, 이전 화면 돌아감
	
	if(check == 1) {
		session.removeAttribute("id");
		response.sendRedirect("logonForm.jsp");
	} else {
		out.print("<script>alert('회원 탈퇴에 실패하였습니다.');histroy.back();</script>");
	}
	
%>

<%--	
<script>
	
	// 탈퇴(삭제) 여부 확인 메세지
	let isDelete = confirm("정말 탈퇴하시겠습니까?");
	//Console.log("isDelete : " + isDelete);
	
	if(!isDelete) { // 탈퇴하지 않음
		location = 'infoMember.jsp';
		//history.back();
	}
	
</script>
 --%>

<script>
	let yn = confirm("정말 탈퇴하시겠습니까?");
</script> 

<%--
	boolean isDelete = Boolean.parseBoolean(("<script>confirm(정말 탈퇴하겠습니까?);</script>"));
	if(isDelete) {
		//DB 연결, 처리
		MemberDBBean dbPro = MemberDBBean.getInstance();
		int check = dbPro.deleteMember(id, pwd);
		
		// 이동
		// check가 1이면 삭제 성공 -> 아이디 세션 삭제, 로그온 페이지로 성공
		// check가 0이면 삭제 실패 -> 실패 메시지, 이전 화면 돌아감
		
		if(check == 1) {
			session.removeAttribute("id");
			out.print("<script>location-'logonForm.jsp';</script>");
			//response.sendRedirect("logonForm.jsp");
		} else {
			out.print("<script>alert('회원 탈퇴에 실패하였습니다.');histroy.back();</script>");
		}
	} else {
		out.print("<script>history.back();</script>");
	}
--%>


</body>
</html>