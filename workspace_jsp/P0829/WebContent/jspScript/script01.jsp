<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선언문 01번 </title>
</head>
<%--
### JSP의 스크립트 3요소 ###
 - JSP에서 가장 많이 사용하는 3가지 중요한 문법
 - JSP 페이지 내에서 JAVA의 문법을 사용하기 위해서 사용하는 기능
 
  1. declaration (선언문)
  	- <%! %>의 형식
  	- 전역 변수, 메소드 선언
  	
  2. scriptlet (스크립틀릿)
  	- <% %>의 형식
  	- 일반적으로 사용되는 자바의 거의 모든 문법
  	
  3. expression (표현식)
  	- <%= %>의 형식
  	- 화면에 출력할 값, 변수, 메소드 호출, 클래스를 사용한 값을 출력
--%>
<body>
	<h2>선언문 01번</h2>
	
	<%-- 1. 선언문 --%>
	<%!
		String str = "Global Variable";
		
		String getStr() {
			return str;
		}
	%>
	
	<%-- 2. 스크립틀릿 --%>
	<%
		String str2 = "Local Variable";
	%>
	
	<%-- 3. 표현식 --%>
	전역 변수 : <%=getStr() %><br>
	지역 변수 : <%=str2 %><br>
	
</body>
</html>