<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test02번</title>
</head>
<!-- html 주석 -->
<%-- JSP 주석 --%>
<%--
 < 웹서버 프로그래밍 언어 >
  1) ASP (Active Server Page) 
  	- VBScript 언어를 사용(Visual Basic 언어가 기본)
  	- 플랫폼에 비독립적이라는 단점, 시스템의 효율성과 확장성이 부족
  2) PHP (Personal Hypertext Preprocessor)
  	- C 언어를 사용
  	- 확장성이 부족, 복잡한 시스템 구조에 대한 활용이 부족, 보안상의 문제점도 가짐.
  3) JSP (Java Server Page)
  	- Java 언어를 사용
  	- 플랫폼에 독립적, 시스템에 대한 효율성과 확장성이 좋음.
  	
 < 서블릿(Servlet)과 JSP >
  1. Servlet 
  	- 자바 언어 안에 웹언어를 포함하여 사용하는 방법
  	
  	- 장점 : 실행 속도가 빠름.
  	- 단점 : 코드 너무 길어짐, 유지보수가 어려움.
  	
  2. JSP 
  	- 웹언어 안에 자바 언어를 포함하여 사용하는 방법
  	
  	- 장점 : 코드가 간결
  	- 단점 : 자바 언어를 번역하는 시간이 있어 실행 속도가 느림.
  
 < 웹서버와 WAS >
  1. Web Server
  	- 웹을 구동하는 서버
  	
  2. WAS (Web Application Server)
  	- 각 프로그래밍 언어를 웹에서 사용할 수 있도록 번역하고, 실행하는 서버
  # 최근에는 WAS가 웹서버의 역할도 함.
  
 < WAS의 종류 >

  1. WebLogic(웹로직)
  2. Websphere(웹스피어)
  3. JBOSS(제이보스) -> 1등
  4. JEUS(제우스) -> 국산, 디맥스 소프트
  -> 상용
   
  5. Apache Tomcat -> 무료
--%>
<body>
	<h2>JSP 2번</h2>
	<hr>
	<%
		Calendar c = Calendar.getInstance();
		int hour = c.get(Calendar.HOUR_OF_DAY);
		int minute = c.get(Calendar.MINUTE);
		int second = c.get(Calendar.SECOND);
	%>
	<h1>현재시간은 <%=hour %>시 <%=minute %>분 <%=second %>초입니다.</h1>
</body>
</html>