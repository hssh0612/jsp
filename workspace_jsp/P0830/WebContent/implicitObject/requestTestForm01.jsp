<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>requestTestForm01</title>
</head>
<%--
< 내장 객체(Implicit Object) >
 - JSP에서 사용할 수 있도록 미리 생성해 놓은 객체
 - 객체의 생성없이 객체 이름으로 바로 사용이 가능
 
< 내장 객체의 종류 >
 1. request ★
 	- 웹브라우저의 요청을 처리하는 객체
 2. response ★
 	- 웹브라우저의 요청에 대한 응답 정보를 저장하는 객체 
 3. session ★
 	- 세션 정보를 저장하는 객체
 4. out ★
 	- 출력을 처리하는 객체
 5. application
 	- 웹 애플리케이션의 정보를 저장하는 객체
 6. pageContext
 	- JSP 페이지의 정보를 저장하는 객체
 7. page
 	- JSP 페이지에서 구현한 자바 클래스 객체
 8. config
 	- JSP 페이지의 설정 정보를 저장하는 객체
 9. exception
 	- JSP 페이지에서 예외가 발생했을 때 사용하는 객체, 
 	- page directive 속성 중에서 errorPage, isErrorPage와 관련하여 사용함.
 	- page directive의 errorPage, isErrorPage 속성을 사용하지 않으므로, exception 내장 객체도 사용하지 않음.
 	
 	
# page, config, exception 내장객체는 거의 사용하지 않음.

< 영역 내장 객체 >
 - 객체가 실행되는 영역(범위)을 가지는 4가지 내장 객체
 - pageContext < request < session < application (영역의 크기)
 1. pageContext 영역 : 하나의 페이지에서만 객체를 공유
 2. request 영역 : 요청에 대한 응답이 있을 때까지 객체를 공유
 	- ex) 폼에서 입력한 값을 처리 페이지를 통해서 처리하는 경우
 3. session 영역 : 세션이 만료될 때까지 객체를 공유
 	- ex) 로그인, 장바구니, 주문결제...
 4. application 영역 : 애플리케이션이 실행되는 동안 객체를 공유
 	- ex) 애플리케이션에서 모두 공유하는 변수, 방문자수를 카운팅
 	
 	
 	
 < 1. request 내장객체>
  - 웹브라우저의 요청을 처리하는 객체
  - setCharacterEncoding() : 인코딩 방식을 설정하는 메소드, post 방식으로 데이터를 전달할 때 한글이 깨지는 문제를 해결.
  - getParameter() : 페이지에서 전달되는 1개의 값을 저장하는 메소드. String 타입으로 전달 받음.
  - getParameterValues() : 페이지에서 전달되는 1개 이상의 값을 저장하는 메소드, checkbox와 select(multiple)의 경우에 사용, String[]로 전달 받음.
  - getParameterNames() : 페이지의 요청에 의해서 넘어오는 모든 파라미터 이름
  
 --%>
 
<body>
	<h2>학번, 이름, 학년, 선택과목을 입력 폼</h2>
	<form action="requestTestPro01.jsp" method="get">
		학번 : <input type="text" name="num"><br>
		이름 : <input type="text" name="name"><br>
		학년 : 
			<input type="radio" name="grade" value="1"> 1학년&ensp;
			<input type="radio" name="grade" value="2"> 2학년&ensp;
			<input type="radio" name="grade" value="3"> 3학년&ensp;
			<input type="radio" name="grade" value="4"> 4학년&ensp;<br>
		선택과목 : 
			<select name="subject" multiple>
				<option>HTML/CSS</option>
				<option>Javascript</option>
				<option>JAVA</option>
				<option>ORACLE</option>
				<option>JSP</option>
				<option>Spring</option>
			</select><br>
			<input type="submit" value = "입력완료">
	</form>
</body>
</html>