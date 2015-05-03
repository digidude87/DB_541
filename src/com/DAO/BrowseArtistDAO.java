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
import com.TO.SubGenreTO;

import database.DBHandler;

public class BrowseArtistDAO {
	public static DBHandler db = new DBHandler();

	public Map<Integer, String> loadArtists(String text) throws SQLException,
			IOException {
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		String sql = "select distinct artistId, artistName from Artists where artistName like '%"
				+ text + "%'";
		ResultSet rs = db.runSql(sql);
		while (rs.next()) {
			retMap.put(rs.getInt("artistId"), rs.getString("artistName"));
		}
		return retMap;
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
		String sql = "select distinct artistId from Songs where songCountry = '"
				+ country + "'";
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
					query.append(temp + ")");
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
					query.append(temp + ")");
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
