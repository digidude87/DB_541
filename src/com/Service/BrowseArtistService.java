package com.Service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.DAO.BrowseArtistDAO;
import com.TO.SearchArtistTO;
import com.TO.SubGenreTO;

public class BrowseArtistService {
	public List<SearchArtistTO>  loadArtists(String text) throws SQLException,
			IOException {
		List<SearchArtistTO> retList = new ArrayList<SearchArtistTO>();
		retList = new BrowseArtistDAO().loadArtists(text);
		return retList;
	}

	public Map<Integer, String> loadRecentTopArtists() throws SQLException,
			IOException {
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		retMap = new BrowseArtistDAO().loadRecentTopArtists();
		return retMap;
	}

	public Map<Integer, String> loadOverAllTopArtists() throws SQLException,
			IOException {
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		retMap = new BrowseArtistDAO().loadOverAllTopArtists();
		return retMap;
	}

	public Map<Integer, String> loadArtistsLocation(String country)
			throws SQLException, IOException {
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		retMap = new BrowseArtistDAO().loadArtistsLocation(country);
		return retMap;
	}

	public Map<Integer, String> loadArtistsGenre(String genre)
			throws SQLException, IOException {
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		retMap = new BrowseArtistDAO().loadArtistsGenre(genre);
		return retMap;
	}

	public String verifyLogin(String uid, String pass) throws SQLException,
			IOException {
		String userName = new BrowseArtistDAO().verifyLogin(uid, pass);
		return userName;
	}

	public List<SubGenreTO> loadSubGenres(String genre) throws SQLException,
			IOException {
		List<SubGenreTO> subgenres = new ArrayList<SubGenreTO>();
		subgenres = new BrowseArtistDAO().loadSubGenres(genre);
		return subgenres;
	}
}
