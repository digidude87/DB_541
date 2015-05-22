package com.DAO;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.TO.AlbumTO;
import com.TO.ArtistTO;
import com.TO.SongTO;

import database.DBHandler;

public class ArtistDAO {
	public static DBHandler db = new DBHandler();

	public ArtistTO loadArtist(Integer artistId) throws SQLException,
			IOException {
		ArtistTO artist = new ArtistTO();
		String sql = "select distinct artistName,artistPopularityAll,artistPopularityRecent from Artists where artistId = "
				+ artistId;
		ResultSet rs = db.runSql(sql);
		while (rs.next()) {
			artist.setArtistId(artistId);
			artist.setArtistName(rs.getString("artistName"));
			artist.setArtistPopularityAll(rs.getInt("artistPopularityAll"));
			artist.setArtistPopularityRecent(rs
					.getInt("artistPopularityRecent"));
		}
		return artist;
	}

	public Map<String, SongTO> loadSongs(Integer artistId) throws SQLException,
			IOException {
		Map<String, SongTO> songs = new HashMap<String, SongTO>();
		String sql = "select DISTINCT songName, youtubeId, youtubeName, url, artistId, releaseDate, decade, youtubeDate, crawlDate, viewCount, crawlDelta, rating, viewCountRate, duration, songLanguage, songCountry from Songs where artistId = "
				+ artistId;
		ResultSet rs = db.runSql(sql);
		SongTO temp;
		while (rs.next()) {
			temp = new SongTO();
			temp.setArtistId(Integer.parseInt(rs.getString("artistId")));
			temp.setCrawlDate(rs.getDate("crawlDate"));
			temp.setCrawlDelta(rs.getInt("crawlDelta"));
			temp.setDecade(rs.getInt("decade"));
			temp.setDuration(rs.getString("duration"));
			temp.setRating(rs.getInt("rating"));
			temp.setReleaseDate(rs.getInt("releaseDate"));
			temp.setSongCountry(rs.getString("songCountry"));
			temp.setSongLanguage(rs.getString("songLanguage"));
			temp.setSongName(rs.getString("songName"));
			temp.setUrl(rs.getString("url").replace("watch?v=", "v/"));
			temp.setViewCount(rs.getInt("viewCount"));
			temp.setViewCountRate(rs.getFloat("viewCountRate"));
			temp.setYoutubeDate(rs.getDate("youtubeDate"));
			temp.setYoutubeId(rs.getString("youtubeId"));
			temp.setYoutubeName(rs.getString("youtubeName"));
			songs.put(temp.getYoutubeId(), temp);
		}
		return songs;
	}

	public List<AlbumTO> loadAlbums(Integer artistId) throws SQLException,
			IOException {
		List<AlbumTO> albums = new ArrayList<AlbumTO>();
		/* Map<String, SongTO> songsMap = loadSongs(artistId); */
		StringBuffer sql = new StringBuffer(
				"select * from Albumsnew where artistId = "
						+ artistId + " ");
		/*
		 * sql.append("select distinct * from albums where songId IN (\"");
		 * Iterator<String> iter = songsMap.keySet().iterator(); while
		 * (iter.hasNext()) { sql.append(iter.next()); if (iter.hasNext()) {
		 * sql.append("\",\""); } } sql.append("\")");
		 */
		ResultSet rs = db.runSql(sql.toString());
		AlbumTO temp;
		int count = 0;
		String albumName = "";
		List<String> uniqueAlbums = new ArrayList<String>();
		while (rs.next()) {
			temp = new AlbumTO();
			albumName = rs.getString("albumName");
			if (albumName.matches("\\A\\p{ASCII}*\\z")) {
				if (!uniqueAlbums.contains(albumName)) {
					temp.setAlbumCountry(rs.getString("albumCountry"));
					// temp.setAlbumId(rs.getInt("albumId"));
					temp.setAlbumLanguage(rs.getString("albumLanguage"));
					temp.setAlbumName(albumName);
					// temp.setSongId(rs.getString("songId"));
					albums.add(temp);
					uniqueAlbums.add(albumName);
				}
			}
			count++;
		}
		/*
		 * System.out.println("Album Count : " + count); List<SongTO> tempSongs;
		 * Map<AlbumTO, List<SongTO>> retAlbums = new HashMap<AlbumTO,
		 * List<SongTO>>(); for (AlbumTO album : albums) { tempSongs =
		 * retAlbums.get(album); if (tempSongs == null) { tempSongs = new
		 * ArrayList<SongTO>(); }
		 * tempSongs.add(songsMap.get(album.getSongId())); retAlbums.put(album,
		 * tempSongs); } System.out.println("Album Count in Map : " +
		 * retAlbums.keySet().size());
		 */
		return albums;
	}

