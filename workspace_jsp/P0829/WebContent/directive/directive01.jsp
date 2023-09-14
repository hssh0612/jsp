<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="페이지 디렉티브 연습 페이지" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>directive 01번</title>
</head>
<%--
### JSP 문법 ###
 < directive(디렉티브) >
  - 지시어, 지시자
  - <%@ %> 형태로 사용
  - JSP 페이지가 실행될 때 필요한 여러가지 설정 정보를 기술하는데 사용
 
 < directive 종류 >
  1. page directive
  	- JSP 페이지에 관한 정보를 기술
  	- 언어, 문서의 타입, import할 클래스, 세션 및 버퍼의 사용 여부, 버퍼의 크기 등 
  	# page directive의 속성
  	 1) info - 페이지의 설명을 기술
  	 2) language - 사용하는 언어
  	 3) contentType - 생성하는 문서의 타입
  	 4) extends - 상속받을 클래스를 지정 ★★★
  	 5) import - 자바의 클래스를 사용할 때 지정, 자주 사용 ★★★★★
  	 6) session - 세션의 사용 여부, 기본값은 true
  	 7) buffer - 버퍼의 크기, 기본값은 8KB
  	 8) autoFlush - 버퍼의 내용을 처리, 기본값은 true
  	 9) isThreadSafe - 다중 쓰레드를 허용할지의 여부, 기본값은 true
  	 10) errorPage - 에러가 발생할 때, 처리하는 에러 페이지를 설정 -> 사용하지 않음
  	 11) isErrorPage - 해당 페이지가 에러 페이지로 지정할 것인지의 여부 설정 -> 사용하지 않음
  	 12) PageEncoding - 페이지의 문자 인코딩 방법
  	 13) isELIgnored - EL을 사용할지의 여부
  	
  	
  2. include directive
  	- 여러 페이지에서 공통적으로 사용하는 내용에 따로 정의해 놓고, 필요한 JSP 페이지에서 삽입하여 사용하는 기능을 제공
	
  3. taglib directive
  	- EL(Expression Language, 표현 언어), JSTL(JSP Standard Tag Library), 커스텀 태그(Custom Tag)를 JSP페이지 내에서 사용할 수 있도록 하는 기능

--%>
<body>
	<h2> directive 01번 - page directive </h2>
	<%=getServletInfo() %>
	<hr>
	<%
		Timestamp now = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
		String strDate = sdf.format(now);
	%>
	오늘은 <%=strDate %> 입니다.
	
	
</body>
</html>