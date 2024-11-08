import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class BookList {
	
	private Connection con;

	public BookList() {
		//DB 연결 정보 선언
		String Driver="";
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		//12버전 이상은 c##을 붙인다.
		String userId="c##madang";
		String pwd="madang";
		
		//드라이버를 찾는 과정
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버 로드 성공");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		//데이터베이스를 연결
		try {
			System.out.println("데이터베이스 연결 준비...");
			con=DriverManager.getConnection(url,userId,pwd);
			System.out.println("데이터베이스 연결 성공");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	//book테이블의 모든 책 리스트 가져 오기
	public void getBooks() {
		//sql문
		String query="select * from book";
		try {
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery(query);
			while(rs.next(
					)) {
				System.out.println(rs.getInt(1));
				System.out.println(rs.getString(2));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		BookList bl=new BookList();
		bl.getBooks();
	}
	
}
