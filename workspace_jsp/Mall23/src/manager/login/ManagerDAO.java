package manager.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// 관리자 DB 처리
public class ManagerDAO {
	
	// Singleton Pattern
	private ManagerDAO() {	}
	
	private static ManagerDAO instance = new ManagerDAO();

	public static ManagerDAO getInstance() {
		return instance;
	}
	
	// DB 처리 변수 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// Connection Pool 사용
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db02");
		return ds.getConnection();
	}
	
	// 관리자 확인 메소드 - 관리자 아이디, 관리자 비밀번호
	public int managerCheck(String managerId, String managerPwd) {
		String sql = "select * from manager where managerId = ? and managerPwd = ?";
		int check = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			pstmt.setString(2, managerPwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()) check = 1;
			System.out.println("*** managerCheck() 메소드 실행 완료 ***");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error: managerCheck() 메소드에서 예외 처리");
		} finally {
			close(conn, pstmt, rs);
		}
		return check;
	}
	
	// DB 처리 변수 해제 - Connection, PreparedStatement, ResultSet
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
		if(conn != null) {
			try {
				conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	// DB 처리 변수 해제 - Connection, PreparedStatement, ResultSet
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
}