	public List<SongTO> loadSongInfo(String artistId) throws SQLException,
			IOException {
		List<SongTO> songs = new ArrayList<SongTO>();
		String sql = "select distinct songName, youtubeId, youtubeName, url, artistId, releaseDate, decade, youtubeDate, crawlDate, viewCount, crawlDelta, rating, viewCountRate, duration, songLanguage, songCountry from Songs where artistId = \""
				+ artistId + "\"";
		ResultSet rs = db.runSql(sql);
		SongTO temp;
		while (rs.next()) {
			temp = new SongTO();
			temp.setArtistId(Integer.parseInt(rs.getString("artistId")));
			temp.setCrawlDate(rs.getDate("crawlDate"));
			temp.setCrawlDelta(rs.getInt("crawlDelta"));
			temp.setDecade(rs.getInt("decade"));
			temp.setDuration(rs.getString("duration"));
			temp.setRating(rs.getInt("rating"));
			temp.setReleaseDate(rs.getInt("releaseDate"));
			temp.setSongCountry(rs.getString("songCountry"));
			temp.setSongLanguage(rs.getString("songLanguage"));
			temp.setSongName(rs.getString("songName"));
			temp.setUrl(rs.getString("url").replace("watch?v=", "v/"));
			temp.setViewCount(rs.getInt("viewCount"));
			temp.setViewCountRate(rs.getFloat("viewCountRate"));
			temp.setYoutubeDate(rs.getDate("youtubeDate"));
			temp.setYoutubeId(rs.getString("youtubeId"));
			temp.setYoutubeName(rs.getString("youtubeName"));
			songs.add(temp);
		}
		return songs;
	}

	public List<AlbumTO> loadAlbumInfo(String artistId) throws SQLException,
			IOException {
		List<AlbumTO> albums = new ArrayList<AlbumTO>();
		String sql = "select * from Albumsnew where artistId = "
				+ artistId;
		ResultSet rs = db.runSql(sql);
		AlbumTO temp;
		while (rs.next()) {
			temp = new AlbumTO();
			temp.setAlbumBarCode(rs.getString("albumBarCode"));
			temp.setAlbumCountry(rs.getString("albumCountry"));
			temp.setAlbumId(rs.getInt("albumId"));
			temp.setAlbumLanguage(rs.getString("albumLanguage"));
			temp.setAlbumName(rs.getString("albumName"));
			temp.setSongId(rs.getString("songId"));
			albums.add(temp);
		}
		return albums;
	}

	public List<ArtistTO> loadArtistBio(String artistId) throws SQLException,
			IOException {
		List<ArtistTO> artists = new ArrayList<ArtistTO>();
		String sql = "select distinct a.artistName, a.artistPopularityAll,a.artistPopularityRecent, b.artistAlias from Artists a, ArtistAlias b where a.artistId = b.artistId and b.artistId = "
				+ artistId;
		ResultSet rs = db.runSql(sql);
		ArtistTO temp;
		while (rs.next()) {
			temp = new ArtistTO();
			temp.setArtistId(Integer.parseInt(artistId));
			temp.setArtistName(rs.getString("artistName"));
			temp.setArtistPopularityAll(rs.getInt("artistPopularityAll"));
			temp.setArtistPopularityRecent(rs.getInt("artistPopularityRecent"));
			temp.setArtistAlias(rs.getString("artistAlias"));
			artists.add(temp);
		}
		return artists;
	}

