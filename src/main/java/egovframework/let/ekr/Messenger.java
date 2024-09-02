package egovframework.let.ekr;

import java.sql.*;

import egovframework.let.sr.service.SrVO;

public class Messenger {
	//농어촌공사 Messenger 로직
//	public static Connection dbConn;

//	public static Connection getConnection() {
//		Connection conn = null;
//		try {
//			String user = "ANNOUNCE";
//			String pw = "announce";
//			String url = "jdbc:oracle:thin:@10.11.52.61:1592:KRCMSG";
//
//			Class.forName("oracle.jdbc.driver.OracleDriver");
//			conn = DriverManager.getConnection(url, user, pw);
//
//			System.out.println("Database에 연결되었습니다.\n");
//
//		} catch (ClassNotFoundException cnfe) {
//			System.out.println("DB 드라이버 로딩 실패 :" + cnfe.toString());
//		} catch (SQLException sqle) {
//			System.out.println("DB 접속실패 : " + sqle.toString());
//		} catch (Exception e) {
//			System.out.println("Unkonwn error");
//			e.printStackTrace();
//		}
//		return conn;
//	}
//	
//	public static void send(SrVO srVO ) {
//        Connection conn = null; // DB연결된 상태(세션)을 담은 객체
//        PreparedStatement pstm = null;  // SQL 문을 나타내는 객체
//        ResultSet rs = null;  // 쿼리문을 날린것에 대한 반환값을 담을 객체		   
//	}
	
}
