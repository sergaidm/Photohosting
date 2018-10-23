$(function() {

	$("#selection_checkboxes").click(function() {
		if (this.checked) {
			$(".checkbox").each(function() {
				this.checked = true;
				$("img.etu").addClass("checkimg");
			})
		} else {
			$(".checkbox").each(function() {
				this.checked = false;
				$("img.etu.checkimg").removeClass("checkimg");
			})
		}
	});

	$(".checkbox").click(function() {
		var allPhotos = $("img.etu").length;
		var selected_checkboxes = $(":checkbox:checked").length;
		if ($(this).is(":checked")) {
			if (selected_checkboxes == allPhotos) {
				$("#selection_checkboxes").prop("checked", true);
			}
		} else {
			$("#selection_checkboxes").prop("checked", false);
		}
	});

});