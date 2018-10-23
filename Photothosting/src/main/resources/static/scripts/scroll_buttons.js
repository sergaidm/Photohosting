$(function() {
	$(".scroll_down").click(function() {
		$("html, body").animate({
			scrollTop : $("main").height()
		}, 500);
	})
});

$(function() {
	$(".scroll_up").click(function() {
		$("html, body").animate({
			scrollTop : 0
		}, 500);
	})
});

$(window).scroll(function() {
	if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
		$(".scroll_down").fadeOut();
	else {
		$(".scroll_down").fadeIn();
	}
});

$(window).scroll(function() {
	if ($(this).scrollTop() > 200) {
		$(".scroll_up").fadeIn();
	else {
		$(".scroll_up").fadeOut();
	}
});