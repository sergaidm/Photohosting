package ru.yandex.sergaidm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ru.yandex.sergaidm.model.CustomUser;
import ru.yandex.sergaidm.service.UserService;

@Controller
@SessionAttributes("databaseUser")
public class LoginController {
	
	@Autowired
	private UserService userService;

	@GetMapping("/login")
	public String loginPage(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout, RedirectAttributes attributes,
			Model model) {
		model.addAttribute("error", error != null);
		model.addAttribute("logout", logout != null);
		return "login";
	}

	@PostMapping("/j_spring_security_check")
	public String inactiveUser(@AuthenticationPrincipal CustomUser user) {
		if (!user.isActive()) {
			return "redirect:/login";
		} else {			
			return "redirect:/my_profile";
		}
	} 
	
	@GetMapping("/unauthorized")
	public String unauthorized(@AuthenticationPrincipal CustomUser user, Model model) {
		model.addAttribute("username", user.getUsername());
		return "unauthorized";
	}
	
	@PostMapping("/recover_password")
	public String sendPasswordRecoveryMail(@RequestParam String email, RedirectAttributes attributes) {
		try {
			userService.sendPasswordRecoveryMail(email);
			attributes.addFlashAttribute("password_recovery_message", "На Вашу почту было выслано письмо с инструкцией по восстановлению пароля");
		} catch (NullPointerException e) {
			attributes.addFlashAttribute("email_not_found_message", "Данный электронный адрес на сайте не зарегистрирован");
		}		
		return "redirect:/login";
	}
	
	@GetMapping("/password_recovery/{username}")
	public String passwordRecoveryPage(@PathVariable String username, Model model) {
		CustomUser user = userService.getUserByUsername(username);
		model.addAttribute("databaseUser", user.getUsername());
		return "password_recovery";
	}
	
	@PostMapping("/password_recovery/{databaseUser}")
	public String changePassword(@RequestParam("databaseUser") String databaseUser, @RequestParam String password,
			@RequestParam String repassword, RedirectAttributes attributes) {
		return userService.changePassword(databaseUser, password, repassword, attributes);
	}

}