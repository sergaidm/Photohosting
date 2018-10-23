package ru.yandex.sergaidm.service;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.util.List;

import org.apache.commons.compress.archivers.ArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ru.yandex.sergaidm.model.Album;
import ru.yandex.sergaidm.model.Photo;
import ru.yandex.sergaidm.repository.AlbumRepository;
import ru.yandex.sergaidm.repository.PhotoRepository;

@Service
public class PhotoService {

	@Autowired
	private PhotoRepository photoRepository;
	@Autowired
	private AlbumRepository albumRepository;

	public Iterable<Photo> findAllPhotos(Album album) {
		return photoRepository.findAllByAlbum(album);
	}

	public void setAlbumCover(Album album, Iterable<Photo> photos) {
		for (Photo photo : photos) {
			album.setCover(photo.getId());
			albumRepository.save(album);
			break;
		}
	}

	public void addPhotos(Album album, List<MultipartFile> files) throws IOException {
		for (MultipartFile file : files) {
			photoRepository.save(new Photo(file.getBytes(), album));
		}
	}

	public void deletePhotos(List<Integer> id) {
		for (Integer number : id) {
			photoRepository.deleteById(number);
		}
	}

	public ResponseEntity<byte[]> showPhoto(Photo photo) {
		byte[] data = photo.getData();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_JPEG);
		return new ResponseEntity<byte[]>(data, headers, HttpStatus.OK);
	}

	private ResponseEntity<Object> downloadEmptyAlbum(Album album, RedirectAttributes attributes) {
		attributes.addFlashAttribute("message", "В альбоме отсутствуют фотографии для скачивания!");
		HttpHeaders headers = new HttpHeaders();
		headers.setLocation(URI.create("/albums"));
		return new ResponseEntity<>(headers, HttpStatus.MOVED_PERMANENTLY);
	}

	private ResponseEntity<Object> downloadAlbumWithPhotos(Album album) throws IOException {
		Iterable<Photo> photos = photoRepository.findAllByAlbum(album);
		String filename = album.getAlbumName() + ".zip";
		File file = new File(filename);
		try (ZipArchiveOutputStream zout = new ZipArchiveOutputStream(new FileOutputStream(file))) {
			zout.setEncoding("cp866");
			for (Photo photo : photos) {
				ArchiveEntry archiveEntry = zout.createArchiveEntry(file, photo.getId() + ".jpg");
				zout.putArchiveEntry(archiveEntry);
				try (ByteArrayInputStream fis = new ByteArrayInputStream(photo.getData())) {
					byte[] buffer = new byte[8192];
					int length = -1;
					while (-1 != (length = fis.read(buffer))) {
						zout.write(buffer, 0, length);
					}
				}
				zout.closeArchiveEntry();
			}
		}
		InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", String.format("attachment; filename=\"%s\"", file.getName()));
		headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
		headers.add("Pragma", "no-cache");
		headers.add("Expires", "0");
		ResponseEntity<Object> responseEntity = ResponseEntity.ok().headers(headers).contentLength(file.length())
				.contentType(MediaType.parseMediaType("application/zip")).body(resource);
		return responseEntity;
	}

	public ResponseEntity<Object> downloadAlbum(Album album, RedirectAttributes attributes) throws IOException {
		Iterable<Photo> photos = photoRepository.findAllByAlbum(album);
		int size = 0;
		for (Photo photo : photos) {
			size++;
		}
		if (size == 0) {
			return downloadEmptyAlbum(album, attributes);
		} else {
			return downloadAlbumWithPhotos(album);
		}
	}

}