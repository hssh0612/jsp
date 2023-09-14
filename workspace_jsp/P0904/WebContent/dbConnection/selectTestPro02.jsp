<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectTestPro2</title>
</head>
<body>
   <h2>member 정보 조회 처리 페이지 (1명)</h2>
   <%
   request.setCharacterEncoding("utf-8");
   
   // 폼에서 넘어오는 정보 확인
   String id = request.getParameter("id");
   String pwd = request.getParameter("pwd");
   
   // 커넥션, DB처리 변수 선언
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   
   // DB 연결 변수 선언
   String url = "jdbc:mysql://location:3306/db01?useSSL=false";
   String dbId = "sol23";
   String dbPwd = "1234";
   
   // SQL
   String sql = "select * from member where id and pwd = ?";
   
   try {
      // 1단계 - 드라이버 연결 
      // 2단계 - 커넥션 획득
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(url, dbId, dbPwd);
      
      // 3단계 - sql문 실행
      // 4단계 - rs로 결과 획득
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, id);
      pstmt.setString(2, pwd);
      rs = pstmt.executeQuery();
      
      // 5단계 
      if(rs.next()) { // 아이디와 패스워드가 모두 일치할 때
         // 사용자 정보를 조회
         String rId = rs.getString("id");
         String rPwd = rs.getString("pwd");
         String name = rs.getString("name");
         int age = rs.getInt("age");
         Timestamp regDate = rs.getTimestamp("regDate");
            
         out.println("<table>");
         out.println("<tr><th colspan='2'>" + rId + "님의 정보</th></tr>");
         out.println("<tr><th>아이디</th><td>" + rId + "</td></tr>");
         out.println("<tr><th>패스워드</th><td>" + rPwd + "</td></tr>");
         out.println("<tr><th>이름</th><td>" + name + "</td></tr>");
         out.println("<tr><th>나이</th><td>" + age + "</td></tr>");
         out.println("<tr><th>등록일</th><td>" + regDate + "</td></tr>");
         out.println("</table>");
      } else { // 아이디 또는 패스워드가 일치하지 않을 때
         out.println("입력한 정보가 일치하지 않습니다.");         
      }
      
   } catch(Exception e) {
      e.printStackTrace();
      out.println("예외가 발생하였습니다.");
   } finally {
      if(rs != null) {
         try {
            rs.close();
         } catch(Exception e) {
            e.printStackTrace();
         }
      }
      if(pstmt != null) {
         try {
            pstmt.close();
         } catch(Exception e) {
            e.printStackTrace();
         }
      }
      if(conn != null) {
         try {
            conn.close();
         } catch(Exception e) {
            e.printStackTrace();
         }
      }
   }
   
   %>
</body>
</html>