	public ArtistTO fetchMaxPopularity(ArtistTO artist) throws SQLException,
			IOException {
		String sql = "select max(artistPopularityRecent) as maxRecent, max(artistPopularityAll) as maxAll from Artists";
		ResultSet rs = db.runSql(sql);
		while (rs.next()) {
			artist.setMaxRecent(rs.getString("maxRecent"));
			artist.setMaxAll(rs.getString("maxAll"));
		}
		return artist;
	}

	public List<SongTO> loadSongList(String albumName, String artistId)
			throws SQLException, IOException {
		List<SongTO> songs = new ArrayList<SongTO>();
		// albumName = Normalizer.normalize(albumName, Normalizer.Form.NFD);
		// albumName = albumName.replaceAll("[^\\x00-\\x7F]", "");
		// albumName = albumName.replaceAll("[^\\x20-\\x7e-\\n-\\r]", "_");
		// albumName = albumName.replaceAll("", arg1)
		// System.out.println("Album Name : "+albumName);
		/*
		 * Pattern p = Pattern.compile("\\\\u(\\p{XDigit}{4})"); Matcher m =
		 * p.matcher(albumName); StringBuffer buf = new
		 * StringBuffer(albumName.length()); while (m.find()) { String ch =
		 * String.valueOf((char) Integer.parseInt(m.group(1), 16));
		 * m.appendReplacement(buf, Matcher.quoteReplacement(ch)); }
		 * m.appendTail(buf); System.out.println("Album Name : "+buf);
		 */
		// System.out.println("Album Name : "+albumName);
		// System.out.println(albumName);
		albumName = albumName.replaceAll("\"", "\\\\\"");
		// System.out.println(albumName);
		String query = "select songId from Albums where albumName like \""
				+ albumName + "\" escape '\'";
		ResultSet rs = db.runSql(query);
		SongTO temp;
		String tempId;
		List<String> songIds = new ArrayList<String>();
		while (rs.next()) {
			tempId = rs.getString("songId");
			if (!songIds.contains(tempId)) {
				songIds.add(tempId);
			}
		}
		if (songIds.size() > 0) {
			StringBuffer sql = new StringBuffer(
					"select songName, youtubeId, youtubeName, url, artistId, releaseDate, decade, youtubeDate, crawlDate, viewCount, crawlDelta, rating, viewCountRate, duration, songLanguage, songCountry from Songs where artistId = \""
							+ artistId + "\" and youtubeId IN(");
			Iterator<String> iter = songIds.iterator();
			while (iter.hasNext()) {
				sql.append("\"" + iter.next() + "\"");
				if (iter.hasNext()) {
					sql.append(",");
				} else {
					sql.append(")");
				}
			}
			rs = db.runSql(sql.toString());
			while (rs.next()) {
				temp = new SongTO();
				temp.setArtistId(Integer.parseInt(rs.getString("artistId")));
				temp.setCrawlDate(rs.getDate("crawlDate"));
				temp.setCrawlDelta(rs.getInt("crawlDelta"));
				temp.setDecade(rs.getInt("decade"));
				temp.setDuration(rs.getString("duration"));
				temp.setRating(rs.getInt("rating"));
				temp.setReleaseDate(rs.getInt("releaseDate"));
				temp.setSongCountry(rs.getString("songCountry"));
				temp.setSongLanguage(rs.getString("songLanguage"));
				temp.setSongName(rs.getString("songName"));
				temp.setUrl(rs.getString("url").replace("watch?v=", "v/"));
				temp.setViewCount(rs.getInt("viewCount"));
				temp.setViewCountRate(rs.getFloat("viewCountRate"));
				temp.setYoutubeDate(rs.getDate("youtubeDate"));
				temp.setYoutubeId(rs.getString("youtubeId"));
				temp.setYoutubeName(rs.getString("youtubeName"));
				songs.add(temp);
			}
		}
		return songs;
	}

