package logon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


// 데이터베이스와 연결할 때 사용하는 클래스
// DBBean
public class LogonDBBean {
	
	//Singleton 패턴
	private LogonDBBean() { }
	
	private static LogonDBBean instance = new LogonDBBean();
	
	public static LogonDBBean getInstance() {
		return instance;
	}
	
	// 커넥션, DB 처리 객체 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// Connection Pool 사용
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db01");
		return ds.getConnection();
	}
	
	// userCheck() - 사용자의 아이디와 패스워드를 확인
	// 1번 - 아이디의 존재 유무, 아이디가 존재한다면 패스워드의 일치 여부
	// check 변수의 역할
	// -1 : 아이디가 존재하지 않을 때
	// 0 : 아이디는 존재하지만, 패스워드가 일치하지 않을 때
	// 1 : 아이디도 존재하고, 패스워드도 일치할 때
	/*
	public int userCheck(String id, String pwd) {
		String sql = "select id, pwd from member where id = ?";
		int check = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 아이디가 존재할 때
				String dbPwd = rs.getNString("pwd");
				if(pwd.contentEquals(dbPwd)) { // 패스워드 일치
					check = 1;
				} else { // 패스워드 불일치
					check = 0;
				}
			} else { // 아이디가 존재하지 않을 때
				check = -1;
			}
			System.out.println("userCheck() 메소드 실행 완료");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("userCheck() 메소드에서 예외처리");
		} finally {
			close(conn, pstmt, rs);
		}
		return check;
	}
	*/
	
	// 2번 방법 : 로그인 성공 여부에 따라
	// check에 따라 true: 아이디와 패스워드가 모두 일치,
	//				false: 아이디 또는 패스워드가 불일치
	
	public boolean userCheck(String id, String pwd) {
		String sql = "select id, pwd from member where id = ? and pwd = ?";
		boolean check = false;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 아이디와 패스워드가 모두 일치
				check = true;
			} else { // 아이디 또는 패스워드가 불일치
				check = false;
			}
			System.out.println("userCheck() 메소드 실행 완료");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("userCheck() 메소드에서 예외처리");
		} finally {
			close(conn, pstmt, rs);
		}
		return check;
	}
	
	// insertMember() - 회원 추가
	public void insertMember(LogonDataBean member) {
		String sql = "insert into member values(?, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getName());
			pstmt.setInt(4, member.getAge());
			pstmt.setTimestamp(5, member.getRegDate());
			pstmt.executeUpdate();
			System.out.println("insertMember() 메소드 실행 완료");
		} catch(Exception e) { 
			e.printStackTrace();
			System.out.println("insertMember() 메소드에서 예외 발생");
		} finally {
			close(conn, pstmt);
		}
	}
	
	// DB 사용 객체 해제 - conn, pstmt
	private void close(Connection conn, PreparedStatement pstmt) {
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
	
	// DB 사용 객체 해제 - conn, pstmt, rs
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
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
	}
}
