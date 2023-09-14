<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ifTestPro02</title>
</head>
<%--
< request 내장 객체 >
 - 요청에 대한 처리를 하는 내장 객체
 - getParameter() : 다른 페이지에 넘어오는 데이터를 처리하는 메소드
 - setCharacterEncoding() : post방식으로 넘어오는 데이터가 한글일 때 글자가 깨지는 문제를 해결하는 메소드
 
< out 내장 객체 >
 - 화면으로 출력하는 기능을 가진 내장 객체
 - println() : 화면으로 출력하는 메소드
 --%>
 
<body>
	<h2>이름과 나이 처리 페이지</h2>
	<%
		// post방식으로 한글을 처리할 때, 글자가 꺠지는 문제를 해결함.
		request.setCharacterEncoding("utf-8");
	
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		
		if(age <19) {
	%>
	<%--
			<%=name %>님은 <%=age %>세이므로, 소년에 속합니다.
	<% 	} else if(age >= 19 && age <= 34) { %>
			<%=name %>님은 <%=age %>세이므로, 청년에 속합니다.
	<% 	} else if(age >= 35 && age <= 49) { %>
			<%=name %>님은 <%=age %>세이므로, 중년에 속합니다.
	<% 	} else if(age >= 50 && age <= 64) { %>
			<%=name %>님은 <%=age %>세이므로, 장년에 속합니다.
	<%	} else if(age >= 65) { %>
			<%=name %>님은 <%=age %>세이므로, 노년에 속합니다.
	<%	} %>
	--%>
	
	<%-- 2번 방법 --%>
	<%
			out.println(name + "님은 " + age + "세이므로, 소년에 속합니다.");
		} else if(age >= 19 && age <= 34) {
			out.println(name + "님은 " + age + "세이므로, 청년에 속합니다.");
		} else if(age >= 35 && age <= 49) {
			out.println(name + "님은 " + age + "세이므로, 중년에 속합니다.");
		} else if(age >= 50 && age <= 64) {
			out.println(name + "님은 " + age + "세이므로, 장년에 속합니다.");
		} else if(age >= 65) {
			out.println(name + "님은 " + age + "세이므로, 노년에 속합니다.");
		}
	%>
</body>
</html>