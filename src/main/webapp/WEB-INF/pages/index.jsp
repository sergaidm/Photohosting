<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster&effect=outline">
<link rel="stylesheet" href="/static/styles/background.css">
<link rel="stylesheet" href="/static/styles/buttons.css">
<link rel="stylesheet" href="/static/styles/popover.css">
<link rel="stylesheet" href="/static/styles/fonts.css">
<link rel="stylesheet" href="/static/styles/index.css">
<link rel="stylesheet" href="/static/styles/title.css">
<title>Фотохостинг</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<c:import url="navbar.jsp"/>
	<main role="main">
	<section class="jumbotron text-center">
		<div class="container">
			<div class="title">
				<span>Ф</span><span>о</span><span>т</span><span>о</span>
				<div>
					<span>Х</span><span>о</span><span>с</span><span>т</span><span>и</span><span>н</span><span>г</span>
				</div>
			</div>
			<c:if test="${user eq null}">
				<p class="lead font-effect-outline">Добро пожаловать на фотохостинг!<br> 				
				Для получения доступа к функциям сайта требуется авторизация.</p>
			</c:if>
			<c:if test="${user ne null}">
				<p class="lead font-effect-outline">Для создания альбомов и загрузки фотографий
				перейдите в раздел "Альбомы". Также Вы можете изменить личную информацию в 
				личном кабинете.</p>
			</c:if>
		</div>
	</section>
	<c:if test="${user eq null}">	
	<div class="d-flex justify-content-center align-items-center" style="height: 380px;">	
		<a href="/login" class="login_button mr-2"><span><img src="static/images/Authorization.jpg" width="40" height="40" /></span>Авторизация</a>
		<button type="button" class="or_button shadow red" data-container="body" data-toggle="popover" data-placement="top" 
		data-trigger="hover focus" data-content="&ensp;&nbsp; Войдите на сайт &emsp; или зарегистрируйтесь">ИЛИ</button>
		<a href="/registration" class="registration_button"><span><img src="static/images/Registration.jpg" width="40" height="40" /></span>Регистрация</a>
	</div>	
	</c:if>
	</main>
	<script src="/static/scripts/popover.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
</body>
</html>