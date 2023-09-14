<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectTest</title>
<style>
	table {width : 600px; border : 1px solid black; border-collapse : collapse;}
	tr { heigth : 40px;}
	th, td {border : 1px solid black; text-align: center;}

</style>
</head>
<body>
	<h2>member 테이블 조회 페이지</h2>
	<%
		// 커넥션 객체
		Connection conn = null;
		// SQL문 실행
		PreparedStatement pstmt = null;
		// 조회 결과 획득
		ResultSet rs = null;
		
		// 연결 정보
		String url = "jdbc:mysql://localhost:3306/db01?useSSL=false";
		String dbId = "sol23";
		String dbPwd = "1234";
		String sql = "select * from member";
		
		try {
			 // 1단계 : 드라이버 연결
	         Class.forName("com.mysql.jdbc.Driver");   
			 
			 // 2단계 : 커넥션 객체 획득
	         conn = DriverManager.getConnection(url, dbId, dbPwd);
	         
			 //	3단계 : SQL문 실행
			 pstmt = conn.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			 
			 // 4단계 : ResultSet 객체를 사용
			 out.println("<table>");
			 out.println("<tr><th>아이디</th><th>패스워드</th><th>이름</th><th>나이</th><th>등록일</th></tr>");
			 while(rs.next()) {
				 // 회원 정보 획득
				 String id = rs.getString(1);
				 String pwd = rs.getString(2);
				 String name = rs.getString(3);
				 int age = rs.getInt(4);
				 Timestamp regDate = rs.getTimestamp(5);
				 
				 // 화면에 출력
				 out.println("<tr>");
				 out.println("<td width='100px'>" + id + "</td>");
				 out.println("<td width='100px'>" + pwd + "</td>");
				 out.println("<td width='100px'>" + name + "</td>");
				 out.println("<td width='100px'>" + age+ "</td>");
				 out.println("<td width='100px'>" + regDate + "</td>");
			 }
			 
			 out.println("</table>");
	      } catch(ClassNotFoundException e) {
	         e.printStackTrace();
	         System.out.println("드라이버가 연결되지 않았습니다.");
	      } catch(SQLException e) {
	         e.printStackTrace();
	         System.out.println("SQL문에 오류가 발생했습니다.");
	      } finally {
	    	  	// 연결 객체 해제
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