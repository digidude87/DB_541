package com.Service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.DAO.BrowseArtistDAO;

public class BrowseArtistService {
	public Map<Integer, String> loadArtists(String text) throws SQLException, IOException{
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		retMap = new BrowseArtistDAO().loadArtists(text);
		return retMap;
	}
	
	public Map<Integer, String> loadArtistsLocation(String country) throws SQLException, IOException{
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		retMap = new BrowseArtistDAO().loadArtistsLocation(country);
		return retMap;
	}
	
	public String verifyLogin(String uid, String pass) throws SQLException, IOException{
		String userName = new BrowseArtistDAO().verifyLogin(uid, pass);
		return userName;
	}
}
