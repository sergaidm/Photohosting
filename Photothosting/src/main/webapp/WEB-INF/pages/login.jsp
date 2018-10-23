<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster&effect=outline">
<link rel="stylesheet" href="/static/styles/placeholders.css">
<link rel="stylesheet" href="/static/styles/background.css">
<link rel="stylesheet" href="/static/styles/login_form.css">
<link rel="stylesheet" href="/static/styles/fonts.css">
<title>Авторизация | Фотохостинг</title>
</head>
<body>
	<c:import url="navbar.jsp"/>
	<main class="login_page" role="main"> 
	<c:if test="${param.error ne null}">
		<div class="container login_alert alert alert-danger" align="center">
			<strong>Неверный ввод имени пользователя или пароля!<br>
			Или данный пользователь не активирован с помощью активационного кода</strong>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">x</button>
		</div>
 	</c:if> 	
	<c:if test="${success_message ne null}">
		<div class="container login_alert alert alert-success" align="center">
			<strong>${success_message}</strong>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">x</button>
		</div>
	</c:if> 
	<c:if test="${error_message ne null}">
		<div class="container login_alert alert alert-danger" align="center">
			<strong>${error_message}</strong>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">x</button>
		</div>
	</c:if> 
	<c:if test="${notification ne null}">
		<div class="container login_alert alert alert-info" align="center">
			<strong>На Вашу почту было отправлено письмо с кодом подтверждения.<br>
					Для завершения регистрации перейдите по ссылке в полученном письме</strong>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">x</button>
		</div>
	</c:if>
	<c:if test="${password_recovery_message ne null}">
		<div class="container login_alert alert alert-info" align="center">
			<strong>${password_recovery_message}</strong>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">x</button>
		</div>
	</c:if>
	<c:if test="${email_not_found_message ne null}">
		<div class="container login_alert alert alert-warning" align="center">
			<strong>${email_not_found_message}</strong>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">x</button>
		</div>
	</c:if>
	<c:if test="${changed_password ne null}">
		<div class="container login_alert alert alert-success" align="center">
			<strong>${changed_password}</strong>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">x</button>
		</div>
	</c:if>
	<form id="login" action="/j_spring_security_check" method="post">
		<h1 id="ff-proof" class="ribbon">Авторизация</h1>
		<fieldset id="inputs">
			<input type="text" name="j_username" id="username"
				placeholder="Имя пользователя" /> <input type="password"
				name="j_password" id="password" placeholder="Пароль" />
		</fieldset>
			<label class="remember_checkbox">
				<input type="checkbox" id="remember_checkbox" name="remember_me" class="remember_checkbox" value="false"/>
				<div class="remember_checkbox_text font-effect-outline">Запомнить меня</div>
			</label>
		<fieldset id="actions">
			<input type="submit" id="submit" value="ВОЙТИ НА САЙТ"/>
			<p class="option"><a href="/password_recovery" data-toggle="modal" data-target="#input_email">Восстановить пароль</a>&nbsp;&nbsp;|<a href="/registration">Регистрация</a></p>			
		</fieldset>
	</form>
	<div class="modal fade" id="input_email" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header bg-primary">
					<h4 class="modal-title">Восстановление пароля</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body bg-light" align="center">
					<p><strong>Забыли пароль?</strong><br> 
					Введите электронную почту, на которую хотите получить инструкцию по восстановлению пароля.</p>
					<form action="/recover_password" method="post" class="needs-validation" novalidate>
						<div class="form-group">
							<input type="email" name="email" class="form-control mt-1" id="input_email" placeholder="Введите Вашу электронную почту"
								pattern="^[A-z0-9_-]+@[A-z0-9-]+\.([A-z]{1,6}\.)?[A-z]{2,6}$" required>
							<div class="invalid-feedback">
								<p id="input_email" class="form-text failed_validation">Введите электронную почту в формате username@hostname
								(например, user1990@gmail.com)</p>
							</div>
						</div>
						<button type="submit" class="btn btn-success">Восстановить пароль</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	</main>
	<script src="/static/scripts/validator.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
</body>
</html>