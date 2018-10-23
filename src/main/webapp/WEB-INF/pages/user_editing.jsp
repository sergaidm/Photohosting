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
<link rel="stylesheet" href="/static/styles/admin_background.css">
<link rel="stylesheet" href="/static/styles/removing_arrows.css">
<link rel="stylesheet" href="/static/styles/selection_role.css">
<link rel="stylesheet" href="/static/styles/fonts.css">
<title>Редактор пользователей | Фотохостинг</title>
</head>
<body>
	<c:import url="navbar.jsp" />
	<main role="main">
		<div class="container" align="center"> 
			<p class="lead font-effect-outline mt-4">Редактор пользователей</p>
			<form action="/users" method="post">
				<input type="hidden" value="${user.getId()}" name="userId">
				<div class="form-group">
					<label class="text font-effect-outline col-sm-4 col-form-label" for="changeUsername">Имя пользователя</label>
					<div class="col-4">
						<input type="text" class="form-control mt-2" name="username" value="${user.getUsername()}" id="changeUsername">
					</div>
					<label class="text font-effect-outline col-sm-4 col-form-label" for="changePassword">Пароль пользователя</label>
					<div class="col-4">
						<input type="text" class="form-control mt-2" name="password" value="${user.getPassword()}" id="changePassword">
					</div>
					<label class="text font-effect-outline col-sm-4 col-form-label" for="changeEmail">Email пользователя</label>
					<div class="col-4">
						<input type="text" class="form-control mt-2" name="email" value="${user.getEmail()}" id="changeEmail">
					</div>
					<label class="text font-effect-outline col-sm-4 col-form-label" for="changePhone">Телефон пользователя</label>
					<div class="col-4">
						<input type="text" class="form-control mt-2" name="phone" value="${user.getPhone()}" id="changePhone">
					</div>					
				</div>
				<div class="form-group">
					<label class="text font-effect-outline col-sm-3 col-form-label" for="selectionRole">Роль пользователя</label>
					<c:forEach items="${roles}" var="role">
						<div class="custom-control custom-radio custom-control-inline ml-3 mt-3">
							<c:if test="${role eq user.getRole()}">
								<input type="radio" id="selectionFirstRole" name="user_role" class="custom-control-input" value="${role}" checked>
								<label class="text font-effect-outline custom-control-label" for="selectionFirstRole"><div id="selectionRole">${role}</div></label>
							</c:if>
							<c:if test="${role ne user.getRole()}">
								<input type="radio" id="selectionSecondRole" name="user_role" class="custom-control-input" value="${role}">
								<label class="text font-effect-outline custom-control-label" for="selectionSecondRole"><div id="selectionRole">${role}</div></label>
							</c:if>	
						</div>
					</c:forEach>
				</div>
				<div class="form-group mt-5">
					<button type="submit" class="btn btn-primary">Сохранить изменения</button>
				</div>		
			</form>
		</div>
	</main>
	<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
</body>
</html>