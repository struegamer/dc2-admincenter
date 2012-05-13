# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
#
#
tabify = (id) -> 
	$(id + " a[data-toggle='tab']").click (e) ->
		e.preventDefault();
		$(this).tab("show")

show_data = (elem,target) ->
	console.log target
	$(elem).each ->
		$(this).click ->
			window.location.href=$(this).attr "data-show-url"

$(document).ready ->
	tabify "#inventory"
	$('#inventory a[data-toggle="tab"]').bind 'show', (e) ->
		console.log $(e.target).attr "href"
		dcb_id=$($(e.target).attr "href").attr "data-dc-record"
		tbody=$("#serverlist TBODY")
		a=$.ajax 
			url:dcb_id
			type:"GET"
			dataType:"html"
		a.done (data) ->
			$(tbody).children().remove()
			$(tbody).append(data)
			show_data($(tbody).children("tr"),$($(e.target).attr("href")))
		a.fail ->
			console.log "fail"

	$("#inventory a[data-toggle='tab']:first").tab("show")


