<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster&effect=outline">
<link rel="stylesheet" href="/static/styles/removing_arrows.css">
<link rel="stylesheet" href="/static/styles/required_field.css">
<link rel="stylesheet" href="/static/styles/placeholders.css">
<link rel="stylesheet" href="/static/styles/background.css">
<link rel="stylesheet" href="/static/styles/fonts.css">
<title>Регистрация | Фотохостинг</title>
</head>
<body>
	<c:import url="navbar.jsp"/>
	<main class="registration_page" role="main">		
	<div class="container" align="center">
		<c:if test="${exists ne null}">		
			<div class="alert registration_alert alert-danger">
		    	<strong>${exists}</strong>
		    	<button type="button" class="close" data-dismiss="alert" aria-label="Close">x</button>
    		</div> 
    	</c:if>
    	<c:if test="${email_exists ne null}">		
			<div class="alert registration_alert alert-danger">
		    	<strong>${email_exists}</strong>
		    	<button type="button" class="close" data-dismiss="alert" aria-label="Close">x</button>
    		</div> 
    	</c:if>
    	<c:if test="${captchaError ne null}">		
			<div class="alert registration_alert alert-danger">
		    	<strong>${captchaError}</strong>
		    	<button type="button" class="close" data-dismiss="alert" aria-label="Close">x</button>
    		</div> 
    	</c:if>
		<div class="card text-white bg-dark border-success">
			<div class="card-header border-success">
    			<p class="lead font-effect-outline">Регистрация</p>
  			</div>		    
			<form action="/registration" method="post" class="needs-validation" novalidate>		 
				<ul class="list-group list-group-flush">
	    			<li class="list-group-item bg-secondary">  			
						<div class="form-group row mt-4">
							<label class="col-sm-4 text font-effect-outline required" for="inputUsername">Имя пользователя</label> 
							<div class="col-sm-7">
								<input type="text" name="username" class="form-control mt-1" id="inputUsername" placeholder="Придумайте логин для Вашей учётной записи" 
								pattern="^[a-zA-ZА-Яа-яЁё][a-zA-ZА-Яа-яЁё0-9-_\s]{2,}[a-zA-ZА-Яа-яЁё0-9]$" required> 
								<div class="invalid-feedback">
									<p id="usernameHelp" class="form-text failed_validation font-effect-outline">
									Логин должен быть длиной не менее 4 символов, начинаться с буквы, 
									заканчиваться буквой или цифрой и может содержать буквы, цифры, пробел, 
									нижнее подчёркивание и дефис</p>
				        		</div>
				        		<div class="valid-feedback">
							    	<p id="usernameHelp" class="form-text success_validation font-effect-outline">Имя пользователя корректно!</p>
							    </div>
							</div>				
						</div>
					</li>
					<li class="list-group-item bg-secondary">
						<div class="form-group row">
							<label class="col-sm-4 text font-effect-outline required" for="inputPassword">Пароль</label> 
							<div class="col-sm-7">
								<input type="password" name="password" class="form-control mt-1" id="inputPassword" placeholder="Придумайте пароль для Вашей учётной записи" 
								pattern="^[a-zA-Z][a-zA-Z0-9-_]{6,18}[a-zA-Z0-9]$" required> 
								<div class="invalid-feedback">
									<p id="passwordHelp" class="form-text failed_validation font-effect-outline">
									Пароль должен быть длиной от 8 до 20 символов, начинаться с буквы, 
									заканчиваться буквой или цифрой и может содержать латинские буквы, цифры, 
									нижнее подчёркивание и дефис</p>
				        		</div>
				        		<div class="valid-feedback">
							    	<p id="passwordHelp" class="form-text success_validation font-effect-outline">Пароль корректен!</p>
							    </div>
							</div>
						</div>
					</li>
					<li class="list-group-item bg-secondary">
						<div class="form-group row">
							<label class="col-sm-4 text font-effect-outline required" for="inputEmail">Email</label> 
							<div class="col-sm-7">
								<input type="email" name="email" class="form-control mt-1" id="inputEmail" placeholder="Введите Вашу электронную почту"
								pattern="^[A-z0-9_-]+@[A-z0-9-]+\.([A-z]{1,6}\.)?[A-z]{2,6}$" required>
								<div class="invalid-feedback">
									<p id="inputEmail" class="form-text failed_validation font-effect-outline">
									Введите электронную почту в формате username@hostname (например, user1990@gmail.com)</p>
					        	</div>
					        	<div class="valid-feedback">
								    <p id="inputEmail" class="form-text success_validation font-effect-outline">Email корректен!</p>
								</div>
							</div>
						</div>
					</li>
					<li class="list-group-item bg-secondary">
						<div class="form-group row">
							<label class="col-sm-4 text font-effect-outline" for="inputPhone">Телефон</label> 
							<div class="col-sm-7">
								<input type="text" name="phone" class="form-control mt-1" id="inputPhone" placeholder="Введите Ваш номер телефона"
								pattern="^[0-9+][0-9-()\s]{8,}[0-9]$"> 
								<div class="invalid-feedback">
									<p id="inputPhone" class="form-text failed_validation font-effect-outline">
									Номер телефона должен состоять из цифр и может содержать + и -</p>
					        	</div>
					        	<div class="valid-feedback">
								    <p id="inputPhone" class="form-text success_validation font-effect-outline">Телефон корректен!</p>
								</div>
							</div>
						</div>
					</li>
				</ul>
				<div class="col-sm-6 my-2">				
					<div class="g-recaptcha" data-theme="dark" data-sitekey="6LdypXUUAAAAAJmkoRhOexX3WSBpbmYLH1U79PAu"></div>
				</div>
				<div class="card-footer border-success mb-3">
					<button type="submit" class="btn btn-success">Зарегистрироваться</button>		
				</div>
			</form>	
		</div>
	</div>	
	</main>
	<script src="/static/scripts/validator.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
	<script src="https://www.google.com/recaptcha/api.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
</body>
</html>