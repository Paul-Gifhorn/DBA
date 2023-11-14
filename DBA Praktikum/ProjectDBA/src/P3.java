import java.sql.*;
import java.util.Properties;

public class P3 {
	
	static void printResult(Statement x,String y) {
		ResultSet rs;
		try {
			rs = x.executeQuery (y);
			while (rs.next()) { // lies die Ergebnisdatensätze aus
				String number = rs.getString(1);
				System.out.println(number);
			}
		} catch (SQLException e) {}
	}
	
	static void getMovies(Statement x,String y) {
		ResultSet rs;
		try {
			rs = x.executeQuery (y);
			while (rs.next()) { // lies die Ergebnisdatensätze aus
				System.out.println(rs.getString(2)+" erschien im Jahr "+ rs.getString(3));
			}
		} catch (SQLException e) {}
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		try {
			Class.forName ("org.postgresql.Driver");
			System.out.println("Load Driver");
			
		} catch (ClassNotFoundException e) {}
		
		try {
			
			//Properties props = new Properties();
			//props.setProperty("options", "-c search_path=filmDB");
			
			Connection con = DriverManager.getConnection
			("jdbc:postgresql://pgsql.ins.hs-anhalt.de:5432/stud16_db", "stud16","d7xhicc7");
			Statement stmt = con.createStatement();
			System.out.println("Connected");
			
			printResult(stmt,"SELECT COUNT(*) FROM FILMDB.FILM");
			
			getMovies(stmt, "SELECT * FROM FILMDB.FILM Order BY jahr DESC LIMIT 3");
			con.close();
			
		} catch (SQLException e) {}

	}
}


	
