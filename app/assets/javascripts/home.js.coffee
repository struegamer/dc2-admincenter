# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	if $("UL.vertical LI.submenu UL.submenu").hasClass "hidden"
		$("UL.vertical LI.submenu UL.submenu").css "display","none"

	$("UL.vertical LI.submenu > UL.submenu").each ->
		$(this).parent().click ->
			if $(this).children("UL.submenu").hasClass "hidden"
				$(this).children("UL.submenu").css "display","block"
				$(this).children("UL.submenu").removeClass "hidden"
			else
				$(this).children("UL.submenu").addClass "hidden"
				$(this).children("UL.submenu").css "display","none"


