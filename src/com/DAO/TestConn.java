package com.DAO;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBHandler;

public class TestConn {
	public static DBHandler db = new DBHandler();

	public static void main(String[] args) throws SQLException, IOException {
		//db.runSql2("TRUNCATE Record;");
		//processPage("http://www.pracsyslab.org/bekris/");
		testConn();
	}

	public static void testConn() throws SQLException, IOException {
		String sql = "select * from artists limit 10";
		ResultSet rs = db.runSql(sql);
		while (rs.next()) {
			System.out.println(rs.getString("artistName"));
		}
	}
}