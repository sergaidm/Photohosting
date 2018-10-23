package ru.yandex.sergaidm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import ru.yandex.sergaidm.model.CustomUser;
import ru.yandex.sergaidm.service.UserService;

@Controller
@SessionAttributes({"user", "roles"})
@RequestMapping("/my_profile")
public class ProfileController {

	@Autowired
	private UserService userService;

	@GetMapping
	public String accountPage(@AuthenticationPrincipal CustomUser user, Model model) {	
		CustomUser databaseUser = userService.getUserByUsername(user.getUsername());
		model.addAttribute("username", databaseUser.getUsername());
		model.addAttribute("password", databaseUser.getPassword());
		model.addAttribute("phone", databaseUser.getPhone());
		model.addAttribute("roles", databaseUser.getAuthorities());
		model.addAttribute("user", databaseUser);
		return "my_profile";
	}

	@PostMapping("/update")
	public String updateAccount(@AuthenticationPrincipal CustomUser user, @RequestParam(required = false) String password,
			@RequestParam(required = false) String phone, Model model) {
		userService.updateUser(user, password, phone);
		return "redirect:/my_profile";
	}

}