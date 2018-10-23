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
<link rel="stylesheet" href="/static/styles/placeholders.css">
<link rel="stylesheet" href="/static/styles/background.css">
<link rel="stylesheet" href="/static/styles/fonts.css">
<title>Мой профиль | Фотохостинг</title>
</head>
<body>
	<c:import url="navbar.jsp"/>
	<main role="main">
 	<div class="container">        
    	<div class="albums_page lead_title font-effect-outline" align="center">Личный кабинет</div>    	
    	<div class="offset-sm-2"> 
    		<button class="btn btn-success" type="button" data-toggle="collapse" data-target="#updateProfile" id="update_button">Обновить личную информацию</button>
  		</div>
  		<div class="collapse" id="updateProfile"> 
  			<div class="form-group mt-3">
	        <form action="/my_profile/update" method="post" class="needs-validation" novalidate>
	        	<div class="form-group row">
					<label for="updatePassword" class="text font-effect-outline col-sm-2 col-form-label">Пароль</label>
					<div class="col-sm-6 mt-2">
						<input type="password" class="form-control" name="password" value="${password}" id="updatePassword" placeholder="Пароль"
						pattern="^[a-zA-Z][a-zA-Z0-9-_]{6,18}[a-zA-Z0-9]$">
						<div class="invalid-feedback">
							<p id="updatePassword" class="form-text failed_validation font-effect-outline">
							Пароль должен быть длиной от 8 до 20 символов, начинаться с буквы, 
							заканчиваться буквой или цифрой и может содержать латинские буквы, цифры, 
							нижнее подчёркивание и дефис</p>
		        		</div>
		        		<div class="valid-feedback">
					    	<p id="updatePassword" class="form-text success_validation font-effect-outline">Пароль корректен!</p>
					    </div>
					</div>
				</div>
				<div class="form-group row">
					<label for="updatePhone" class="text font-effect-outline col-sm-2 col-form-label">Телефон</label>
					<div class="col-sm-6 mt-2">
						<input type="text" class="form-control" name="phone" value="${phone}" id="updatePhone" placeholder="Номер телефона"
						pattern="^[0-9+][0-9-()\s]{8,}[0-9]$">
						<div class="invalid-feedback">
							<p id="updatePhone" class="form-text failed_validation font-effect-outline">
							Номер телефона должен состоять из цифр и может содержать + и -</p>
		        		</div>
		        		<div class="valid-feedback">
					    	<p id="updatePhone" class="form-text success_validation font-effect-outline">Телефон корректен!</p>
					    </div>
					</div>
				</div>
				<div class="form-group row">
					<div class="offset-sm-2 col-sm-6">
						<button type="submit" class="btn btn-primary">Сохранить изменения</button>
					</div>
				</div>
				</form> 
	        </div>
        </div>	
	</div>	
	</main>	
	<script src="/static/scripts/validator.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.0.js"></script>	
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
</body>
</html>