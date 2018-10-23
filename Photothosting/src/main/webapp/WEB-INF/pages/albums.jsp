<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster&effect=outline">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Marck+Script">
<link rel="stylesheet" href="/static/styles/album_description.css">
<link rel="stylesheet" href="/static/styles/album_buttons.css">
<link rel="stylesheet" href="/static/styles/placeholders.css">
<link rel="stylesheet" href="/static/styles/album_title.css">
<link rel="stylesheet" href="/static/styles/background.css">
<link rel="stylesheet" href="/static/styles/fonts.css">
<title>Мои альбомы | Фотохостинг</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<c:import url="navbar.jsp" />
	<main role="main">
	<div class="container">
		<c:if test="${message ne null}">		
			<div class="albums_alert alert alert-danger" align="center">
			    <strong>${message}</strong>	    	
			    <button type="button" class="close" data-dismiss="alert" aria-label="Close">x</button>
	    	</div>
		</c:if>		
		<div class="albums_page lead_title font-effect-outline" align="center">Мои альбомы</div>		
		<div class="offset-sm-3">  	
    		<div class="ml-2 mt-3"><button class="btn btn-dark mt-4" type="button" data-toggle="collapse" data-target="#addAlbum">Добавить новый альбом</button></div>
  		</div>
  		<div class="collapse" id="addAlbum"> 
  			<div class="form-group mt-3">
	        <form action="albums/add_album" method="post" class="needs-validation" novalidate>	        	
				<div class="form-group row">				
					<label class="text font-effect-outline col-sm-3 col-form-label required" for="inputAlbumName">Название альбома</label> 
					<div class="col-sm-6 mt-2">
						<input type="text" name="album_name" class="form-control mt-1" id="inputAlbumName" placeholder="Придумайте название для нового альбома" required> 
						<div class="invalid-feedback">
							<p id="inputAlbumName" class="form-text failed_validation font-effect-outline">Введите название создаваемого альбома</p>
	        			</div>
	        			<div class="valid-feedback">
				    		<p id="inputAlbumName" class="form-text success_validation font-effect-outline"></p>
				    	</div>
					</div>
				</div>
				<div class="form-group row">
					<label for="albumDescription" class="text font-effect-outline col-sm-3 col-form-label">Описание альбома</label>
					<div class="col-sm-6 mt-2">
						<textarea class="form-control" name="description" id="albumDescription" data-autoresize rows="3" placeholder="Придумайте описание для нового альбома"></textarea>
					</div>
				</div>
				<div class="form-group row">
					<div class="offset-sm-3 col-sm-6">
						<button type="submit" class="btn btn-primary">Добавить альбом</button>
					</div>
				</div>
				</form> 
	        </div>
        </div>
		<div class="album pb-5 bg-light">
			<c:set var="allAlbums" value="${fn:length(albums)}"/>
			<c:if test="${allAlbums > 0}">
				<div class="row mb-5">
					<c:forEach items="${albums}" var="album">	
						<c:set var="albumPhotos" value="${album.getPhotos()}"/>					
						<c:set var="id" scope="session" value="${album.getId()}"/>
						<c:set var="albumPhotosLength" value="${fn:length(albumPhotos)}"/>
						<c:set var="album_name" scope="session"	value="${album.getAlbumName()}"/>
						<c:set var="description" scope="session" value="${album.getDescription()}"/>						
						<div class="col-md-4">
							<div class="card-body pb-1">
								<form action="albums/${album_name}" method="post">
									<input type="hidden" name="albumId" value="${album.getId()}">
									<button type="submit" class="album_title">${album_name}</button>
								</form>
							</div>
							<div class="card mb-4 shadow-sm">
								<c:if test="${albumPhotosLength == 0}">
									<img class="card-img-top" src="/static/images/EmptyImage.jpg" width="300" height="300" alt="Обложка альбома" />
								</c:if>
								<c:if test="${albumPhotosLength > 0}">								
									<img class="card-img-top" src="/albums/view_cover/${album.getCover()}" alt="Обложка альбома">
								</c:if>
								<div class="card-body">
									<c:if test="${empty description}">
										<form action="albums/change_description" id="change_description" method="post">
											<input type="hidden" name="id" value="${id}">
											<div class="input-group">
												<textarea class="form-control album_description" id="album_description" name="description" data-autoresize placeholder="Описание альбома"></textarea>
												<button type="submit" class="fa fa-check-circle-o fa-3x"></button>
											</div>
										</form>
									</c:if>
									<c:if test="${not empty description}">
										<form action="albums/change_description" method="post">
											<input type="hidden" name="id" value="${id}">
											<div class="input-group">
												<textarea class="form-control album_description" id="album_description" name="description" data-autoresize placeholder="Описание альбома">${description}</textarea>
												<button type="submit" class="fa fa-check-circle-o fa-3x"></button>
											</div>
										</form>
									</c:if>
									<div
										class="d-flex justify-content-center align-items-center mt-4">
										<div class="btn-group">
											<form action="/albums/{album_name}/download_album" method="post">
												<input type="hidden" name="id" value="${id}">
												<button type="submit" class="download_album">
													<div class="cleverlypaired">
														<i class="fa fa-download"></i>
													</div>
													<div class="kedeverything">
														<span>Скачать</span>
													</div>
												</button>
											</form>
											<form action="albums/delete_album" method="post">
												<input type="hidden" name="id" value="${id}">
												<button type="submit" class="delete_album">
													<div class="cleverlypaired">
														<i class="fa fa-trash-o"></i>
													</div>
													<div class="kedeverything">
														<span>Удалить</span>
													</div>
												</button>
											</form>
										</div>
									</div>
									<div class="d-flex justify-content-center align-items-center my-2">
										<p class="creation_date">${album.getCreationDate()}</p>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:if>
		</div>
	</div>           
	</main>
	<c:import url="footer.jsp"/>
	<script src="/static/scripts/validator.js"></script>
	<script src="/static/scripts/modal_windows.js"></script>
	<script src="/static/scripts/saving_description.js"></script>
	<script src="/static/scripts/autoresize_textarea.js"></script>	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
</body>
</html>