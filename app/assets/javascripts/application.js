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
function preLoadImages(){
  images = [
    "consumer-button.png", 
    "consumer-button-active.png", 
    "consumer-button-hover.png",
    "consumer-button-selected.png", 
    "consumer-button-selected-active.png", 
    "consumer-button-selected-hover.png",
    "salesperson-button.png", 
    "salesperson-button-active.png", 
    "salesperson-button-hover.png",
    "salesperson-button-selected.png", 
    "salesperson-button-selected-active.png", 
    "salesperson-button-selected-hover.png",
    "submit.png",
    "submit-active.png",
    "submit-hover.png"
  ];
  for(var i = 0; i < images.length; i++){
    $("<img />").attr("src", "/assets/" + images[i]);
  }
}

$(document).ready(function(){
	preLoadImages();
	// Some IE CSS hack ;)
	$("body *:last-child").addClass("last-child")
	// If we can put the center inside the window, lets not user scrolling :)
	$resized = false;
	resizeWindow();
	$(window).resize(resizeWindow);
});
