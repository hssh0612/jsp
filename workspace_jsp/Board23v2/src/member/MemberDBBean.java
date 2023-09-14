package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// member 테이블의 DB 처리
// DAO(Data Access Object)
// MemberDAO
public class MemberDBBean {
	
	// 싱글톤 패턴
	private MemberDBBean() { }
	
	private static MemberDBBean instance = new MemberDBBean();
	
	public static MemberDBBean getInstance() {
		return instance;
	}
	
	// DB 연결, 처리 변수 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	
	// 커넥션풀을 사용한 커넥션 획득
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db01");
		return ds.getConnection();
	}
	
	// 로그인 체크 메소드
	// 아이디와 비밀번호를 모두 체크하여, 로그인 여부를 알려줌.
	// check가 1일 때 -> 로그인 성공
	// check가 0일 때 -> 로그인 실패
	public int loginCheck(String id, String pwd) {
		
		String sql = "select * from member where id = ? and pwd = ?";
		int check = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()) check = 1;
			else check = 0;
			
			System.out.println("*** loginCheck() 메소드 실행 완료 ***");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error : loginCheck() 메소드에서 예외 발생");
		} finally {
			close(conn, pstmt, rs);
		}
		return check;
	}
	
	// 중복 아이디 체크 메소드
	// check가 1일 때 -> 아이디가 이미 존재할 때 -> 입력한 아이디는 사용불가
	// check가 0일 때 -> 아이디가 존재하지않을 때 -> 입력한 아이디는 사용가능
	public int idCheck(String id) {
		
		String sql = "select * from member where id = ?";
		int check = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) check = 1;
			else check = 0;
			
			System.out.println("*** idCheck() 실행 완료 ***");
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error : idCheck() 메소드에서 예외 처리");
		} finally {
			close(conn, pstmt, rs);
		}
		return check;
	}
	
	
	// 회원 가입(추가) 메소드
	public void insertMember(MemberDataBean member) {
		String sql = "insert into member(id, pwd, name, birthday, email, tel, address1, address2) values(?,?,?,?,?,?,?,?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getBirthday());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, member.getTel());
			pstmt.setString(7, member.getAddress1());
			pstmt.setString(8, member.getAddress2());
			pstmt.executeUpdate();
			
			System.out.println("*** insertMember() 메소드 실행 완료 ***");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error : insertMember() 메소드에서 예외 발생");
		} finally {
			close(conn, pstmt);
		}
	}
	
	
	// 회원 수정 메소드 - 아이디와 비밀번호를 확인
	// id, pwd, name, birthday, email, tel, address1, address2, reg_date 중에서 id와 reg_date를 제외한 7개의 정보
	// id를 조건으로 사용하여 7개 정보 수정
	// check가 1이면 수정 성공
	// check가 0이면 수정 실패
	public int updateMember(MemberDataBean member) {
		String sql = "update member set pwd=?,name=?,birthday=?,email=?,tel=?,address1=?,address2=? where id=?";
		int check = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getBirthday());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getTel());
			pstmt.setString(6, member.getAddress1());
			pstmt.setString(7, member.getAddress2());
			pstmt.setString(8, member.getId());
			check = pstmt.executeUpdate();
			
			System.out.println("*** updateMember() 메소드 실행 완료 ***");
			
		} catch(Exception e) {
			e.printStackTrace();
			
			System.out.println("# error : updateMember() 예외처리 ");
			
		} finally {
			close(conn, pstmt);
		}
		return check;
	}
	
	
	
	// 회원 삭제(탈퇴) 메소드 
	// id, pwd를 확인하여 삭제 
	// check가 1이면 삭제 성공
	// check가 0이면 삭제 실패
	public int deleteMember(String id, String pwd) {
		String sql = "delete from member where id=? and pwd=?";
		int check = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			check = pstmt.executeUpdate();
			
			System.out.println("*** deleteMember() 메소드 실행 완료 ***");
			
		} catch(Exception e) {
			e.printStackTrace();
			
			System.out.println("# error : deleteMember() 예외처리 ");
			
		} finally {
			close(conn, pstmt);
		}
		return check;
	}

	
	
	// 회원 정보 확인 메소드 (1명) - 회원 본인
	public MemberDataBean getMember(String id) {
		String sql = "select * from member where id = ?";
		MemberDataBean member = new MemberDataBean();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member.setId(rs.getString("id"));
				member.setPwd(rs.getString("pwd"));
				member.setName(rs.getString("name"));
				member.setBirthday(rs.getString("birthday"));
				member.setEmail(rs.getString("email"));
				member.setTel(rs.getString("tel"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				
			}
			System.out.println("*** getMember() 메소드 실행 완료 ***");
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error : getMember() 메소드 예외 처리");
		} finally {
			close(conn, pstmt, rs);
		}
		return member;
	}
	
	
	
	// 관리자 - 회원 전체 정보 확인, 수정, 삭제(강퇴)
	

	
	
	
	// DB 연결, 처리 변수 해제 - Connection, PreparedStatement
	public void close(Connection conn, PreparedStatement pstmt) {
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
	
	// DB 연결, 처리 변수 해제 - Connection, PreparedStatement, ResultSet
	public void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
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
	
}
