package ru.yandex.sergaidm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ru.yandex.sergaidm.model.CustomUser;
import ru.yandex.sergaidm.model.UserRole;
import ru.yandex.sergaidm.service.UserService;

@Controller
@RequestMapping("/users")
@PreAuthorize("hasAuthority('ADMIN')")
@SessionAttributes("changingUser")
public class AdminController {
	
	@Autowired
	private UserService userService;

	@GetMapping
	public String userList(Model model) {
		model.addAttribute("users", userService.findAllUsers());
		return "user_list";
	}

	@GetMapping("/{user}")
	public String userEditingPage(@PathVariable CustomUser user, Model model) {
		model.addAttribute("user", user);
		model.addAttribute("roles", UserRole.values());
		return "user_editing";
	}
	
	@GetMapping("/{user}/delete")
	public String deleteUser(@PathVariable CustomUser user, Model model) {
		userService.deleteUser(user);
		return "redirect:/users";
	}
	
	@PostMapping
	public String saveUser(@RequestParam("userId") CustomUser user, @RequestParam(required=false, name="username") String username, 
			@RequestParam("user_role") String userRole, @RequestParam(required=false, name="password") String password,
			@RequestParam(required=false, name="email") String email, @RequestParam(required=false, name="phone") String phone,  RedirectAttributes attributes) {		
		userService.saveUser(user, username, userRole, password, email, phone);	
		attributes.addFlashAttribute("changing_user", "Пользователь успешно изменён!");		
		return "redirect:/users";
	}

}