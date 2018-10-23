package ru.yandex.sergaidm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailSender {
	
	@Autowired
	private JavaMailSender mailSender;
	@Value("${spring.mail.username}")
	private String username;
	
	public void sendEmail(String addressee, String subject, String message) {
		SimpleMailMessage email = new SimpleMailMessage();
		email.setFrom(username);
		email.setTo(addressee);
		email.setSubject(subject);
		email.setText(message);
		mailSender.send(email);
	}

}