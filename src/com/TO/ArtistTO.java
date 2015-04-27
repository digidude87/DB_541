package com.TO;

import java.util.List;

public class ArtistTO {
	private Integer artistId;
	private String artistName;
	private Integer artistPopularityAll;
	private Integer artistPopularityRecent;
	private List<AlbumTO> albums;
	private String artistDescription;

	public String getArtistDescription() {
		return artistDescription;
	}

	public void setArtistDescription(String artistDescription) {
		this.artistDescription = artistDescription;
	}

	public List<AlbumTO> getAlbums() {
		return albums;
	}

	public void setAlbums(List<AlbumTO> albums) {
		this.albums = albums;
	}

	/**
	 * @return the artistId
	 */
	public Integer getArtistId() {
		return artistId;
	}

	/**
	 * @param artistId
	 *            the artistId to set
	 */
	public void setArtistId(Integer artistId) {
		this.artistId = artistId;
	}

	/**
	 * @return the artistName
	 */
	public String getArtistName() {
		return artistName;
	}

	/**
	 * @param artistName
	 *            the artistName to set
	 */
	public void setArtistName(String artistName) {
		this.artistName = artistName;
	}

	/**
	 * @return the artistPopularityAll
	 */
	public Integer getArtistPopularityAll() {
		return artistPopularityAll;
	}

	/**
	 * @param artistPopularityAll
	 *            the artistPopularityAll to set
	 */
	public void setArtistPopularityAll(Integer artistPopularityAll) {
		this.artistPopularityAll = artistPopularityAll;
	}

	/**
	 * @return the artistPopularityRecent
	 */
	public Integer getArtistPopularityRecent() {
		return artistPopularityRecent;
	}

	/**
	 * @param artistPopularityRecent
	 *            the artistPopularityRecent to set
	 */
	public void setArtistPopularityRecent(Integer artistPopularityRecent) {
		this.artistPopularityRecent = artistPopularityRecent;
	}

}
