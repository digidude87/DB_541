package com.DAO;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import database.DBHandler;

public class BrowseArtistDAO {
	public static DBHandler db = new DBHandler();

	public Map<Integer, String> loadArtists(String text) throws SQLException, IOException{
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		String sql = "select distinct artistId, artistName from artists where artistName like '%"+text+"%'";
		ResultSet rs = db.runSql(sql);
		while (rs.next()) {
			retMap.put(rs.getInt("artistId"),rs.getString("artistName"));
		}
		return retMap;
	}
	
	public Map<Integer, String> loadArtistsLocation(String country) throws SQLException, IOException{
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		List<String> artistIds = new ArrayList<String>();
		String sql = "select distinct artistId from songs where songCountry = '"+country+"'";
		ResultSet rs = db.runSql(sql);
		while(rs.next()){
			artistIds.add(rs.getString("artistId"));
		}
		StringBuffer query = new StringBuffer();
		query.append("select distinct artistId, artistName from artists where artistId IN (");
		Iterator<String> iter = artistIds.iterator();
		String temp;
		while(iter.hasNext()){
			temp = iter.next();
			if(iter.hasNext()){
				query.append(temp+",");
			}else{
				query.append(temp+")");
			}
		}
		rs = db.runSql(query.toString());
		while (rs.next()) {
			retMap.put(rs.getInt("artistId"),rs.getString("artistName"));
		}
		return retMap;
	}
	
	public String verifyLogin(String uid, String pass) throws SQLException, IOException{
		String sql = "select artistName from loginInfo where loginId='"+uid+"' and password='"+pass+"'";
		ResultSet rs = db.runSql(sql);
		String userName="";
		int count = 0;
		while (rs.next()) {
			userName = rs.getString("artistName");
			count++;
		}
		if(count==0){
			userName = "none";
		}
		return userName;
	}
}
