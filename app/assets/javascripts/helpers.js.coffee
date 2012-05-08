@create_buttonbar = (id,options) ->
	$(id+".buttonbar .button").each ->
		id_name=$(this).attr "name"
		if id_name == "btn_add"
			$(this).click ->
				window.location.href=options.add_url
		if id_name == "btn_refresh"
			$(this).click ->
				window.location.href=options.refresh_url
		if id_name == "btn_delete"
			$(this).click ->
				eval options.delete_func()


@management_buttonbar = (id) ->
	$(id+" UL LI INPUT.button").each ->
		btn_id=$(this).attr "id"
		console.log btn_id
		$("#"+btn_id).click ->
			btn_arr=null
			btn_arr=btn_id.split("_")
			btn_type=btn_arr[0]
			btn_type_id=btn_arr[1]
			console.log btn_type
			console.log btn_type_id
			alert btn_arr
			return false
