<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>responseTest01</title>
</head>
<%--
< 2. response 내장객체 >
 - 웹브라우저의 요청에 대해 응답할 정보를 저장한 객체
 - 헤더 정보 입력 기능, 리다이렉트(redirect) 기능
 
< response 내장객체의 메소드 >
 - setHeader(name, value) : 헤더의 정보를 입력, 수정하는 메소드
 - setContentType() : 응답할 페이지의 contentType을 설정
 - sendRedirect() : 페이지를 이동하는 메소드, URL로 주어진 페이지로 제어가 이동함.
 
# 페이지를 이동하는 방법
 - redirect (리다이렉트) : 페이지가 제어가 이동하고, request와 response의 객체 제어권은 이동하지 않음.
 - forward (포워드) : 페이지의 이동은 물론이고, request와 response의 객체의 제어권도 이동하게 됨.

 --%>
<body>
   <h2>redirectTest01</h2>
   현재 페이지는 <b>redirectTest01.jsp</b>페이지 입니다.<br>
   
   <%
   response.sendRedirect("responseTest02.jsp");
   %>
   

	
</body>
</html>