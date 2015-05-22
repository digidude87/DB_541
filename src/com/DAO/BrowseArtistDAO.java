package com.DAO;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.TO.GenreTO;
import com.TO.SearchArtistTO;
import com.TO.SubGenreTO;

import database.DBHandler;

public class BrowseArtistDAO {
	public static DBHandler db = new DBHandler();

	public List<SearchArtistTO> loadArtists(String text)
			throws SQLException, IOException {
		//List<Map<Integer, String>> retList = new ArrayList<Map<Integer, String>>();
		Map<Integer, String> primaryMap = new HashMap<Integer, String>();
		Map<Integer, String> secondMap = new HashMap<Integer, String>();
		/*Map<Integer, String> tertMap = new HashMap<Integer, String>();*/
		List<SearchArtistTO> suggestions = new ArrayList<SearchArtistTO>();
		List<Integer> visitedIds = new ArrayList<Integer>();
		String sql = "select distinct artistId, artistName from Artists where artistName ='"
				+ text + "' limit 1";
		ResultSet rs = db.runSql(sql);
		SearchArtistTO temp;
		int exactId = 0;
		while (rs.next()) {
			temp = new SearchArtistTO();
			exactId = rs.getInt("artistId");
			temp.setArtistId(exactId);
			temp.setArtistName(rs.getString("artistName"));
			suggestions.add(temp);
			visitedIds.add(exactId);
			//primaryMap.put(rs.getInt("artistId"), rs.getString("artistName"));
		}
		sql = "select distinct artistId, artistName from Artists where artistName like '%"
				+ text + "%' and artistName != '"+text+"'order by artistPopularityAll desc";
		rs = db.runSql(sql);
		int id;
		while (rs.next()) {
			id=rs.getInt("artistId");
			temp = new SearchArtistTO();
			if(id != exactId){
				temp.setArtistId(id);
				temp.setArtistName(rs.getString("artistName"));
				suggestions.add(temp);
				secondMap.put(id, rs.getString("artistName"));
				visitedIds.add(id);
			}
		}
		sql="select distinct * from ArtistAlias where artistAlias='"+text+"'";
		rs = db.runSql(sql);
		while (rs.next()) {
			id=rs.getInt("artistId");
			temp = new SearchArtistTO();
			temp.setArtistId(id);
			temp.setArtistName(rs.getString("artistAlias"));
			if(exactId!=0 && exactId != id){
				suggestions.add(1,temp);
			}else if(exactId == 0){
				suggestions.add(0,temp);
			}
		}
		sql="select distinct * from ArtistAlias where artistAlias like '%"+text+"%'";
		rs = db.runSql(sql);
		/*int i=0;
		int removeId = 0;*/
		while (rs.next()) {
			id=rs.getInt("artistId");
			temp = new SearchArtistTO();
			if(exactId != id && !visitedIds.contains(id)){
				temp.setArtistId(id);
				temp.setArtistName(rs.getString("artistAlias"));
				suggestions.add(temp);
				visitedIds.add(id);
			} 
			/*else if (visitedIds.contains(id)){
				i=0;
				removeId = -1;
				for(SearchArtistTO t:suggestions){
					if(t.getArtistId() == id){
						removeId = i;
						temp.setArtistId(id);
						temp.setArtistName(t.getArtistName());
						if(t.getArtistAlias()!=null){
							temp.setArtistAlias(t.getArtistAlias()+", "+rs.getString("artistAlias"));
						}
						//t.setArtistName(t.getArtistName()+", "+rs.getString("artistAlias"));
						break;
					}
					i++;
				}
				if(removeId!=-1){
					suggestions.remove(removeId);
					suggestions.add(removeId,temp);
				}
			}*/
		}
		/*sql = "select distinct artistId, artistName from Artists where artistName like '%"
				+ text + "' order by artistPopularityAll desc";
		rs = db.runSql(sql);
		while (rs.next()) {
			id=rs.getInt("artistId");
			temp = new SearchArtistTO();
			if(!primaryMap.keySet().contains(id) && !secondMap.keySet().contains(id)){
				temp.setArtistId(id);
				temp.setArtistName(rs.getString("artistName"));
				suggestions.add(temp);
			}
		}
		retList.add(primaryMap);
		retList.add(secondMap);
		retList.add(tertMap);*/
		return suggestions;
	}

