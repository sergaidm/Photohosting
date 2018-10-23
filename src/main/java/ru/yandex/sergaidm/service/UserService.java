package ru.yandex.sergaidm.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ru.yandex.sergaidm.model.CustomUser;
import ru.yandex.sergaidm.model.UserRole;
import ru.yandex.sergaidm.repository.UserRepository;
import ru.yandex.sergaidm.service.MailSender;

@Service
public class UserService implements UserDetailsService {

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private MailSender mailSender;
	@Value("${hostname}")
	private String hostname;
//	@Autowired
//	private PasswordEncoder passwordEncoder;
	
	public List<CustomUser> findAllUsers() {
		return userRepository.findAllByOrderByIdAsc();
	}

	public CustomUser getUserByUsername(String username) {
		return userRepository.findByUsername(username);
	}

	public boolean existsByUsername(String username) {
		return userRepository.existsByUsername(username);
	}

	public boolean existsByEmail(String email) {
		return userRepository.existsByEmail(email);
	}

	public void addUser(CustomUser user) {
		userRepository.save(user);
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	public void deleteUser(CustomUser user) {
		userRepository.delete(user);
	}
	
	public void registerUser(String username, String password, String email, String phone) {
		CustomUser databaseUser = new CustomUser(username, password, email, phone, UserRole.USER);
		databaseUser.setActive(false);
		databaseUser.setActivationCode(UUID.randomUUID().toString());
		databaseUser.setPassword(password);		
		addUser(databaseUser);
		sendMail(databaseUser);				
	}	

	public boolean activateUser(String code) {
		CustomUser user = userRepository.findByActivationCode(code);
		if (user == null) {
			return false;
		}
		user.setActivationCode(null);
		user.setActive(true);
		userRepository.save(user);
		return true;
	}

	private void sendMail(CustomUser databaseUser) {
		if (!StringUtils.isEmpty(databaseUser.getEmail())) {
			String mail = String.format(
					"Здравствуйте, %s! \n\n"
							+ "Благодарим за регистрацию! Пожалуйста, перейдите по ссылке для подтверждения "
							+ "регистрации:\n http://%s/activate/%s \n\n"
							+ "Это письмо сгенерировано автоматически. Отвечать на него не нужно!",
					databaseUser.getUsername(), hostname, databaseUser.getActivationCode());
			mailSender.sendEmail(databaseUser.getEmail(), "Код активации", mail);
		}
	}
	
	public void updateUser(@AuthenticationPrincipal CustomUser user, String password, String phone) {
		if (!StringUtils.isEmpty(password)) {
			user.setPassword(password);
		}
		String databasePhone = user.getPhone();
		boolean isPhoneChanged = (phone != null && !phone.equals(databasePhone)) || (databasePhone != null && !databasePhone.equals(phone));
		if (isPhoneChanged) {
			user.setPhone(phone);
		}
		userRepository.save(user);
	}

	@PreAuthorize("hasAuthority('ADMIN')")
	public void saveUser(CustomUser user, String username, String userRole, String password, String email, String phone) {
		user.setUsername(username);
		user.setPassword(password);
		user.setEmail(email);
		user.setPhone(phone);
		user.setRole(UserRole.valueOf(userRole));
		userRepository.save(user);
	}	
	
	public void sendPasswordRecoveryMail(String email) throws NullPointerException {
		String mail = String.format("Здравствуйте, %s! \n\n"
				+ "Вы сделали запрос на восстановление пароля на сайте http://%s/"
				+ "\nЧтобы установить новый пароль вместо забытого, перейдите по ссылке ниже:\n http://%s/password_recovery/%s \n\n"
				+ "Это письмо сгенерировано автоматически. Отвечать на него не нужно!",
				userRepository.findByEmail(email).getUsername(), hostname, hostname, userRepository.findByEmail(email).getUsername());
		mailSender.sendEmail(email, "Инструкция по восстановлению пароля", mail);
	}
	
	public String changePassword(String username, String password, String repassword, RedirectAttributes attributes) {
		CustomUser user = getUserByUsername(username);
		if (!password.equals(repassword)) {
			attributes.addFlashAttribute("password_mismatch", "Введённые пароли не совпадают!");
			return "redirect:/password_recovery/{databaseUser}";
		} else {
			user.setPassword(password);
			attributes.addFlashAttribute("changed_password", "Пароль успешно изменён!");
			return "redirect:/login";
		}
	}	

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		return userRepository.findByUsername(username);
	}

}