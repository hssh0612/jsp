<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>requestTestPro01</title>
<style>
   table { width: 400px; border: 1px solid black; border-collapse: collapse;}
   tr { height: 40px;}
   th, td { border: 1px solid black;}
   th { width: 100px;}
   td { width: 300px; padding-left: 10px;}
</style>
</head>
<body>
   <h2>학생 정보 처리 페이지</h2>
   <%
   request.setCharacterEncoding("utf-8");
   
   String num = request.getParameter("num");
   String name = request.getParameter("name");
   String grade = request.getParameter("grade");
   String[] subject = request.getParameterValues("subject");
   %>
   <%-- 1번 --%>
   <table>
      <tr><th>학번</th><td><%=num %></td></tr>
      <tr><th>이름</th><td><%=name %></td></tr>
      <tr><th>학년</th><td><%=grade %></td></tr>
      <tr><th>선택과목</th><td>
      <% for(int i=0; i<subject.length; i++) {%>
         <%=subject[i] %>, 
      <% } %>
      </td></tr>
   </table>
   
   <hr>
   
   <%-- 2번 --%>
   
   <%
   out.println("<table>");
   out.println("<tr><th>학번</th><td>" + num + "</td></tr>");
   out.println("<tr><th>이름</th><td>" + name + "</td></tr>");
   out.println("<tr><th>학년</th><td>" + grade + "</td></tr>");
   out.println("<tr><th>선택과목</th><td>");
   for(int i=0; i<subject.length; i++) {
      out.println(subject[i] + ", ");
   }
   out.println("</td></tr>");
   out.println("</table>");
   %>
   <%-- 3번 --%>
   <hr>
   
   <table>
      <tr><th>학번</th><td><%=num %></td></tr>
      <tr><th>이름</th><td><%=name %></td></tr>
      <tr><th>학년</th><td><%=grade %></td></tr>
      <tr><th>선택과목</th><td><%=Arrays.toString(subject) %></td></tr>
   </table>
   
   <hr>
   
   <%-- 4번 --%>
   <%
   out.println("<table>");
   out.println("<tr><th>학번</th><td>" + num + "</td></tr>");
   out.println("<tr><th>이름</th><td>" + name + "</td></tr>");
   out.println("<tr><th>학년</th><td>" + grade + "</td></tr>");
   out.println("<tr><th>선택과목</th><td>" + Arrays.toString(subject) + "</td></tr>");
   out.println("</table>");
    %>
   
</body>
</html>