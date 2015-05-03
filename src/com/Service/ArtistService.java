package com.Service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.DAO.ArtistDAO;
import com.TO.AlbumTO;
import com.TO.ArtistTO;
import com.TO.SongTO;

public class ArtistService {
	public ArtistTO loadArtist(Integer artistId) throws SQLException,
			IOException {
		ArtistTO artistTO = new ArtistTO();
		artistTO = new ArtistDAO().loadArtist(artistId);
		return artistTO;
	}

	public List<AlbumTO> loadAlbums(Integer artistId)
			throws SQLException, IOException {
		/*Map<AlbumTO, List<SongTO>> retAlbums = new HashMap<AlbumTO, List<SongTO>>();*/
		List<AlbumTO> retAlbums = new ArrayList<AlbumTO>();
		retAlbums = new ArtistDAO().loadAlbums(artistId);
		return retAlbums;
	}
	
	public List<SongTO> loadSongInfo(String artistId) throws SQLException, IOException {
		List<SongTO> songs = new ArtistDAO().loadSongInfo(artistId);
		return songs;
	}

	public List<AlbumTO> loadAlbumInfo(String artistId) throws SQLException, IOException {
		List<AlbumTO> albums = new ArtistDAO().loadAlbumInfo(artistId);
		return albums;
	}
	
	public List<ArtistTO> loadArtistBio(String artistId) throws SQLException, IOException {
		List<ArtistTO> artists = new ArtistDAO().loadArtistBio(artistId);
		return artists;
	}
	
	public ArtistTO fetchMaxPopularity(ArtistTO artist) throws SQLException,
	IOException {
		artist = new ArtistDAO().fetchMaxPopularity(artist);
		return artist;
	}
	
	public List<SongTO> loadSongList(String albumName, String albumId) throws SQLException, IOException {
		List<SongTO> songs = new ArtistDAO().loadSongList(albumName,albumId);
		return songs;
	}
}
