package manager.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// DBBean - product 테이블에 데이터를 삽입, 수정, 삭제, 조회하기 위한 디비빈
public class ProductDAO {
	// Singleton 패턴
	private ProductDAO() { }
	
	private static ProductDAO instance = new ProductDAO();
	
	public static ProductDAO getInstance() {
		return instance;
	}
	
	// Connection Pool 설정
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db02");
		return ds.getConnection();
	}
	
	// DB 연결, 처리 변수 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 상품 등록 메소드
	public void insertProduct(ProductVO product) {
		String sql ="insert into product(product_kind,product_name,product_price,product_count,author,publishing_com,publishing_date,"
				+ "product_image, product_content,discount_rate) values(?,?,?,?,?,?,?,?,?,?)";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getProduct_kind());
			pstmt.setString(2, product.getProduct_name());
			pstmt.setInt(3, product.getProduct_price());
			pstmt.setInt(4, product.getProduct_count());
			pstmt.setString(5, product.getAuthor());
			pstmt.setString(6, product.getPublishing_com());
			pstmt.setString(7, product.getPublishing_date());
			pstmt.setString(8, product.getProduct_image());
			pstmt.setString(9, product.getProduct_content());
			pstmt.setInt(10, product.getDiscount_rate());
			pstmt.executeUpdate();
			 
			System.out.println("*** insertProduct() 실행 완료 ***");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error: insertProduct() 메소드에서 예외 발생...");
		} finally {
			close(conn, pstmt);
		}
	}
	
	// 전체 상품 목록 메소드 -> 한 페이지 당 10개 상품을 노출
	// limit 시작번호, 건수 -> 시작번호는 0번부터
	// start : 시작번호, count : 개수
	public List<ProductVO> getProductAll(int start, int count) {
		String sql = "select * from product order by reg_date desc limit ?, ?";
		List<ProductVO> productList = new ArrayList<ProductVO>();
		ProductVO product = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, count);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				product = new ProductVO();
				product.setProduct_id(rs.getInt("product_id")); // product.setProduct_id(rs.getInt(1));이라고 해도 상관없긴함.
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setAuthor(rs.getString("author"));
				product.setPublishing_com(rs.getString("publishing_com"));
				product.setPublishing_date(rs.getString("publishing_date"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_content(rs.getString("product_content"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				productList.add(product);
			}
			System.out.println("*** getProductAll() 메소드 실행 완료 ***");
		
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error : getProductAll() 메소드에서 예외 발생");
		} finally {
			close(conn,pstmt, rs);
		}
		return productList;
	}
	
	// 전체 상품 개수 메소드
	public int getProductCount() {
		String sql = "select count(*) from product";
		int count = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) count = rs.getInt(1);
			
			System.out.println("*** getProductCount() 메소드 실행 완료 ***");
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error : getProductCount() 메소드에서 예외 발생");	
		} finally {
			close(conn, pstmt, rs);
		}
		return count;
	}
	
	// 상품 1개 정보 메소드
	public ProductVO getProduct(int product_id) {
		String sql = "select * from product where product_id = ?";
		ProductVO product = new ProductVO();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setAuthor(rs.getString("author"));
				product.setPublishing_com(rs.getString("publishing_com"));
				product.setPublishing_date(rs.getString("publishing_date"));
				product.setProduct_content(rs.getString("product_content"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				
			}
			System.out.println("*** getProduct() 메소드 실행 완료 ***");
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error : getProduct() 메소드에서 예외 발생");
		} finally {
			close(conn, pstmt, rs);
		}
		return product;
	}
	
	// 상품 분류 별로 상품 조회 -> 페이징 처리
	public List<ProductVO> getProductKind(String product_kind, int start, int count) {
		String sql = "select * from product where product_kind = ? order by reg_date desc limit ?, ?";
		List<ProductVO> productList = new ArrayList<ProductVO>();
		ProductVO product = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_kind);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, count);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				product = new ProductVO();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setAuthor(rs.getString("author"));
				product.setPublishing_com(rs.getString("publishing_com"));
				product.setPublishing_date(rs.getString("publishing_date"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_content(rs.getString("product_content"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				productList.add(product);
			}
			
			System.out.println("*** getProductKind() 메소드 실행 완료 ***");
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error : getProductKind() 메소드에서 예외 발생");
		} finally {
			close(conn, pstmt, rs);
		}
		return productList;
	}
	
	// 상품 분류별 목록 개수, ex) 500번의 상품개수가 25개
	public int getProductKindCount(String product_kind) {
		String sql = "select count(*) from product where product_kind = ? ";
		int count = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_kind);
			rs = pstmt.executeQuery();
			
			if(rs.next()) count = rs.getInt(1);
			System.out.println("*** getProductKindCount() 메소드 실행 완료 ***");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error : getProductKindCount() 메소드에서 예외 발생");
		} finally {
			close(conn, pstmt, rs);
		}
		return count;
	}
	
	// 상품 정보 수정 메소드
	public void updateProduct(ProductVO product) {
		String sql= "update product set product_kind=?, product_name=?, product_price=?, product_count=?, author=?, "
				+ " publishing_com=?, publishing_date=?, product_image=?, product_content=?, discount_rate=? where product_id = ?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getProduct_kind());
			pstmt.setString(2, product.getProduct_name());
			pstmt.setInt(3, product.getProduct_price());
			pstmt.setInt(4, product.getProduct_count());
			pstmt.setString(5, product.getAuthor());
			pstmt.setString(6, product.getPublishing_com());
			pstmt.setString(7, product.getPublishing_date());
			pstmt.setString(8, product.getProduct_image());
			pstmt.setString(9, product.getProduct_content());
			pstmt.setInt(10, product.getDiscount_rate());
			pstmt.setInt(11, product.getProduct_id());
			//pstmt.executeQuery();
			pstmt.executeUpdate();
			
			System.out.println("*** updateProduct() 메소드 실행 완료 ***");
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error : updateProduct() 메소드에서 예외 발생");
		} finally {
			close(conn, pstmt);
		}
	}
	
	// 선택한 상품 여러개의 삭제 메소드
	public void deleteProduct(List<Integer> ids) {
		String sql = "delete from product where product_id = ?";
		
		try {
			conn = getConnection();
			
			for(int i : ids) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, i);
				pstmt.executeUpdate();
			}
			
			System.out.println("*** deleteProduct() 메소드 실행 완료 ***");
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("# error : deleteProduct() 메소드에서 예외 발생");
			
		} finally {
			close(conn, pstmt);
			
		}
	}
	
	// DB 연결, 처리 변수 해제 - Connection, PreparedStatement, ResultSet
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
	
	// DB 연결, 처리 변수 해제 - Connection, PreparedStatement
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