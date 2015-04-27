package com.DAO;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.TO.AlbumTO;
import com.TO.ArtistTO;
import com.TO.SongTO;

import database.DBHandler;

public class ArtistDAO {
	public static DBHandler db = new DBHandler();

	public ArtistTO loadArtist(Integer artistId) throws SQLException,
			IOException {
		ArtistTO artist = new ArtistTO();
		String sql = "select distinct * from artistsFixed where artistId = "
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
		String sql = "select DISTINCT * from songs where artistId = "
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

	public Map<AlbumTO, List<SongTO>> loadAlbums(Integer artistId)
			throws SQLException, IOException {
		List<AlbumTO> albums = new ArrayList<AlbumTO>();
		Map<String, SongTO> songsMap = loadSongs(artistId);
		StringBuffer sql = new StringBuffer();
		sql.append("select distinct * from albums where songId IN (\"");
		Iterator<String> iter = songsMap.keySet().iterator();
		while (iter.hasNext()) {
			sql.append(iter.next());
			if (iter.hasNext()) {
				sql.append("\",\"");
			}
		}
		sql.append("\")");
		ResultSet rs = db.runSql(sql.toString());
		AlbumTO temp;
		int count=0;
		while (rs.next()) {
			temp = new AlbumTO();
			temp.setAlbumBarCode(rs.getNString("albumBarCode"));
			temp.setAlbumCountry(rs.getString("albumCountry"));
			temp.setAlbumId(rs.getInt("albumId"));
			temp.setAlbumLanguage(rs.getString("albumLanguage"));
			temp.setAlbumName(rs.getString("albumName"));
			temp.setSongId(rs.getString("songId"));
			albums.add(temp);
			count++;
		}
		System.out.println("Album Count : "+count);
		List<SongTO> tempSongs;
		Map<AlbumTO, List<SongTO>> retAlbums = new HashMap<AlbumTO, List<SongTO>>();
		for (AlbumTO album : albums) {
			tempSongs = retAlbums.get(album);
			if(tempSongs==null){
				tempSongs = new ArrayList<SongTO>();
			}
			tempSongs.add(songsMap.get(album.getSongId()));
			retAlbums.put(album, tempSongs);
		}
		System.out.println("Album Count in Map : "+retAlbums.keySet().size());
		return retAlbums;
	}
}
