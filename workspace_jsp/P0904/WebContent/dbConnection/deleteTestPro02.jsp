<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteTestPro02</title>
</head>
<body>
	<h2>member 데이터 삭제 처리 페이지</h2>
	<%
		request.setCharacterEncoding("utf-8");
	
		// 폼에서 넘어오는 정보 획득
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		
		// 커넥션, DB 처리 변수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 커넥션과 DB 연결 변수 선언
		String url = "jdbc:mysql://localhost:3306/db01?useSSL=false";
		String dbId = "sol23";
		String dbPwd = "1234";
		
		// SQL문
		String sql1 = "select id, pwd from member where id = ? and pwd = ?";
		String sql2 = "delete from member where id = ?";
		
		try {
			// 1단계 - 드라이버 연결
			// 2단계 - 커넥션 객체 획득
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, dbId, dbPwd);
			
			// 3단계 - SQL문 실행
			// 4단계 - rs로 결과 획득
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			pstmt.close();
			
			// 5단계 - delete 처리
			if(rs.next()) { // 아이디와 패스워드가 모두 일치할때
					pstmt = conn.prepareStatement(sql2);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					out.println(id + "님의 정보가 삭제되었습니다.");

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