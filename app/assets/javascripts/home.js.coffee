# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	$("div.stats_req").each ->
		a=$.ajax
			url:"/stats/servers/"+$(this).attr "id"
			type:"GET"
			dataType:"json"
			context:$(this)
		a.done (data) ->
			$(this).parent().html(data.count)
		a.fail ->
			$(this).parent().html("Failed")


