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
		//System.out.println(this.artistId);
		return ret;
	}
	
	public String underConstruction(){
		String ret = SUCCESS;
		//System.out.println(this.artistId);
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
			artistTO.setArtistDescription("abcdabcdabcd abcdbabcdbbc dnandasdna asdasjdansda ioasdalkds ioasdansdm a dioasdandsa daoisdakda, sdasdnaklnds");
			this.artistDetails = gson.toJson(artistTO);
			System.out.println(this.artistDetails);
			Map<AlbumTO, List<SongTO>> albumsAll = new ArtistService()
					.loadAlbums(Integer.parseInt(artistId));
			Iterator<AlbumTO> iter = albumsAll.keySet().iterator();
			this.albums = new ArrayList<AlbumTO>();
			while(iter.hasNext()){
				this.albums.add(iter.next());
			}
			this.session.put("albums", albumsAll);
			this.albumList = gson.toJson(albums);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	public String loadSongs(){
		Map<AlbumTO, List<SongTO>> albums = new HashMap<AlbumTO, List<SongTO>>();
		albums=(Map<AlbumTO, List<SongTO>>) this.session.get("albums");
		Iterator<AlbumTO> iter = albums.keySet().iterator();
		List<SongTO> songs = new ArrayList<SongTO>();
		AlbumTO temp;
		while(iter.hasNext()){
			temp = iter.next();
			if(temp.getAlbumId()== Integer.parseInt(this.albumId)){
				songs = albums.get(temp);
			}
		}
		Gson gson = new Gson();
		this.songList = gson.toJson(songs); 
		return SUCCESS;
	}
}
