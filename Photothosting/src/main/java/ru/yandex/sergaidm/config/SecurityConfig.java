package ru.yandex.sergaidm.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;

import ru.yandex.sergaidm.service.UserService;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private UserService userService;
//	@Autowired
//	private PasswordEncoder passwordEncoder;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.csrf().disable()
			.authorizeRequests()
				.antMatchers("/", "/registration", "/activate/*", "/recover_password", "/password_recovery/*", "/static/**").permitAll()
				.anyRequest().authenticated().and().exceptionHandling().accessDeniedPage("/unauthorized")
			.and()
				.formLogin()
				.loginPage("/login")
				.loginProcessingUrl("/j_spring_security_check")
				.defaultSuccessUrl("/my_profile")
				.failureUrl("/login?error")
				.usernameParameter("j_username")
				.passwordParameter("j_password").permitAll()			
			.and()
				 .rememberMe()
				 .rememberMeParameter("remember_me")
			.and()
				.logout()
				.permitAll()
				.logoutUrl("/logout")
				.logoutSuccessUrl("/");
	}	
	
	@Override
	public void configure(AuthenticationManagerBuilder authenticationManager) throws Exception {
		authenticationManager.userDetailsService(userService)
				.passwordEncoder(NoOpPasswordEncoder.getInstance());
	}

}