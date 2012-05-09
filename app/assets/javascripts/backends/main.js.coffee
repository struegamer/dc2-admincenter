# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
#
$(document).ready ->
	$("#get_server_list").bind "ajax:complete", (et, e) ->
		$("#server_list").html(e.responseText)
		$("#serverlist").dataTable
			"bJQueryUI": true
