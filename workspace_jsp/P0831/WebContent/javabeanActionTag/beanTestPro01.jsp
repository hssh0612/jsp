<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="bean.BeanTest" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>beanTestPro01</title>
<style>
	table { width : 300px; border : 1px solid black; border-collapse : collapse;}
	tr { height : 40px;}
	th { width : 20%;}
	td { width : 80%;}
	th, td { border : 1px solid black;}
</style>
</head>
<%--
1. useBean의 속성
 - 클래스에 대한 객체를 생성하는 액션 태그
 - id : 클래스의 인스턴스명 , class : 클래스의 이름(패키지명을 포함)
 - scope : 객체의 사용 영역, page, request, session, application, 생략하면 기본값 page

2. setProperty 속성
 - 생성된 객체의 멤버변수에 값을 설정하는 액션 태그
 - name : 클래스의 객체명(useBean의 id) , property : 클래스의 멤버변수명,
 - param : 폼의 name -> 멤버변수의 이름과 같으면 생략 가능
 - 클래스의 멤버변수명과 폼의 name이 다르다면 반드시 param을 사용해야함.
 - 클래스의 멤버변수명과 폼의 name의 개수와 이름이 모두 일치한다면 property를 한번만 적고, "*"를 사용할 수 있음.
 
3. getProperty 속성
 - 생성된 객체의 멤버변수의 값을 리턴하는 액션 태그
 - name : 클래스의 객체명(userBean의 id) , property : 클래스의 멤버변수명,


 --%>
<body>
	<h2> 정보 처리 페이지</h2>
	<%
		request.setCharacterEncoding("utf-8");
	
		//String id = request.getParameter("id");
		//String pwd = request.getParameter("pwd");
	%>
	
	<%-- 1번 : 정식 --%>
	<%-- 
	<jsp:useBean id="beanTest" class="bean.BeanTest" scope="page">
		<jsp:setProperty name="beanTest" property="id" />
		<jsp:setProperty name="beanTest" property="pwd"/>
	</jsp:useBean>
	--%>
	
	<%-- 2번 : 약식 --%>
	<%-- 
	<jsp:useBean id="beanTest" class="bean.BeanTest" scope="page">
		<jsp:setProperty name="beanTest" property="id" param="id" />
		<jsp:setProperty name="beanTest" property="pwd" param="pwd" />
	</jsp:useBean>
	--%>
	
	<%-- 3번 : 정식--%>
	<%--
	<jsp:useBean id="beanTest" class="bean.BeanTest" scope="page">
		<jsp:setProperty name="beanTest" property="*" />
	</jsp:useBean>
	--%>
	
	<%-- 4번 : 약식 --%>
	<%--
	<jsp:useBean id="beanTest" class="bean.BeanTest" scope="page"/>
	<jsp:setProperty name="beanTest" property="*" />
	--%>
	
	<% 
		BeanTest beanTest = new BeanTest();
	
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		
		beanTest.setId(id);
		beanTest.setPwd(pwd);
	%>
	
	<table>
		<tr><th colspan="2">사용자 정보 확인</th></tr>
		<tr>
			<th>아이디</th>
			<td><%=beanTest.getId() %></td> <%-- 주석처리된거 하려면 패스워드와 아이디 둘다 <tr></tr> 붙여줘야함 이줄과 밑에 비슷한쪾에 --%>
			<%-- <td><jsp:getProperty name="beanTest" property="id" /></td> --%>
		</tr>
		<tr>
			<th>패스워드</th>
			<td><%=beanTest.getPwd() %></td>
			<%-- <td><jsp:getProperty name="beanTest" property="pwd"/></td> --%>
		</tr>
	</table>
</body>
</html>