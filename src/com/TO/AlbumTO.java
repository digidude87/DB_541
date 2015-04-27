package com.TO;

import java.util.List;

public class AlbumTO {
	private String albumName;
	private String albumCountry;
	private String albumLanguage;
	private String albumBarCode;
	private String songId;
	private Integer albumId;
	private List<SongTO> songs;

	public List<SongTO> getSongs() {
		return songs;
	}

	public void setSongs(List<SongTO> songs) {
		this.songs = songs;
	}

	/**
	 * @return the albumName
	 */
	public String getAlbumName() {
		return albumName;
	}

	/**
	 * @param albumName
	 *            the albumName to set
	 */
	public void setAlbumName(String albumName) {
		this.albumName = albumName;
	}

	/**
	 * @return the albumCountry
	 */
	public String getAlbumCountry() {
		return albumCountry;
	}

	/**
	 * @param albumCountry
	 *            the albumCountry to set
	 */
	public void setAlbumCountry(String albumCountry) {
		this.albumCountry = albumCountry;
	}

	/**
	 * @return the albumLanguage
	 */
	public String getAlbumLanguage() {
		return albumLanguage;
	}

	/**
	 * @param albumLanguage
	 *            the albumLanguage to set
	 */
	public void setAlbumLanguage(String albumLanguage) {
		this.albumLanguage = albumLanguage;
	}

	/**
	 * @return the albumBarCode
	 */
	public String getAlbumBarCode() {
		return albumBarCode;
	}

	/**
	 * @param albumBarCode
	 *            the albumBarCode to set
	 */
	public void setAlbumBarCode(String albumBarCode) {
		this.albumBarCode = albumBarCode;
	}

	/**
	 * @return the songId
	 */
	public String getSongId() {
		return songId;
	}

	/**
	 * @param songId
	 *            the songId to set
	 */
	public void setSongId(String songId) {
		this.songId = songId;
	}

	/**
	 * @return the albumId
	 */
	public Integer getAlbumId() {
		return albumId;
	}

	/**
	 * @param albumId
	 *            the albumId to set
	 */
	public void setAlbumId(Integer albumId) {
		this.albumId = albumId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((albumId == null) ? 0 : albumId.hashCode());
		result = prime * result
				+ ((albumName == null) ? 0 : albumName.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AlbumTO other = (AlbumTO) obj;
		if (albumId == null) {
			if (other.albumId != null)
				return false;
		} else if (!albumId.equals(other.albumId))
			return false;
		if (albumName == null) {
			if (other.albumName != null)
				return false;
		} else if (!albumName.equals(other.albumName))
			return false;
		return true;
	}

}