	public List<SongTO> loadTopSongList(String artistId) throws SQLException,
			IOException {
		List<SongTO> songs = new ArrayList<SongTO>();
		// System.out.println(albumName);
		SongTO temp;
		StringBuffer sql = new StringBuffer(
				"select distinct songName, youtubeId, youtubeName, url, artistId, releaseDate, decade, youtubeDate, crawlDate, viewCount, crawlDelta, rating, viewCountRate, duration, songLanguage, songCountry from Songs where artistId = \""
						+ artistId + "\" order by viewCount desc limit 10");
		ResultSet rs = db.runSql(sql.toString());
		while (rs.next()) {
			temp = new SongTO();
			temp.setArtistId(Integer.parseInt(rs.getString("artistId")));
			temp.setCrawlDate(rs.getDate("crawlDate"));
			temp.setCrawlDelta(rs.getInt("crawlDelta"));
			temp.setDecade(rs.getInt("decade"));
			temp.setDuration(rs.getString("duration"));
			temp.setRating(rs.getInt("rating"));
			temp.setReleaseDate(rs.getInt("releaseDate"));
			temp.setSongCountry(rs.getString("songCountry"));
			temp.setSongLanguage(rs.getString("songLanguage"));
			temp.setSongName(rs.getString("songName"));
			temp.setUrl(rs.getString("url").replace("watch?v=", "v/"));
			temp.setViewCount(rs.getInt("viewCount"));
			temp.setViewCountRate(rs.getFloat("viewCountRate"));
			temp.setYoutubeDate(rs.getDate("youtubeDate"));
			temp.setYoutubeId(rs.getString("youtubeId"));
			temp.setYoutubeName(rs.getString("youtubeName"));
			songs.add(temp);
		}
		return songs;
	}

	public String loadGenre(String artistId) throws SQLException, IOException {
		String genre = "";
		String sql = "Select name from genresnew where artistId = " + artistId
				+ " limit 1";
		ResultSet rs = db.runSql(sql.toString());
		while (rs.next()) {
			genre = rs.getString("name");
		}
		return genre;
	}

	public String loadCountry(String artistId) throws SQLException, IOException {
		String genre = "";
		String sql = "Select songCountry from Songs where artistId = "
				+ artistId + " limit 1";
		ResultSet rs = db.runSql(sql.toString());
		while (rs.next()) {
			genre = rs.getString("songCountry");
		}
		return genre;
	}

	public List<ArtistTO> suggestArtists(String artistId) throws SQLException,
			IOException {
		String genre = loadGenre(artistId);
		String country = loadCountry(artistId);
		List<ArtistTO> suggestions = new ArrayList<ArtistTO>();
		String sql = "select distinct artistId from genresnew where name = '"
				+ genre + "' and artistId <> " + artistId + " limit 8";
		ResultSet rs = db.runSql(sql.toString());

		List<String> artistIds = new ArrayList<String>();
		String temp = "";
		while (rs.next()) {
			temp = new String();
			temp = rs.getString("artistId");
			artistIds.add(temp);
		}
		sql = "select distinct artistId from Songs where songCountry = '"
				+ country + "' and artistId <> " + artistId + " limit 7";
		rs = db.runSql(sql.toString());
		while (rs.next()) {
			temp = new String();
			temp = rs.getString("artistId");
			artistIds.add(temp);
		}
		StringBuffer query = new StringBuffer(
				"select distinct artistId,artistName,artistPopularityAll,artistPopularityRecent from Artists where artistId IN (");
		Iterator<String> iter = artistIds.iterator();
		while (iter.hasNext()) {
			query.append(iter.next());
			if (iter.hasNext()) {
				query.append(",");
			} else {
				query.append(")");
			}
		}
		rs = db.runSql(query.toString());
		ArtistTO artist;
		while (rs.next()) {
			artist = new ArtistTO();
			artist.setArtistId(rs.getInt("artistId"));
			artist.setArtistName(rs.getString("artistName"));
			artist.setArtistPopularityAll(rs.getInt("artistPopularityAll"));
			artist.setArtistPopularityRecent(rs
					.getInt("artistPopularityRecent"));
			suggestions.add(artist);
		}
		return suggestions;
	}
}
