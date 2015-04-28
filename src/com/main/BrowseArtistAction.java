package com.main;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.Service.BrowseArtistService;
import com.TO.SearchArtistTO;
import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class BrowseArtistAction extends ActionSupport implements SessionAware {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String suggestionList = "";
	private String response;
	private String searchText;
	private String uid;
	private String password;
	private Map<Integer, String> artistSuggestion;
	Map<String, Object> session;
	private String country;

	/**
	 * @return the country
	 */
	public String getCountry() {
		return country;
	}

	/**
	 * @param country
	 *            the country to set
	 */
	public void setCountry(String country) {
		this.country = country;
	}

	/**
	 * @return the uid
	 */
	public String getUid() {
		return uid;
	}

	/**
	 * @param uid
	 *            the uid to set
	 */
	public void setUid(String uid) {
		this.uid = uid;
	}

	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password
	 *            the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	/**
	 * @return the artistSuggestion
	 */
	public Map<Integer, String> getArtistSuggestion() {
		return artistSuggestion;
	}

	/**
	 * @param artistSuggestion
	 *            the artistSuggestion to set
	 */
	public void setArtistSuggestion(Map<Integer, String> artistSuggestion) {
		this.artistSuggestion = artistSuggestion;
	}

	/**
	 * @return the suggestionList
	 */
	public String getSuggestionList() {
		return suggestionList;
	}

	/**
	 * @param suggestionList
	 *            the suggestionList to set
	 */
	public void setSuggestionList(String suggestionList) {
		this.suggestionList = suggestionList;
	}

	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	final private String ECHONEST_URL = "https://www.googleapis.com/customsearch/v1?";
	// api key
	final private String API_KEY = "AIzaSyB8sw41AAazfbjRs0debg59OUr-Oy80pNY";

	// final private String API_KEY = "AIzaSyB8DIS_XUkixfmQYgzPsH2zIZpM7TawzJE";
	// custom search engine ID

	public String getResponse() {
		return response;
	}

	public void setResponse(String response) {
		this.response = response;
	}

	public String getVal() {
		String ret = SUCCESS;
		return ret;
	}

	public String loadPage() {
		String ret = SUCCESS;
		return ret;
	}

	public String loadSuggestions() {
		String ret = SUCCESS;
		List<SearchArtistTO> suggestions = new ArrayList<SearchArtistTO>();
		if (this.searchText.length() > 2) {
			Map<Integer, String> retMap = new HashMap<Integer, String>();
			try {
				retMap = new BrowseArtistService().loadArtists(this.searchText);
				Iterator<Integer> iter = retMap.keySet().iterator();
				SearchArtistTO temp;
				int artistid;
				while (iter.hasNext()) {
					temp = new SearchArtistTO();
					artistid = iter.next();
					temp.setArtistId(artistid);
					temp.setArtistName(retMap.get(artistid));
					suggestions.add(temp);
				}
			} catch (SQLException sq) {
				System.out.println("SqlException Occured");
			} catch (IOException io) {
				System.out.println("IOException Occured");
			} catch (Exception e) {
				System.out.println("Exception Occured");
			}
			Gson gson = new Gson();
			this.suggestionList = gson.toJson(suggestions);
			// System.out.println(suggestionList.toString());
		}
		return ret;
	}

	public String loadSuggestionsLocation() {
		String ret = SUCCESS;
		System.out.println(country);
		List<SearchArtistTO> suggestions = new ArrayList<SearchArtistTO>();
		Map<Integer, String> retMap = new HashMap<Integer, String>();
		try {
			retMap = new BrowseArtistService().loadArtistsLocation(this.country);
			Iterator<Integer> iter = retMap.keySet().iterator();
			SearchArtistTO temp;
			int artistid;
			while (iter.hasNext()) {
				temp = new SearchArtistTO();
				artistid = iter.next();
				temp.setArtistId(artistid);
				temp.setArtistName(retMap.get(artistid));
				suggestions.add(temp);
			}
		} catch (SQLException sq) {
			System.out.println("SqlException Occured");
		} catch (IOException io) {
			System.out.println("IOException Occured");
		} catch (Exception e) {
			System.out.println("Exception Occured");
		}
		Gson gson = new Gson();
		this.suggestionList = gson.toJson(suggestions);
		// System.out.println(suggestionList.toString());
		return ret;
	}

	public String login() {
		clearErrorsAndMessages();
		String ret = SUCCESS;
		String userName = "";
		if (uid == null || uid.isEmpty()) {
			addActionError("User Id can't be blank");
		} else if (password == null || password.isEmpty()) {
			addActionError("Password Can't be blank");
		} else {
			try {
				// System.out.println(uid+"....."+password);
				userName = new BrowseArtistService().verifyLogin(uid, password);
				if (userName.equals("none")) {
					addActionError("Please enter valid credentials");
				} else {
					session.put("artistName", userName);
					session.put("artistId", uid);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return ret;
	}

	public String logout() {
		clearErrorsAndMessages();
		String ret = SUCCESS;
		session.put("artistName", null);
		return ret;
	}

	public String loadHome() {
		clearErrorsAndMessages();
		String ret = SUCCESS;
		return ret;
	}
}