	public Map<Integer, String> loadRecentTopArtists() throws SQLException,
			IOException {
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		String sql = "select artistId,artistName from Artists order by artistPopularityRecent desc limit 20";
		ResultSet rs = db.runSql(sql);
		while (rs.next()) {
			retMap.put(rs.getInt("artistId"), rs.getString("artistName"));
		}
		return retMap;
	}

	public Map<Integer, String> loadOverAllTopArtists() throws SQLException,
			IOException {
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		String sql = "select artistId,artistName from Artists order by artistPopularityAll desc limit 20";
		ResultSet rs = db.runSql(sql);
		while (rs.next()) {
			retMap.put(rs.getInt("artistId"), rs.getString("artistName"));
		}
		return retMap;
	}

	public Map<Integer, String> loadArtistsLocation(String country)
			throws SQLException, IOException {
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		List<String> artistIds = new ArrayList<String>();
		String sql = "select artistId from Songs where songCountry = '"
				+ country + "'  order by viewCount desc limit 100";
		ResultSet rs = db.runSql(sql);
		while (rs.next()) {
			artistIds.add(rs.getString("artistId"));
		}
		if (artistIds.size() > 0) {
			StringBuffer query = new StringBuffer();
			query.append("select distinct artistId, artistName from Artists where artistId IN (");
			Iterator<String> iter = artistIds.iterator();
			String temp;
			while (iter.hasNext()) {
				temp = iter.next();
				if (iter.hasNext()) {
					query.append(temp + ",");
				} else {
					query.append(temp + ") order by artistPopularityAll desc");
				}
			}
			rs = db.runSql(query.toString());
			while (rs.next()) {
				retMap.put(rs.getInt("artistId"), rs.getString("artistName"));
			}
		}
		return retMap;
	}

	public Map<Integer, String> loadArtistsGenre(String genre)
			throws SQLException, IOException {
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		List<String> artistIds = new ArrayList<String>();
		String sql = "select distinct artistId from genresnew where name = '"
				+ genre + "'";
		ResultSet rs = db.runSql(sql);
		while (rs.next()) {
			artistIds.add(rs.getString("artistId"));
		}
		if (artistIds.size() > 0) {
			StringBuffer query = new StringBuffer();
			query.append("select distinct artistId, artistName from Artists where artistId IN (");
			Iterator<String> iter = artistIds.iterator();
			String temp;
			while (iter.hasNext()) {
				temp = iter.next();
				if (iter.hasNext()) {
					query.append(temp + ",");
				} else {
					query.append(temp + ") order by artistPopularityAll desc");
				}
			}
			rs = db.runSql(query.toString());
			while (rs.next()) {
				retMap.put(rs.getInt("artistId"), rs.getString("artistName"));
			}
		}
		return retMap;
	}

	public String verifyLogin(String uid, String pass) throws SQLException,
			IOException {
		String sql = "select artistName from loginInfo where loginId='" + uid
				+ "' and password='" + pass + "'";
		ResultSet rs = db.runSql(sql);
		String userName = "";
		int count = 0;
		while (rs.next()) {
			userName = rs.getString("artistName");
			count++;
		}
		if (count == 0) {
			userName = "none";
		}
		return userName;
	}

	public List<SubGenreTO> loadSubGenres(String genre) throws SQLException,
			IOException {
		List<SubGenreTO> subgenres = new ArrayList<SubGenreTO>();
		String sql = "select distinct name,main_genre from genresgrp where main_genre = \""
				+ genre + "\"";
		ResultSet rs = db.runSql(sql);
		SubGenreTO temp;
		while (rs.next()) {
			temp = new SubGenreTO();
			temp.setName(rs.getString("name"));
			temp.setMainGenre(rs.getString("main_genre"));
			subgenres.add(temp);
		}
		return subgenres;
	}
}
