package ru.yandex.sergaidm.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ru.yandex.sergaidm.model.Album;
import ru.yandex.sergaidm.model.Photo;
import ru.yandex.sergaidm.service.PhotoService;

@Controller
@EnableWebMvc
@RequestMapping("/albums/{album_name}")
@SessionAttributes({"albumId", "albumName", "photos"})
public class PhotoController {

	@Autowired
	private PhotoService photoService;

	@RequestMapping
	public String album(@RequestParam("albumId") Album album, Model model) {
		photoService.setAlbumCover(album, photoService.findAllPhotos(album));		
		model.addAttribute("photos", photoService.findAllPhotos(album));
		model.addAttribute("album_title", album.getAlbumName());
		model.addAttribute("albumName", album.getAlbumName());
		model.addAttribute("albumId", album.getId());
		return "photos";
	}

	@GetMapping("/")
	public String redirectToAlbum() {
		return "redirect:/albums/{album_name}";
	}

	@PostMapping("/add_photos")
	public String addPhotos(@RequestParam("albumId") Album album, @RequestParam("images") List<MultipartFile> files, Model model) throws IOException {
		photoService.addPhotos(album, files);
		model.addAttribute("albumId", album.getId());
		return "redirect:/albums/{album_name}";
	}
	
	@PostMapping("/delete_photos")
	public String deletePhotos(@RequestParam("checkbox") List<Integer> id, Model model) {
		photoService.deletePhotos(id);
		return "redirect:/albums/{album_name}";
	}

	@GetMapping("/view_photo/{photo_id}")
	public ResponseEntity<byte[]> photo(@PathVariable("photo_id") Photo photo) {
		return photoService.showPhoto(photo);
	}

	@RequestMapping("/download_album")
	public ResponseEntity<Object> downloadAlbum(@RequestParam("id") Album album, RedirectAttributes attributes) throws IOException {		
		return photoService.downloadAlbum(album, attributes);
	}

}