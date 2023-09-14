<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>switchTestPro02</title>
</head>
<body>
   <h2>지역 전화번호를 입력하는 폼</h2>
   <%
      request.setCharacterEncoding("utf-8");   
   
      String name = request.getParameter("name");
      String local = request.getParameter("local");
      String tel = request.getParameter("tel");
   %>
   <%-- 1번 방법 --%>
   <%--
   <%
   String locNum = "";
   switch(local) {
   case "서울": locNum = "02"; break;
   case "경기도": locNum = "031"; break;
   case "강원도": locNum = "033"; break;
   case "충청남도": locNum = "041"; break;
   case "대전": locNum = "042"; break;
   case "충청북도": locNum = "043"; break;
   case "세종": locNum = "044"; break;
   case "부산": locNum = "051"; break;
   case "울산": locNum = "052"; break;
   case "대구": locNum = "053"; break;
   case "경상북도": locNum = "054"; break;
   case "경상남도": locNum = "055"; break;
   case "전라남도": locNum = "061"; break;
   case "광주": locNum = "052"; break;
   case "전라북도": locNum = "053"; break;
   case "제주": locNum = "064"; break;
   }
   %>
   <%=name %>님의 지역전화번호는 <%=locNum %>-<%=tel %>입니다.
   --%>
   <%-- 2번 방법 --%>
   <%
   String locNum = "";
   switch(local) {
   case "서울": locNum = "02"; break;
   case "경기도": locNum = "031"; break;
   case "강원도": locNum = "033"; break;
   case "충청남도": locNum = "041"; break;
   case "대전": locNum = "042"; break;
   case "충청북도": locNum = "043"; break;
   case "세종": locNum = "044"; break;
   case "부산": locNum = "051"; break;
   case "울산": locNum = "052"; break;
   case "대구": locNum = "053"; break;
   case "경상북도": locNum = "054"; break;
   case "경상남도": locNum = "055"; break;
   case "전라남도": locNum = "061"; break;
   case "광주": locNum = "052"; break;
   case "전라북도": locNum = "053"; break;
   case "제주": locNum = "064"; break;
   }
   out.println(name +"님의 지역전화번호는 " + locNum + "-"+tel+"입니다.");
   %>
   <%-- 3번 방법 --%>
</body>
</html>