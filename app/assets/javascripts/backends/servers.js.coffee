# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
#
#
list_functions = (id,button_add_id,type_of) ->
  $(id+" "+button_add_id).click ->
    if (type_of == "mac") 
      tr_elem=$("<tr><input type='hidden' name='macs[][_id]' value='none'/><td></td><td><input type='text' name='macs[][mac_addr]' value=''/></td><td><input type='text' name='macs[][device_name]' value=''/></td></tr>")

    if (type_of == "rib")
      select_elem=$("#rib-type-list")
      console.log select_elem
      tr_elem=$("<tr><input type='hidden' name='ribs[][_id]' value='none'/><td></td><td>"+$(select_elem).html()+"</td><td><input type='text' name='ribs[][remote_ip]' value''/></td></tr>")

    if (type_of=="hostclasses")
      tr_elem=$("div#hostclasses-names-list table tr")
      console.log tr_elem

    $(id+" TBODY").append(tr_elem)

$(document).ready ->
  $(".collapse").collapse
    "toggle":false
  $("#serverTab a[data-toggle='tab']:first").tab("show")
  $("#hostTab a[data-toggle='tab']:first").tab("show")
  $("#serverTab a[data-toggle='tab']").bind "shown", (e) ->
    if ($(e.target).attr("href")=="#server-mac-addrs")
      list_functions "#server-mac-addr-list","#server-mac-add","mac"
    if ($(e.target).attr("href")=="#server-ribs")
      list_functions "#server-rib-list","#server-rib-add","rib"
  $("#hostTab a[data-toggle='tab']").bind "shown", (e) ->
    if ($(e.target).attr("href")=="#host-classes")
      console.log "hellO"
      list_functions "#hostclasses-list", "#hostclasses-add", "hostclasses"


