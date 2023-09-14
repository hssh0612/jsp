<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertTestPro</title>
</head>
<body>
	<h2>member 테이블 데이터 입력 처리 페이지</h2>
	
	<%
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		Timestamp regDate = new Timestamp(System.currentTimeMillis());
		
		// 커넥션 객체 생성 
		Connection conn = null;
		// PreparedStatement 객체 - SQL 실행 객체
		PreparedStatement pstmt = null;
		// Statement 객체 - SQL문 실행 객체
		Statement stmt = null;
		
		// DB 연결정보
		String url = "jdbc:mysql://localhost:3306/db01?useSSL=false";
		String dbId = "sol23";
		String dbPwd = "1234";
		String sql = "insert into member values(?, ?, ?, ?, ?)";
		String sql2 = "insert into member values('" + id + "','" + pwd + "','" + name + "','" + age + "', '"+ regDate + "', )'";
		
		try {
			// 1단계 - 드라이버 연결
			Class.forName("com.mysql.jdbc.Driver");
			
			// 2단계 - 커넥션 객체 획득
			conn = DriverManager.getConnection(url, dbId, dbPwd);
			
			
			// 3단계 - 1번 방법 : 최근 방법(권장)
			// PreparedStatement 객체 생성과 실행 : SQL문을 실행하는 객체
			// ? : 바인딩(binding) 변수
			sql = "insert into member values(?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setInt(4, age);
			pstmt.setTimestamp(5,regDate);
			// 실행1 : executeUpdate() - insert, update, delete
			// 실행2 : executeQuery() - select
			pstmt.executeUpdate();
			
			
			// 3단계 - 2번 방법 : 예전 방법
			// Statement 객체 생성과 실행 : SQL문을 실행하는 객체
			/*
			stmt = conn.createStatement();
			stmt.executeUpdate(sql2);
			*/
			
			out.println("member 테이블에 데이터가 정상적으로 입력되었습니다.");
			
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("드라이버가 연결되지 않았습니다.");
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("SQL문에서 오류가 발생하였습니다.");
		} finally {
			// DB 연결 객체 해제
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			/*
			if(stmt != null) {
				try {
					stmt.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			*/
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