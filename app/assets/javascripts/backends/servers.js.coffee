# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
#
#
list_functions = (id) ->
	$(id+" #server-mac-add").click ->
		tr_elem=$("<tr><input type='hidden' name='macs[][_id]' value='none'/><td><input type='text' name='macs[][mac_addr]' value=''/></td><td><input type='text' name='macs[][device_name]' value=''/></td></tr>")
		$(id+" TBODY").append(tr_elem)

$(document).ready ->
	$(".collapse").collapse
		"toggle":false
	$("#serverTab a[data-toggle='tab']:first").tab("show")
	$("#hostTab a[data-toggle='tab']:first").tab("show")
	$("#serverTab a[data-toggle='tab']").bind "shown", (e) -> 
		if ($(e.target).attr("href")=="#server-mac-addrs")
			list_functions "#server-mac-addr-list"



