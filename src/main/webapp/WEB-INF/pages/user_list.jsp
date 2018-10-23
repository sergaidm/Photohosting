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
<link rel="stylesheet" href="/static/styles/fonts.css">
<link rel="stylesheet" href="/static/styles/links.css">
<title>Список пользователей | Фотохостинг</title>
</head>
<body>
	<c:import url="navbar.jsp"/>
	<main role="main">		
		<div class="container table-responsive-sm" align="center">	
			<c:if test="${changing_user ne null}">
				<div class="alert alert-success">
					<strong>${changing_user}</strong>		    	
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">x</button>
			    </div> 
			</c:if>		
			<c:if test="${changing_user eq null}">
				<div class="col-sm-2 py-4"></div> 
			</c:if>	
			<p class="lead font-effect-outline">Список пользователей</p>
			<table class="table table-bordered table-hover">
				<thead class="thead-dark">
					<tr align="center">
						<th>№</th>
						<th>Имя</th>
						<th>Роль</th>
						<th>Почта</th>
						<th>Телефон</th>
						<th colspan="2">Редактирование</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${users}" var="user">
						<tr class="table-success" align="center">
							<th scope="row">${user.getId()}</th>
							<td>${user.getUsername()}</td>
							<td>${user.getRole()}</td>
							<td>${user.getEmail()}</td>
							<td>${user.getPhone()}</td>
							<td><a href="/users/${user.getId()}" class="change_user" title="Изменить пользователя"><i class="fa fa-edit"></i></a></td>
							<td><a href="/users/${user.getId()}/delete" class="delete_user" title="Удалить пользователя"><i class="fa fa-close"></i></a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</main>
	<c:import url="footer.jsp"/>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
</body>
</html>