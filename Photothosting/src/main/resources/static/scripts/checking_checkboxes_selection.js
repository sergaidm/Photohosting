$(function() {
	$("#body_button").hide();
	var checkbox = $(".checkbox");
	checkbox.click(function() {
		for (var i = 0; i < checkbox.length; i++) {
			if (checkbox[i].checked) {
				$("#body_button").show();
				break;
			} else {
				$("#body_button").hide();
			}
		}
	});
});