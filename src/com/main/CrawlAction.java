package com.main;

import com.google.code.jspot.Results;
import com.google.code.jspot.Spotify;
import com.google.code.jspot.Track;
import com.opensymphony.xwork2.ActionSupport;

public class CrawlAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public String crawl() {
		try {
			Spotify spotify = new Spotify();

			Results<Track> results = spotify.searchTrack("artist:weezer");
			for (Track track : results.getItems()) {
				System.out.printf("%.2f %s // %s // %s\n", track
						.getPopularity(), track.getArtistName(), track
						.getAlbum().getName(), track.getName());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
}
