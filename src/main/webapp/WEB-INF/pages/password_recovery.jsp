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
<link rel="stylesheet" href="/static/styles/fonts.css">
<title>Восстановление пароля | Фотохостинг</title>
</head>
<body>
	<c:import url="navbar.jsp"/>
	<main class="password_recovery_page" role="main">	
		<div class="container" align="center">
		<c:if test="${password_mismatch ne null}">
			<div class="container password_recovery_alert alert alert-danger" align="center">
				<strong>${password_mismatch}</strong>
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">x</button>
			</div>
		</c:if>
		<div class="card text-white bg-dark border-warning col-sm-8">
			<div class="card-header border-warning">
    			<p class="lead font-effect-outline">Восстановление пароля</p>
  			</div>    
			<form action="/password_recovery/${databaseUser}" method="post" class="needs-validation" novalidate>		 
				<ul class="list-group list-group-flush">	    			
					<li class="list-group-item bg-secondary">
						<div class="form-group row">
							<div class="col-sm-12">
								<input type=hidden name="databaseUser" value="${databaseUser}">
								<input type="password" name="password" class="form-control mt-1" id="inputPassword" placeholder="Введите новый пароль для Вашей учётной записи" 
								pattern="^[a-zA-Z][a-zA-Z0-9-_]{6,18}[a-zA-Z0-9]$" required> 
								<div class="invalid-feedback">
									<p id="passwordHelp" class="form-text failed_validation font-effect-outline">
									Пароль должен быть длиной от 8 до 20 символов, начинаться с буквы, 
									заканчиваться буквой или цифрой и может содержать латинские буквы, цифры, 
									нижнее подчёркивание и дефис</p>
				        		</div>
							</div>
						</div>
					</li>
					<li class="list-group-item bg-secondary">
						<div class="form-group row">
							<div class="col-sm-12">
								<input type="password" name="repassword" class="form-control mt-1" id="rePassword" placeholder="Повторите пароль" 
								pattern="^[a-zA-Z][a-zA-Z0-9-_]{6,18}[a-zA-Z0-9]$" required>
							</div>
						</div>
					</li>					
				</ul>				
				<div class="card-footer border-warning mb-3">
					<button type="submit" class="btn btn-warning">Сменить пароль</button>		
				</div>
			</form>	
		</div>
	</div>
	</main>	
	<script src="/static/scripts/validator.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.0.js"></script>	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
</body>
</html>