package com.main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.Service.ArtistService;
import com.TO.AlbumTO;
import com.TO.ArtistTO;
import com.TO.SongTO;
import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class ArtistAction extends ActionSupport implements SessionAware {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String response;
	private static String artistId;
	private Map<Integer, String> artistSuggestion;
	Map<String, Object> session;
	private List<AlbumTO> albums;
	private List<SongTO> songs;
	private String artistDetails;
	private String albumList;
	private String albumId;
	private String songList;
	private String songInfoList;
	private String searchArtist;
	private String albumInfoList;
	private String crawlInfoList;

	/**
	 * @return the albumInfoList
	 */
	public String getAlbumInfoList() {
		return albumInfoList;
	}

	/**
	 * @param albumInfoList the albumInfoList to set
	 */
	public void setAlbumInfoList(String albumInfoList) {
		this.albumInfoList = albumInfoList;
	}

	/**
	 * @return the crawlInfoList
	 */
	public String getCrawlInfoList() {
		return crawlInfoList;
	}

	/**
	 * @param crawlInfoList the crawlInfoList to set
	 */
	public void setCrawlInfoList(String crawlInfoList) {
		this.crawlInfoList = crawlInfoList;
	}

	/**
	 * @return the searchArtist
	 */
	public String getSearchArtist() {
		return searchArtist;
	}

	/**
	 * @param searchArtist the searchArtist to set
	 */
	public void setSearchArtist(String searchArtist) {
		this.searchArtist = searchArtist;
	}

	/**
	 * @return the songInfoList
	 */
	public String getSongInfoList() {
		return songInfoList;
	}

	/**
	 * @param songInfoList
	 *            the songInfoList to set
	 */
	public void setSongInfoList(String songInfoList) {
		this.songInfoList = songInfoList;
	}

	public String getSongList() {
		return songList;
	}

	public void setSongList(String songList) {
		this.songList = songList;
	}

	public String getAlbumId() {
		return albumId;
	}

	public void setAlbumId(String albumId) {
		this.albumId = albumId;
	}

	public String getAlbumList() {
		return albumList;
	}

	public void setAlbumList(String albumList) {
		this.albumList = albumList;
	}

	public String getArtistDetails() {
		return artistDetails;
	}

	public void setArtistDetails(String artistDetails) {
		this.artistDetails = artistDetails;
	}

	public List<AlbumTO> getAlbums() {
		return albums;
	}

	public void setAlbums(List<AlbumTO> albums) {
		this.albums = albums;
	}

	public List<SongTO> getSongs() {
		return songs;
	}

	public void setSongs(List<SongTO> songs) {
		this.songs = songs;
	}

	/**
	 * @return the artistId
	 */
	public String getArtistId() {
		return artistId;
	}

	/**
	 * @param artistId
	 *            the artistId to set
	 */
	public void setArtistId(String artistId) {
		this.artistId = artistId;
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

	public String loadArtistPage() {
		String ret = SUCCESS;
		// System.out.println(this.artistId);
		return ret;
	}

	public String underConstruction() {
		String ret = SUCCESS;
		// System.out.println(this.artistId);
		return ret;
	}

	public String loadArtistDetails() {
		String ret = SUCCESS;
		// System.out.println("something : " + this.artistId);
		try {
			ArtistTO artistTO = new ArtistService().loadArtist(Integer
					.parseInt(artistId));
			// System.out.println(artistTO.getArtistName());
			Gson gson = new Gson();
			this.artistDetails = gson.toJson(artistTO);
			System.out.println(this.artistDetails);
			Map<AlbumTO, List<SongTO>> albumsAll = new ArtistService()
					.loadAlbums(Integer.parseInt(artistId));
			Iterator<AlbumTO> iter = albumsAll.keySet().iterator();
			this.albums = new ArrayList<AlbumTO>();
			while (iter.hasNext()) {
				this.albums.add(iter.next());
			}
			this.session.put("albums", albumsAll);
			this.albumList = gson.toJson(albums);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

	public String loadSongs() {
		Map<AlbumTO, List<SongTO>> albums = new HashMap<AlbumTO, List<SongTO>>();
		albums = (Map<AlbumTO, List<SongTO>>) this.session.get("albums");
		Iterator<AlbumTO> iter = albums.keySet().iterator();
		List<SongTO> songs = new ArrayList<SongTO>();
		AlbumTO temp;
		while (iter.hasNext()) {
			temp = iter.next();
			if (temp.getAlbumId() == Integer.parseInt(this.albumId)) {
				songs = albums.get(temp);
			}
		}
		Gson gson = new Gson();
		this.songList = gson.toJson(songs);
		return SUCCESS;
	}

	public String loadSongInfo() {
		List<SongTO> songs = new ArrayList<SongTO>();
		Gson gson = new Gson();
		try {
			songs = new ArtistService().loadSongInfo(this.searchArtist);
			this.songInfoList = gson.toJson(songs);
			System.out.println(songInfoList);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String loadAlbumInfo() {
		List<AlbumTO> albums = new ArrayList<AlbumTO>();
		Gson gson = new Gson();
		try {
			albums = new ArtistService().loadAlbumInfo(this.searchArtist);
			this.albumInfoList = gson.toJson(albums);
			System.out.println(albumInfoList);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
}
