# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
$(document).ready ->
	$("#check_all").click ->
		if this.checked == true
			$(".del_check").each ->
				this.checkd=true
		else
			$(".del_check").each ->
				this.checked=false
	create_buttonbar "#dclistbtn",
		add_url:"/admin/dcbackends/new"
		refresh_url:"/admin/dcbackeneds"
		delete_func:delete_dcentries

	$("#backendlist TABLE TBODY TR").each ->
		$(this).click ->
			window.location.href=$(this).attr "url"

delete_dcentries = () ->
	$(".del_check").each ->
		if this.checked == true
			$.ajax
				url: this.value
				type:"delete"
				dataType:"json"
				complete:() ->
					window.location.href="/admin/dcbackends"

