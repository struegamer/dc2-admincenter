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

change_it = () ->
  console.log this

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
      list_functions "#hostclasses-list", "#hostclasses-add", "hostclasses"
      if $('input[name="action"]').val()=='edit'
        a=$.ajax
          url:'/datactrls/get_class_templates'
          method:'get'
          data:{'backend_id':$("input[name='backend_id']").val()}
          contentType:'application/json; charset=utf-8'
        a.done (data) ->
          console.log data
          for templ in data['templ_list'] 
            $('#classtemplates select').append('<option name="'+templ['name']+'">'+templ['name']+'</option>')
          $('#classtemplates select').change ->
            console.log $(this).val()
            $('#hostclasses-list tbody tr').remove()
            defaultclasses = null
            for templ in data['templ_list']
              if templ['name']==$(this).val()
                hostclasses=templ['classes']
            b=$.ajax
              url:'/datactrls/get_defaultclasses'
              method:'get'
              data:{'backend_id':$("input[name='backend_id']").val()}
              contentType:'application/json; charset=utf-8'
              async:false
            b.done (data) ->
              defaultclasses=data
            b.fail ->
              console.log 'default classes fail'
            console.log defaultclasses
            for classes in hostclasses
              htmlstring='<tr><td><input id="host__needs_removal_" type="checkbox" value="'+classes+'" onchange="$(this).parent(\'td\').parent().remove()" name="host[[needs_removal][]"/></td><td><select id="host_hostclasses_" name="host[hostclasses][]">'
              for defclass in defaultclasses['class_list']
                if defclass['classname']==classes
                  htmlstring+='<option name="'+defclass['classname']+'" selected>'+defclass['classname']+'</option>'
                else
                  htmlstring+='<option name="'+defclass['classname']+'">'+defclass['classname']+'</option>'

              htmlstring+='</select></td></tr>'

              $('#hostclasses-list tbody').append(htmlstring)
        a.fail ->
          console "datactrls templateclasses fail"

  $("#host-interfaces tr.collapse.in").each ->
    $(this).show()
  $("#host-interfaces tr.collapse").each ->
    $(this).hide()

  $("#host-interfaces tr.collapse").each ->
    elem_id=$(this).attr "id"
    $(this).bind "hide", () ->
      $("a[data-target='#"+elem_id+"'] I").removeClass("icon-chevron-down")
      $("a[data-target='#"+elem_id+"'] I").addClass("icon-chevron-right")
 
      $(this).hide()
    $(this).bind "show", () ->
      $("a[data-target='#"+elem_id+"'] I").removeClass("icon-chevron-right")
      $("a[data-target='#"+elem_id+"'] I").addClass("icon-chevron-down")
      $(this).show()

  $('#host-interfaces button.interface-remove').click (event) ->
    console.log 'hello interface remove click'
    $(this).parent().parent().next().remove()
    $(this).parent().parent().remove()
    return false

  $("#host-interfaces button#interfaces-add").click (event) ->
    event.preventDefault()
    a=$.ajax
      "url":"/datactrls/interfaces_new"
      "type":"get"
    a.done (e) ->
      $("#host-interfaces-main-list TBODY#main-interface-body").append(e)
      $("select.interface-types").bind "change", ->
        # TODO: add new interface detail snippet
        console.log $("input[name='backend_id']").val()
        console.log $("input[name='server[_id]']").val()
        $("td#interface-details").children().remove()
        if $(this).val() == "bond_1" or $(this).val() == "bond_2"
          b=$.ajax
            "url":"/datactrls/get_hw_interfaces"
            "type":"get"
            "data":
              "backend_id":$("input[name='backend_id']").val()
              "server_id":$("input[name='server[_id]']").val()
          b.done (e) ->
            console.log e
            $("td#interface-details").html(e)
            $("td#interface-details").children().show()
          return 
        if $(this).val() == "vlan"
          console.log "vlan interface"
          count=0
          interfaces=[]
          $("#host-interfaces-main-list TBODY#main-interface-body TR.interface-row").each ->
            iface_name=$(this).children("td").children("input[name='host[interfaces][][name]']")
            iface_type=$(this).children("td").children("select[name='host[interfaces][][type]']")
            if iface_name.val()!= "" and iface_type.val() != "vlan" and iface_type.val() != "loopback"
              console.log "no vlan"
              interfaces[count]=iface_name.val()
              count++
          vlan_raw_device=$("<select name='host[interfaces][][vlan_raw_device]'></select>")
          for device in interfaces
            vlan_raw_device.append("<option value='"+device+"'>"+device+"</option>")
          $("td#interface-details").append(vlan_raw_device)

