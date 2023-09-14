<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>usePool</title>
<style>
	table { width : 600px; border : 1px solid black; border-collapse : collapse; }
	tr { height : 40px;}
	th, td { border : 1px solid black; text-align : center;}
	tr td:nth(1),tr td:nth(2),tr td:nth(3),tr td:nth(4),tr td:nth(5),
	tr td:nth-child(5) { width : 200px;}
</style>
</head>
<%--
< Connection pool (커넥션 풀) >
 - 한꺼번에 DB에 접속하는 사용자가 많아져도 서버를 안정적으로 사용하기 위한 방법
 - 일정한 개수의 커넥션을 물에 담아두고 사용자가 가져다가 사용하고, 자동으로 반납하는 방법
 - 정해진 개수의 커넥션을 모두 사용중이라면 다음 사용자는 커넥션을 반납할 때까지 대기하는 방법
 

 --%>
<body>
	<h2>Connection Pool을 사용한 DB 연결</h2>
	<h3>member 테이블 모든 정보 확인</h3>
	<%
		// 커넥션, DB 처리를 위한 객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// SQL
		String sql = "select * from member";
		
		try {
			// DBCP를 활용한 커넥션 획득
			// 1단계, 2단계
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource)envCtx.lookup("jdbc/db01");
			conn = ds.getConnection();
			
			// 3단계, 4단계
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 5단계
			out.println("<table>");
			while(rs.next()) {
				String id = rs.getString("id");
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				int age = rs.getInt("age");
				Timestamp regDate = rs.getTimestamp("regDate");
				
				out.println("<tr>");
				out.println("<td>" + id + "</td>");
				out.println("<td>" + pwd + "</td>");
				out.println("<td>" + name + "</td>");
				out.println("<td>" + age + "</td>");
				out.println("<td>" + regDate + "</td>");
				out.println("</tr>");
				
			}
			out.println("</table>");
			
		} catch (Exception e) {
			e.printStackTrace();
			out.println("에러가 발생");
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	%>
</body>
</html>