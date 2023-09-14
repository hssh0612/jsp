<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>requestTestPro02</title>
<style>
   table { width: 500px; border: 1px solid black; border-collapse: collapse;}
   tr { height: 40px;}
   th, td { border: 1px solid black;}
   th { width: 100px;}
   td { width: 400px; padding-left: 10px;}
</style>
</head>
<body>
   <h2>회원 정보 처리 페이지</h2>
   <% 
   request.setCharacterEncoding("utf-8");
   
   String name = request.getParameter("name");
   String gender = request.getParameter("gender");
   String[] hobby = request.getParameterValues("hobby");
   %>

   <%-- 1번 --%>
   <table>
   <tr><th>이름</th><td><%=name %></td></tr>
   <tr><th>성별</th><td><%=gender %></td></tr>
   <tr><th>취미</th><td>
   <% for(int i=0; i<hobby.length; i++) {%>
      <%=hobby[i] %>, 
   <% } %>
   </td></tr>
   </table>
   
   <hr>
   <br>
   
   <%-- 2번 --%>
   <%
   out.println("<table><tr><th>이름</th><td>" + name + "</td></tr>");
   out.println("<tr><th>성별</th><td>" + gender + "</td></tr>");
   out.println("<tr><th>취미</th><td>");
   
   for(int i=0; i< hobby.length; i++) {
      out.println(hobby[i] + ", ");
   
   }
   out.println("</td></tr></table>");
   %>
   
</body>
</html>