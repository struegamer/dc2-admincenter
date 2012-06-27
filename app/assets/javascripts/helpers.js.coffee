@create_buttonbar = (id,options) ->
  $(id+" .btn").each ->
    id_name=$(this).attr "name"
    if id_name == "btn_add"
      $(this).click ->
        console.log 'add'
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

@generate_collapsables = (id) ->
	$(id+" h2.collapsable").each ->
		$(this).css "cursor", "pointer"
		a=$('<span class="ui-icon"></span>').css("float","left")
		if ($(this).hasClass "hidden")
			a.addClass "ui-icon-triangle-1-e"
			a.removeClass "ui-icon-triangle-1-s"
		else
			a.removeClass "ui-icon-triangle-1-e"
			a.addClass "ui-icon-triangle-1-s"
		$(this).prepend(a)


		$(this).click ->
			if ($(this).parent().children(".collapse").hasClass "hidden")
				$(this).children(".ui-icon").addClass "ui-icon-triangle-1-s"
				$(this).children(".ui-icon").removeClass "ui-icon-triangle-1-e"

				$(this).parent().children(".collapse").show()
				$(this).parent().children(".collapse").removeClass "hidden"
			else
				$(this).children(".ui-icon").removeClass "ui-icon-triangle-1-s"
				$(this).children(".ui-icon").addClass "ui-icon-triangle-1-e"

				$(this).parent().children(".collapse").hide()
				$(this).parent().children(".collapse").addClass("hidden")

@generate_data_inputs = (classes) ->
  $(classes).each ->
    data_id=$(this).attr("id")
    $(this).click ->
      console.log data_id
      td_elem=$("span.data-entry-input#"+data_id)
      old_text=td_elem.text()
      pre_rec=data_id.split("_")[0]
      post_rec=data_id.split("server_")[1]
      console.log pre_rec
      console.log post_rec
      td_elem.text("")
      input_element=$('<input type="text" name="'+pre_rec+'['+post_rec+']" value="'+old_text+'"/>').css("float","left").css("width","60%")
      td_elem.prepend(input_element)
      button_edit=$('<span class="ui-button ui-state-default ui-corner-all ui-icon ui-icon-check"></span>')
      button_cancel=$('<span class="ui-button ui-state-default ui-corner-all ui-icon ui-icon-cancel"></span>')
      td_elem.append(button_cancel)
      td_elem.append(button_edit)

