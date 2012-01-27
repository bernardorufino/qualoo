// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function resizeWindow(e){
	var center = $("#nav, #main");
	if($(window).width() < $("body").width()){
		if($("#nav, #main").width() < $(window).width()){
			$resized = true;
			center.width(center.width());
			center.css("margin-left", "auto").css("margin-right", "auto");
			$("body").css("min-width", $(window).width()).width($(window).width());
		}
	} else if($resized){
		$("body").width($(window).width());
	}
	
}

$(document).ready(function(){
	// Some IE CSS hack ;)
	$("body *:last-child").addClass("last-child")
	// If we can put the center inside the window, lets not user scrolling :)
	$resized = false;
	resizeWindow();
	$(window).resize(resizeWindow);
});
