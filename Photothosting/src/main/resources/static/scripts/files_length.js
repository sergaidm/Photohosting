$("#custom-file-upload").on("change", function(){
	var filesLength = this.files.length;			
	if (filesLength == 1 || (filesLength%10 == 1 && filesLength/10 >= 2)) {
		$(".js-value").text("Выбран " + this.files.length + " файл для загрузки");
	} else if (filesLength == 2 || filesLength == 3 || filesLength == 4 ||(filesLength%10 >= 5 && filesLength/10 >= 2)) {
		$(".js-value").text("Выбрано " + this.files.length + " файла для загрузки");
	} else {
		$(".js-value").text("Выбрано " + this.files.length + " файлов для загрузки");
	}
	var text = "Выбрано " + this.files.length + " файлов для загрузки";
	if (text == "Выбрано 0 файлов для загрузки") {
		$(".js-value").text("Выбрать фотографии для загрузки");
		$("#button").hide();
	}	
});