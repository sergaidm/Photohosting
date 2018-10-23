package ru.yandex.sergaidm.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import ru.yandex.sergaidm.model.Album;
import ru.yandex.sergaidm.model.CustomUser;
import ru.yandex.sergaidm.model.Photo;
import ru.yandex.sergaidm.repository.AlbumRepository;

@Service
public class AlbumService {

	@Autowired
	private AlbumRepository albumRepository;

	public Iterable<Album> findAllAlbums(CustomUser user) {
		return albumRepository.findAllByAuthorOrderByIdAsc(user);
	}

	public void addAlbum(CustomUser author, String albumName, String description) {
		LocalDateTime creationDate = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm, dd.MM.yyyy");
		albumRepository.save(new Album(albumName, description, dtf.format(creationDate), author));
	}

	public void saveAlbumDescription(Album album, String description) {
		album.setDescription(description);
		albumRepository.save(album);
	}

	public void deleteAlbum(Album album) {
		albumRepository.deleteById(album.getId());
	}

	public void saveAlbumName(Album album, String albumTitle) {
		album.setAlbumName(albumTitle);
		albumRepository.save(album);
	}

	public ResponseEntity<byte[]> showAlbumCover(Photo photo) {
		byte[] data = photo.getData();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_JPEG);
		return new ResponseEntity<byte[]>(data, headers, HttpStatus.OK);
	}

}