package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
 
public class DBHandler {
 
	public Connection conn = null;
 
	public DBHandler() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String host = "databassproject.crvb42hfos6o.us-west-2.rds.amazonaws.com";
			String dbName = "Database_Project_DB";
			String url = "jdbc:mysql://"+host+":3306/"+dbName;
			conn = DriverManager.getConnection(url, "root", "Harshvardhan");
			//System.out.println("conn built");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
 
	public ResultSet runSql(String sql) throws SQLException {
		Statement sta = conn.createStatement();
		return sta.executeQuery(sql);
	}
 
	public boolean runSql2(String sql) throws SQLException {
		Statement sta = conn.createStatement();
		return sta.execute(sql);
	}
 
	@Override
	protected void finalize() throws Throwable {
		if (conn != null || !conn.isClosed()) {
			conn.close();
		}
	}
}
