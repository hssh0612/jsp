<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정 처리</title>
</head>
<body>
	<% request.setCharacterEncoding("utf-8"); %>
	<jsp:useBean id="member" class="member.MemberDataBean"/>
	<jsp:setProperty property="*" name="member"/>
	
	<%
		// 아이디 세션값 확인
		String id = (String)session.getAttribute("id");
	
		// member 객체에 추가
		member.setId(id);
		
		// 회원 정보 확인
		//System.out.println(member);
		
		// DB 연결, 처리
		MemberDBBean dbPro = MemberDBBean.getInstance();
		int check = dbPro.updateMember(member);
		
		// 이동
		// check가 1이면 수정 성공 -> 로그온 페이지로 성공
		// check가 0이면 수정 실패 -> 실패 메시지, 이전 페이지로 돌아감
		if(check == 1) {
			response.sendRedirect("logonForm.jsp");
		} else {
			out.print("<script>alert('회원정보 수정에 실패하였습니다.');history.back();</script>");
		}
		
		
		
		//
	
	%>
</body>
</html>