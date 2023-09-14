<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>driverConnectionTest</title>
</head>
<%--
< JDBC 프로그래밍 >
  JDBC (Java DataBase Connection)
  
< JDBC 드라이버를 인식하는 방법 >
 1. JRE의 설치 경로에 lib폴더 안에 드라이버를 넣는다.
 	C:\Program Files\Java\jre-1.8\lib\ext 안에 드라이버를 넣는다.
 	-> 프로젝트 테스트 용으로 사용할 때
 	
 2. 해당 프로젝트의 WEB-INF\lib 안에 드라이버를 넣는다
 	-> 프로젝트를 고객이나 다른 사용자에게 전달할 때
 	
< JDBC 프로그래밍의 순서 >
 1. 드라이버 연결 - 프로그램의 드라이버와 실제 드라이버를 일치시키는 작업
 2. 커넥션 객체 획득 - DB의 url(경로), DB의 아이디, DB의 패스워드
 
 # 커넥션 객체 - 프로그램과 DB를 연결함.
 --%>
<body>
	<h2>DB 드라이버 연결 테스트</h2>
	<%
      // DB 연결 객체 생성
      Connection conn = null;
   
      // url, dbId, dbPwd -- mysql 데이터베이스를 연결하는 방법
      String url = "jdbc:mysql://localhost:3306/db01?useSSL=false";
      String dbId = "sol23";
      String dbPwd = "1234";
      
      try {
         // MySQL 드라이버 설정
         Class.forName("com.mysql.jdbc.Driver");   
         // MySQL 데이터베이스 연결
         conn = DriverManager.getConnection(url, dbId, dbPwd);
         
         out.println("정상적으로 연결되었습니다.");
      } catch(ClassNotFoundException e) {
         e.printStackTrace();
         out.println("드라이버가 연결되지 않았습니다.");
      } catch(SQLException e) {
         e.printStackTrace();
         out.println("데이터베이스와 연결이 되지 않았습니다.");
      }
      
   %>
</body>
</html>