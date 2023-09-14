<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bean.Member" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberPro</title>
<style>
	table { width : 500px; border : 1px solid black; border-collapse : collapse;}
	tr { height : 40px;}
	th { width : 30%;}
	td { width : 80%;}
	th, td { border : 1px solid black;}
</style>
</head>
<body>
	<h2>멤버 정보 처리 페이지</h2>
	<% request.setCharacterEncoding("utf-8"); %>
	
	<%-- 1번
	<jsp:useBean id="member" class="bean.Member" />
	<jsp:setProperty property="*" name="member" />
	--%>

	<%-- 2번 --%>	

	<jsp:useBean id="member" class="bean.Member" />
	<jsp:setProperty property="id" name="member" />
	<jsp:setProperty property="userpass" name="member" />
	<jsp:setProperty property="username" name="member" />
	<jsp:setProperty property="age" name="member" />
	<jsp:setProperty property="birthday" name="member" />
	<jsp:setProperty property="email" name="member" />
	<jsp:setProperty property="address" name="member" />
	<jsp:setProperty property="job" name="member" />
	<jsp:setProperty property="tel" name="member" />
	<jsp:setProperty property="hobby" name="member" />

	 
	
	<%-- 3번 --%>
	<%--
	<%
		Member member = new Member();
		
		String id = request.getParameter("id");
		String userpass = request.getParameter("userpass");
		String username = request.getParameter("username");
		int age = Integer.parseInt(request.getParameter("age"));
		String birthday = request.getParameter("birthday");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String job = request.getParameter("job");
		String tel = request.getParameter("tel");
		String hobby = request.getParameter("hobby");
		
		member.setId(id);
		member.setUserpass(userpass);
		member.setUsername(username);
		member.setAge(age);
		member.setBirthday(birthday);
		member.setEmail(email);
		member.setAddress(address);
		member.setJob(job);
		member.setTel(tel);
		member.setHobby(hobby);
		
	%>
	 --%>
	<table>
		<tr><th colspan="2">회원 정보</th></tr>
		<tr>
			<th>아이디</th>
			<%-- <td><jsp:getProperty property="id" name= "member" /></td>--%>
			<td><%=member.getId() %></td>
		</tr>
		<tr>
			<th>패스워드</th>
			<%-- <td><jsp:getProperty property="userpass" name= "member" /></td>--%>
			<td><%=member.getUserpass() %></td>
		</tr>
		<tr>
			<th>회원 이름</th>
			<%-- <td><jsp:getProperty property="username" name= "member" /></td>--%>
			<td><%=member.getUsername() %></td>
		</tr>
		<tr>
			<th>나이</th>
			<%-- <td><jsp:getProperty property="age" name= "member" /></td>--%>
			<td><%=member.getAge() %></td>
		</tr>
		<tr>
			<th>생일</th>
			<%-- <td><jsp:getProperty property="birthday" name= "member" /></td>--%>
			<td><%=member.getBirthday() %></td>
		</tr>
		<tr>
			<th>이메일</th>
			<%-- <td><jsp:getProperty property="email" name= "member" /></td>--%>
			<td><%=member.getEmail() %></td>
		</tr>
		<tr>
			<th>주소</th>
			<%-- <td><jsp:getProperty property="address" name= "member" /></td>--%>
			<td><%=member.getAddress() %></td>
		</tr>
		<tr>
			<th>직업</th>
			<%-- <td><jsp:getProperty property="job" name= "member" /></td>--%>
			<td><%=member.getJob() %></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<%-- <td><jsp:getProperty property="tel" name= "member" /></td>--%>
			<td><%=member.getTel() %></td>
		</tr>
		<tr>
			<th>취미</th>
			<%-- <td><jsp:getProperty property="hobby" name= "member" /></td>--%>
			<td><%=member.getHobby() %></td>
		</tr>

		
	</table>
</body>
</html>