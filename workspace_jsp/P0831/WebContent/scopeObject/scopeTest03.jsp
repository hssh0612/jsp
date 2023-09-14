<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scopeTest03</title>
</head>
<style>
   table { width: 500px; border: 1px solid black; border-collapse: collapse;}
   tr { height: 40px;}
   th, td { border: 1px solid black;}
   th { width: 100px;}
   td { width: 400px;}
</style>
<body>
   <h2>영역 객체 처리 페이지 3번</h2>
   <%
   
	   // 모든 세션 무효화
	   //session.invalidate();
	   
	   // 각각 세션의 삭제
	   //session.removeAttribute("email");
	   //session.removeAttribute("addr");
	   //session.removeAttribute("tel");
	   
	   String email = (String)session.getAttribute("email");
	   String addr = (String)session.getAttribute("addr");
	   String tel = (String)session.getAttribute("tel");
	   
	   if(email == null) email ="";
	   if(addr == null) addr ="";
	   if(tel == null) tel = "";

   %>
   
   <table>
      <tr><th colspan="2">Application 영역에 저장한 값</th></tr>
      <tr>
         <th>이름</th>
         <td><%=application.getAttribute("name") %></td>
      </tr>
      <tr>
         <th>아이디</th>
         <td><%=application.getAttribute("id") %></td>
      </tr>
      <tr><th colspan="2">session 영역에 저장한 값</th></tr>
      <tr>
         <th>이메일</th>
         <td><%=email %></td>
      </tr>
      <tr>
         <th>주소</th>
         <td><%=addr %></td>
      </tr>
      <tr>
         <th>전화번호</th>
         <td><%=tel %></td>
      </tr>
   </table>
</body>
</html>