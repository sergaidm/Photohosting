$(function() {
	var textarea = $(".form-control.album_description");
	var savingButton = $(".fa-check-circle-o");
	textarea.on("focus", function() {
		savingButton.show();
	});
	savingButton.hover(function() {
		savingButton.show();
	});
	textarea.on("blur", function() {
		savingButton.hide();
	});
});