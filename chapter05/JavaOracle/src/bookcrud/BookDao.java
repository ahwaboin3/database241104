package bookcrud;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDao {
	//DB 연결 정보
	private String driver="oracle.jdbc.driver.OracleDriver";
	private String url="jdbc:oracle:thin:@localhost:1521:xe";
	private String userId="c##madang";
	private String pwd="madang";
	
	//DB 연결 객체
	private Connection conn=null;
	private PreparedStatement pstm=null;
	private ResultSet rs=null;
	
	//DB 연결
	public void connect() {
		try{
			Class.forName(driver);
			conn=DriverManager.getConnection(url,userId,pwd);
			System.out.println("db 연결 성공");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//DB 연결 해제
	public void disconnect() {
		if(conn !=null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(pstm!=null) {
			try {
				pstm.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(rs!=null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	//book 전체 데이터를 가져오기
	public List<BookDto> getBooks() {
		//DB 연결
		connect();
		//배열 생성
		List<BookDto> books=new ArrayList<>();
		//SQL문 생성
		String sql="select * from book";
		//SQL문 실행
		try {
			pstm=conn.prepareStatement(sql);
			rs=pstm.executeQuery();
			while(rs.next()) {
				BookDto book=new BookDto();
				book.setBookId(rs.getInt(1));
				book.setBookName(rs.getString(2));
				book.setPublisher(rs.getString(3));
				book.setPrice(rs.getInt(4));
//				System.out.println(book);
				books.add(book);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disconnect();
		return books;
	}
	
	//기본키로 한행을 가져오는 것이 기본
	public BookDto getBook(int bookId) {
		connect();
		BookDto b=new BookDto();
		String sql="select * from book where bookid=?";
		try {
			pstm=conn.prepareStatement(sql);
			pstm.setInt(1, bookId);
			rs=pstm.executeQuery();
			while(rs.next()) {
				b.setBookId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setPublisher(rs.getString(3));
				b.setPrice(rs.getInt(4));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disconnect();
		return b;
	}
	
	//inset, delete, update 문
	//결과가 나오지 않는 sql문 처리
	public void putBook(BookDto b) {
		connect();
		String sql="insert into book values(?,?,?,?)";
		try {
			pstm=conn.prepareStatement(sql);
			pstm.setInt(1, b.getBookId());
			pstm.setString(2, b.getBookName());
			pstm.setString(3, b.getPublisher());
			pstm.setInt(4, b.getPrice());
			pstm.executeUpdate();
			System.out.println("책 저장 성공");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disconnect();
	}
	
	public static void main(String[] args) {
		BookDao bd=new BookDao();
//		bd.connect();
//		bd.disconnect();
		for(BookDto b:bd.getBooks()) {
			System.out.println(b);
		}
		
		//한개 가져 오기 Read
		System.out.println(bd.getBook(1));
		System.out.println(bd.getBook(5));
		System.out.println(bd.getBook(9));
		
		//북 한개 저장
		BookDto b=new BookDto();
		b.setBookId(12);
		b.setBookName("테스트북");
		b.setPublisher("테스트출판사");
		b.setPrice(30000);
		bd.putBook(b);
	}
}






