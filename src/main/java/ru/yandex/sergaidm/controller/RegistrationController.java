package ru.yandex.sergaidm.controller;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ru.yandex.sergaidm.model.dto.CaptchaResponseDto;
import ru.yandex.sergaidm.service.UserService;

@Controller
public class RegistrationController {
	
	private final static String CAPTHA_URL = "https://www.google.com/recaptcha/api/siteverify?secret=%s&response=%s";
	@Autowired
	private UserService userService;
	@Autowired
    private RestTemplate restTemplate;
	@Value("${recaptcha.secret}")
	private String secret;

	@GetMapping("/registration")
	public String registrationPage() {
		return "registration";
	}	

	@PostMapping("/registration")
	public String registration(@RequestParam String username, @RequestParam String password, @RequestParam String email,
			@RequestParam(required = false) String phone, @RequestParam("g-recaptcha-response") String capthaResponse,
			RedirectAttributes attributes, Model model) {
		if (userService.existsByUsername(username)) {
			String name = userService.getUserByUsername(username).getUsername();
			model.addAttribute("name", name);
			attributes.addFlashAttribute("exists", "Пользователь с именем " + name + " уже существует. Выберите другое имя");
			return "redirect:/registration";
		}
		if (userService.existsByEmail(email)) {
			attributes.addFlashAttribute("email_exists", "Данный электронный адрес уже зарегистрирован");
			return "redirect:/registration";
		}		
		String url = String.format(CAPTHA_URL, secret, capthaResponse);
		CaptchaResponseDto response = restTemplate.postForObject(url, Collections.emptyList(), CaptchaResponseDto.class);		
		if (!response.isSuccess()) {
			attributes.addFlashAttribute("captchaError", "Ошибка валидации reCAPTCHA");
			return "redirect:/registration";
		} else {
			userService.registerUser(username, password, email, phone);
			attributes.addFlashAttribute("notification", true);
			return "redirect:/login";
		}
	}

	@GetMapping("/activate/{code}")
	public String activate(@PathVariable String code, RedirectAttributes attributes, Model model) {
		boolean isActivated = userService.activateUser(code);
		if (isActivated) {
			attributes.addFlashAttribute("success_message", "Пользователь успешно активирован!");
		} else {
			attributes.addFlashAttribute("error_message", "Данный код активации не найден или уже активирован");
		}
		return "redirect:/login";
	}	

}