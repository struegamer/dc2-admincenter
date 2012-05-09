# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
#
$(document).ready ->
	$("#get_server_list").bind "ajax:beforeSend", (et,e) ->
		if ($("#serverlist_wrapper").length)
			$("#serverlist_wrapper").show()
			if ($("#server_detail_view").length) 
				$("#server_detail_view").remove()
			return false

	$("#get_server_list").bind "ajax:complete", (et, e) ->
		$("#server_list").append(e.responseText)
		odata=$("#serverlist").dataTable
			"bJQueryUI": true
			"aoColumnDefs": [
				{ "bSortable":false, "aTargets":[0] }
			]
			"fnCreatedRow":(nRow,aData,iDataIndex) ->
				$("a.button.edit").unbind "ajax:complete"
				$("a.button.edit").bind "ajax:complete", (et,e) ->
					$("#serverlist_wrapper").hide()
					$("#server_list").append(e.responseText)
					generate_collapsables("#server_detail_view")
					return false

	

