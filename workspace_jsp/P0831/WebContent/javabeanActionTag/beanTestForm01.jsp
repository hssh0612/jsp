<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>beanTestForm01</title>
</head>
<%--
< 자바빈 (JavaBean) >
 - JSP에서 사용하는 자바의 클래스
 
< 자바빈의 생성 규칙 >
 1. 클래스는 public으로 선언
 2. 멤버변수는 private으로 선언
 3. 객체의 멤버변수에 접근할 때는 public으로 선언된 getter/setter 메소드를 이용
 4. 생성자는 디폴트 생성자를 사용
 
< 자바빈을 사용하는 액션 태그 >
 1. useBean : 클래스에 대한 객체를 생성
 2. setProperty : 객체의 멤버변수에 request로 넘어오는 값을 설정
 3. getProperty : 객체에 설정된 멤버변수의 값을 출력
 --%>
<body>
	<h2> 정보 입력 폼 </h2>
	<form action="beanTestPro01.jsp" method="post">
		아이디 : <input type="text" name= "id"><br>
		패스워드 : <input type="password" name= "pwd"><br>
		<input type="submit" value= "입력 완료">
	</form>
</body>
</html>