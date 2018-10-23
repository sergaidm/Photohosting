<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/static/styles/bootstrap_social.css">
<link rel="stylesheet" href="/static/styles/navbar.css">
<title>Навигационная панель | Фотохостинг</title>
</head>
<body>
	<header>
		<div class="collapse bg-dark" id="navbarHeader">
			<div class="container">
				<div class="row">
					<div class="col-sm-6 col-md-7 py-4">
						<h4 class="text-white">О проекте</h4>
						<p class="text-white">Фотохостинг - веб-приложение,
							разработанное с помощью технологий Spring IoC, Spring MVC, Spring
							Data, Spring Security, Spring Boot, Spring Boot Mail, ORM
							Hibernate, JQuery и оформленное при помощи CSS-фреймворка Bootstrap.</p>
					</div>					
					<div class="col-sm-2 py-4"></div>					
					<div class="col-sm-3 py-4">
						<h4 class="text-white ml-4">Об авторе</h4>
						<ul class="list-unstyled ml-4">
							<li class="media mb-2">
								<a class="btn btn-linkedin" href="https://www.linkedin.com/in/serhey-haidamaka-93216713a/" target="_blank">
 								<span class="fa fa-linkedin pr-2"></span>Профиль на LinkedIn</a>					
							</li>
							<li class="media mb-2">
								<a class="btn btn-github" href="https://github.com/sergaidm" target="_blank">
								<span class="fa fa-github pr-2"></span>Профиль на GitHub<span style="position: relative; z-index: -1;">.</span>&ensp;</a>
							</li>
							<li class="media">
								<a class="btn btn-google" href="mailto:gsg7525@gmail.com" target="_blank">
								<span class="fa fa-google pr-2"></span>Написать на Email<span style="position: relative; z-index: -1;">.</span>&emsp;&nbsp;</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</header>
	<c:set var="username" value="${user.getUsername()}"/>
	<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
		<div class="container">
			<c:if test="${user eq null}">
				<div class="p-2 bd-highlight mr-auto">
					<a href="/" class="navbar-brand d-flex align-items-center"><i class="fa fa-camera fa-lg mr-2"></i><strong>Фотохостинг</strong></a>
				</div>
			</c:if>
			<c:if test="${user ne null}">
				<div class="p-2 bd-highlight">
					<a href="/" class="navbar-brand d-flex align-items-center"><i class="fa fa-camera-retro fa-lg mr-2"></i><strong>Фотохостинг</strong></a>
				</div>				
				<div class="p-2 bd-highlight mr-auto">
					<ul class="navbar-nav">
						<li class="nav-item"> 						
							<a class="nav-link" href="/my_profile">Профиль</a>
						</li>
	 					<li class="nav-item"> 						
							<a class="nav-link" href="/albums">Альбомы</a>
						</li>
	 				</ul>
				</div>
			</c:if>				
			<div class="p-2 bd-highlight">				
 			<ul class="navbar-nav">
 				<li class="nav-item">
 					<c:if test="${user ne null}">
						<div class="navbar-text mr-2">${username}</div>
					</c:if>
					<c:if test="${empty user}">
						<div class="navbar-text mr-2">Гость</div>
					</c:if>
 				</li>
 				<li class="nav-item">
 				<c:forEach items="${roles}" var="role">
	 				<c:if test="${role eq 'ADMIN'}">
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Администрирование</a>
							<div class="dropdown-menu">
		 						<a class="dropdown-item" href="/users">Страница демиурга</a>
		 					</div>
						</li>
	 				</c:if>
 				</c:forEach>
 				</li>
				<li class="nav-item">
					<c:if test="${user ne null}">
	                	<form id="logout" action="/logout" method="post">
	                		<a class="nav-link" href="javascript:;" onclick="document.getElementById('logout').submit();">Выход из системы</a>
	        			</form>
           			</c:if>
 				</li> 				
			</ul>
 			</div>				
			<div class="p-2 bd-highlight">
				<button class="navbar-toggler d-sm-block" type="button" data-toggle="collapse" data-target="#navbarHeader">
					<span class="navbar-toggler-icon"></span>
				</button>
			</div>
		</div>
	</nav>
</body>
</html>