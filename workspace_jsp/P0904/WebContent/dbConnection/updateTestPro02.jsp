<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateTestPro02</title>
</head>
<body>
	<h2>member 데이터 수정 처리 페이지02</h2>
	<%-- 아이디와 패스워드를 확인하여 이름과 나이를 수정 --%>
	<%
		request.setCharacterEncoding("utf-8");
	
		// 폼에서 넘어오는 정보 확인
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		
		// DB 처리 변수 선언
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 커넥션 객체에서 사용하는 변수 - url, dbId, dbPwd
		String url = "jdbc:/mysql:/localhost:3306/db01?useSSL=false";
		String dbId = "sol23";
		String dbPwd = "1234";
		
		// SQL
		String sql1 = "select id, pwd from member where id = ? and pwd = ?"; // 아이디, 패스워드 검증
		String sql2 = "update set name = ?, age = ? where id = ?"; // 수정
		
		try {
			// 1단계 - 드라이버 연결
			// 2단계 - 커넥션 객체 획득
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, dbId, dbPwd);
			
			// 3단계 - SQL 실행
			// 4단계 - rs 객체로 결과를 획득
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			pstmt.close();
			
			// rs의 결과가 1개일 때는 if문을 사용
			// 아이디와 패스워드가 모두 일치할때 true -> 업데이트 실행
			// 아이디 또는 패스워드가 일치하지 않을 때 false -> 처리 문구
			if(rs.next()) { // 아이디와 패스워드가 모두 일치할 때

					pstmt = conn.prepareStatement(sql2);
					pstmt.setString(1, name);
					pstmt.setInt(2,age);
					pstmt.setString(3,id);
					pstmt.executeUpdate();
					out.println(id + "님의 데이터가 수정되었습니다.");
					
			} else { // 아이디 또는 패스워드가 일치하지 않을 때
				out.println("입력한 정보가 일치하지 않습니다.");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
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