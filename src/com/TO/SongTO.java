package com.TO;

import java.util.Date;

public class SongTO {
	private String youtubeId;
	private Integer artistId;
	private String songName;
	private String youtubeName;
	private String url;
	private Integer releaseDate;
	private Integer decade;
	private Date youtubeDate;
	private Date crawlDate;
	private Integer viewCount;
	private Integer crawlDelta;
	private float rating;
	private float viewCountRate;
	private String duration;
	private String songLanguage;

	/**
	 * @return the youtubeId
	 */
	public String getYoutubeId() {
		return youtubeId;
	}

	/**
	 * @param youtubeId
	 *            the youtubeId to set
	 */
	public void setYoutubeId(String youtubeId) {
		this.youtubeId = youtubeId;
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
	 * @return the songName
	 */
	public String getSongName() {
		return songName;
	}

	/**
	 * @param songName
	 *            the songName to set
	 */
	public void setSongName(String songName) {
		this.songName = songName;
	}

	/**
	 * @return the youtubeName
	 */
	public String getYoutubeName() {
		return youtubeName;
	}

	/**
	 * @param youtubeName
	 *            the youtubeName to set
	 */
	public void setYoutubeName(String youtubeName) {
		this.youtubeName = youtubeName;
	}

	/**
	 * @return the url
	 */
	public String getUrl() {
		return url;
	}

	/**
	 * @param url
	 *            the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * @return the releaseDate
	 */
	public Integer getReleaseDate() {
		return releaseDate;
	}

	/**
	 * @param releaseDate
	 *            the releaseDate to set
	 */
	public void setReleaseDate(Integer releaseDate) {
		this.releaseDate = releaseDate;
	}

	/**
	 * @return the decade
	 */
	public Integer getDecade() {
		return decade;
	}

	/**
	 * @param decade
	 *            the decade to set
	 */
	public void setDecade(Integer decade) {
		this.decade = decade;
	}

	/**
	 * @return the youtubeDate
	 */
	public Date getYoutubeDate() {
		return youtubeDate;
	}

	/**
	 * @param youtubeDate
	 *            the youtubeDate to set
	 */
	public void setYoutubeDate(Date youtubeDate) {
		this.youtubeDate = youtubeDate;
	}

	/**
	 * @return the crawlDate
	 */
	public Date getCrawlDate() {
		return crawlDate;
	}

	/**
	 * @param crawlDate
	 *            the crawlDate to set
	 */
	public void setCrawlDate(Date crawlDate) {
		this.crawlDate = crawlDate;
	}

	/**
	 * @return the viewCount
	 */
	public Integer getViewCount() {
		return viewCount;
	}

	/**
	 * @param viewCount
	 *            the viewCount to set
	 */
	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	/**
	 * @return the crawlDelta
	 */
	public Integer getCrawlDelta() {
		return crawlDelta;
	}

	/**
	 * @param crawlDelta
	 *            the crawlDelta to set
	 */
	public void setCrawlDelta(Integer crawlDelta) {
		this.crawlDelta = crawlDelta;
	}

	/**
	 * @return the rating
	 */
	public float getRating() {
		return rating;
	}

	/**
	 * @param rating
	 *            the rating to set
	 */
	public void setRating(float rating) {
		this.rating = rating;
	}

	/**
	 * @return the viewCountRate
	 */
	public float getViewCountRate() {
		return viewCountRate;
	}

	/**
	 * @param viewCountRate
	 *            the viewCountRate to set
	 */
	public void setViewCountRate(float viewCountRate) {
		this.viewCountRate = viewCountRate;
	}

	/**
	 * @return the duration
	 */
	public String getDuration() {
		return duration;
	}

	/**
	 * @param duration
	 *            the duration to set
	 */
	public void setDuration(String duration) {
		this.duration = duration;
	}

	/**
	 * @return the songLanguage
	 */
	public String getSongLanguage() {
		return songLanguage;
	}

	/**
	 * @param songLanguage
	 *            the songLanguage to set
	 */
	public void setSongLanguage(String songLanguage) {
		this.songLanguage = songLanguage;
	}

	/**
	 * @return the songCountry
	 */
	public String getSongCountry() {
		return songCountry;
	}

	/**
	 * @param songCountry
	 *            the songCountry to set
	 */
	public void setSongCountry(String songCountry) {
		this.songCountry = songCountry;
	}

	private String songCountry;

}
