# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	$("#datacenters div.stats_req").each ->
		a=$.ajax
			url:"/stats/"+$(this).attr("data-stats")+"/"+$(this).attr "id"
			type:"GET"
			dataType:"json"
			context:$(this)
		a.done (data) ->
			$(this).parent().html('<span class="label label-success">'+data.count+'</span>')
		a.fail ->
			$(this).parent().html('<span class="label label-important">Failed to retrieve data</span>')

	$("#datacenters tbody tr").each ->
		$(this).css "cursor","pointer"
		$(this).click -> 
			window.location.href = $(this).attr "data-url"

