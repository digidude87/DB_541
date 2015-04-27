package com.Service;

import java.io.IOException;
import java.sql.SQLException;
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

	public Map<AlbumTO, List<SongTO>> loadAlbums(Integer artistId)
			throws SQLException, IOException {
		Map<AlbumTO, List<SongTO>> retAlbums = new HashMap<AlbumTO, List<SongTO>>();
		retAlbums = new ArtistDAO().loadAlbums(artistId);
		return retAlbums;
	}
}
