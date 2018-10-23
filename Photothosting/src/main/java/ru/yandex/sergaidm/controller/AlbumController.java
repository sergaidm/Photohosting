package ru.yandex.sergaidm.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import ru.yandex.sergaidm.model.Album;
import ru.yandex.sergaidm.model.CustomUser;
import ru.yandex.sergaidm.model.Photo;
import ru.yandex.sergaidm.service.AlbumService;

@Controller
@EnableWebMvc
@SessionAttributes({"albumId", "user"})
@RequestMapping("/albums")
public class AlbumController {

	@Autowired
	private AlbumService albumService;

	@GetMapping
	public String albumsPage(@AuthenticationPrincipal CustomUser user, Model model) {
		model.addAttribute("albums", albumService.findAllAlbums(user));
		model.addAttribute("author", user.getUsername());
		model.addAttribute("user", user);
		return "albums";
	}
	
	@GetMapping("/")
	public String redirectToAlbumsPage() {		
		return "redirect:/albums";
	}

	@PostMapping("/add_album")
	public String addAlbum(@AuthenticationPrincipal CustomUser author, @RequestParam("album_name") String albumName,
			@RequestParam("description") String description, Model model) throws IOException {
		albumService.addAlbum(author, albumName, description);		
		model.addAttribute("author", author.getUsername());
		return "redirect:/albums";
	}
	
	@PostMapping("/change_description")
	public String changeAlbumDescription(@RequestParam("id") Album album, @RequestParam("description") String description, Model model) throws IOException {		
		albumService.saveAlbumDescription(album, description);		
		return "redirect:/albums";
	}

	@PostMapping("/delete_album")
	public String deleteAlbum(@RequestParam("id") Album album, Model model) throws IOException {
		albumService.deleteAlbum(album);	
		return "redirect:/albums";
	}
	
	@PostMapping("/{album_title}/change_album_name")
	public String changeAlbumName(@RequestParam("albumId") Album album, @RequestParam("album_title") String albumTitle, Model model) throws IOException {		
		albumService.saveAlbumName(album, albumTitle);
		model.addAttribute("albumId", album.getId());
		model.addAttribute("album_title", albumTitle);
		return "redirect:/albums/{album_title}";
	}
	
	@GetMapping("/view_cover/{album.getCover()}")
	public ResponseEntity<byte[]> albumCover(@PathVariable("album.getCover()") Photo photo) {
		return albumService.showAlbumCover(photo);
	}
	
}