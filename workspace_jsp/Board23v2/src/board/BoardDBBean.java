package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// board 테이블에 대해 데이터를 처리하는 클래스
public class BoardDBBean {
	
	// singleton 패턴
	private BoardDBBean() {}
	private static BoardDBBean instance = new BoardDBBean();
	public static BoardDBBean getInstance() {
		return instance;
	}
	
	// DB 관련 변수 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// Connection Pool 설정과 연동 - Apache Commons
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env"); // meta-inf 안에 있는 contex.xml을 찾는 과정
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db01"); // datasource를 찾는 과정
		return ds.getConnection();
	}
	
	// 글 추가 메소드
	public void insertBoard(BoardDataBean board) {
		String sql1 = "select max(num) from board";
		String sql2 = "update board set re_step=re_step+1 where ref=? and re_step>? ";
		String sql3 = "insert into board(writer,email,subject,content,ref,re_step,re_level) values(?,?,?,?,?,?,?)";
		
		try {
			conn = getConnection();
			
			// 트랜잭션 처리
			// 1단계
			
			conn.setAutoCommit(false);
			
			int num = board.getNum();
			int ref = board.getRef();
			int re_step = board.getRe_step();
			int re_level = board.getRe_level();
			int number = 0;
			
			// 글번호의 최대값을 구함
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			
			// 게시판의 최대값에 1을 더함, 최대값이 없다면 1이 됨.
			if(rs.next()) {
				
				number = rs.getInt(1) + 1;
				
			} else {
				
				number = 1;
				
			}
			
			// 댓글과 원글 처리
			if(num != 0) { // 댓글이라면
				
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step += 1;
				re_level += 1;
				
			} else { // 댓글이 아니라면 -> 원글
				ref = number;
				re_step = 0;
				re_level = 0;
			}
			
			pstmt = conn.prepareStatement(sql3);
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getEmail());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getContent());
			pstmt.setInt(5, ref); 
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.executeUpdate();
			
			// 2단계
			conn.commit();
			
			// 3단계
			conn.setAutoCommit(true);
			
			System.out.println("*** insertBoard() 메소드 실행 완료 ***");
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error: insertBoard() 메소드 예외 발생...");
			
		} finally {
			close(conn, pstmt);
			
		}
	}
	
	// 글 수정 폼 메소드
	public BoardDataBean getBoardUpdate(int num) {
		String sql = "select * from board where num =?";
		BoardDataBean board = null;
		
		try {
			conn = getConnection();
			
			// 1건 조회
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board = new BoardDataBean();
	            board.setNum(rs.getInt("num"));
	            board.setWriter(rs.getString("writer"));
	            board.setEmail(rs.getString("email"));
	            board.setSubject(rs.getString("subject"));
	            board.setContent(rs.getString("content"));
	            board.setReg_date(rs.getTimestamp("reg_date"));
	            board.setRef(rs.getInt("ref"));
	            board.setRe_step(rs.getInt("re_step"));
	            board.setRe_level(rs.getInt("re_level"));
	            board.setReadcount(rs.getInt("readcount"));
		  }
			
			System.out.println("*** getBoardUpdate() 메소드 실행 완료 ***");
			
	      } catch(Exception e) {
	         e.printStackTrace();
	         System.out.println("# error: getBoardUpdate() 메소드에서 예외 처리...");
	      } finally {
	         close(conn, pstmt, rs);
	      }
	      return board;
	   }
	
	// 글 수정 처리 메소드
	public int updateBoard(BoardDataBean board) {
		String sql = "update board set subject=?, content=? where num=?";
		int count = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getSubject());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getNum());
			count = pstmt.executeUpdate();
			
			System.out.println("*** updateBoard() 메소드 실행 완료 ***");
		
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("# error : updateBoard() 메소드에서 예외처리");
			
		} finally {
			close(conn, pstmt);
		}
		return count;
	}
	
	// 글 삭제 메소드 - 삭제 여부 확인
	public int deleteBoard(int num, String id, String pwd) {
		String sql1 = "select * from member where id = ? and pwd = ?";
		String sql2 = "delete from board where num=?";
		int count = 0;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1,id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 회원의 아이디와 비밀번호가 맞다면 -> 글 삭제
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, num);
				count = pstmt.executeUpdate();
			} 
			
			
			
			
			System.out.println("*** deleteBoard() 메소드 실행 완료 ***");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error: deleteBoard() 메소드에서 예외 처리…");
		} finally {
			close(conn, pstmt);
		}
		return count;
	}
	
	// 글 조회 메소드 (10건씩 조회) 
	// limit 시작번호, 건수 -> 시작번호는 0번부터
	// start : 시작번호, count : 건수
	public List<BoardDataBean> getBoards(int start, int count) {
		String sql = "select * from board order by ref desc, re_step asc limit ?, ?";
		BoardDataBean board = null;
		List<BoardDataBean> boardList = new ArrayList<BoardDataBean>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, count);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				board = new BoardDataBean();
				board.setNum(rs.getInt("num"));
				board.setWriter(rs.getString("writer"));
				board.setEmail(rs.getString("email"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setReg_date(rs.getTimestamp("reg_date"));
				board.setRef(rs.getInt("ref"));
				board.setRe_step(rs.getInt("re_step"));
				board.setRe_level(rs.getInt("re_level"));
				board.setReadcount(rs.getInt("readcount"));
				boardList.add(board);
			}
			
			System.out.println("*** getBoards() 메소드 실행 완료 ***");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error: getBoards() 메소드에서 예외 처리 발생..");
		} finally {
			close(conn, pstmt);
		}
		return boardList;
	}
	
	// 글 상세 메소드 (1건 조회) -> 조회수 증가
	public BoardDataBean getBoard(int num) {
		String sql1 = "update board set readcount = readcount+1 where num = ?";
		String sql2 = "select * from board where num = ?";
		
		BoardDataBean board = null;
		
		try {
			conn = getConnection();
			
			// 트랜잭션 (Transaction) - 1번 쿼리와 2번 쿼리를 하나의 작업으로 처리
			// 1단계: 자동커밋 기능을 false로 설정(변경)
			conn.setAutoCommit(false);
			
			// 1번 쿼리 - 조회수 1증가
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			// 2번 쿼리 - 1건 조회
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board = new BoardDataBean();
				board.setNum(rs.getInt("num"));
				board.setWriter(rs.getString("writer"));
				board.setEmail(rs.getString("email"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setReg_date(rs.getTimestamp("reg_date"));
				board.setRef(rs.getInt("ref"));
				board.setRe_step(rs.getInt("re_step"));
				board.setRe_level(rs.getInt("re_level"));
				board.setReadcount(rs.getInt("readcount"));
			}
			
			// 2단계: 작업을 모두 완료하면 커밋
			conn.commit();

			// 3단계: 자동커밋을 다시 true로 설정(변경)         
			conn.setAutoCommit(true);
			
			System.out.println("*** getBoard() 메소드 실행 완료 ***");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error: getBoard() 메소드에서 예외 처리...");
			
		} finally {
			close(conn, pstmt, rs);
		}
		return board;
		
	}
	
	// 전체 글 수 확인 메소드
	public int getBoardCount() {
		String sql = "select count(*) from board";
		int count = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			System.out.println("*** getBoardCount() 메소드 실행 완료 ***");
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error: getBoardCount() 메소드에서 예외 발생..");
		
		} finally {
			close(conn, pstmt, rs);
			
		}
		return count;
		
	}
	
	// DB 관련 변수 해제 - Connection, PreparedStatement
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
	
	// DB 관련 변수 해제 - Connection, PreparedStatement
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
}