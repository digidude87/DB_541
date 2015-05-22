package com.TO;

public class SearchArtistTO {
	private int artistId;
	private String artistName;
	private String artistAlias;
	/**
	 * @return the artistAlias
	 */
	public String getArtistAlias() {
		return artistAlias;
	}

	/**
	 * @param artistAlias the artistAlias to set
	 */
	public void setArtistAlias(String artistAlias) {
		this.artistAlias = artistAlias;
	}

	/**
	 * @return the artistId
	 */
	public int getArtistId() {
		return artistId;
	}

	/**
	 * @param artistId
	 *            the artistId to set
	 */
	public void setArtistId(int artistId) {
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
}
