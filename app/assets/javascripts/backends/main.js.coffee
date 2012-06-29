# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
#
#
tabify = (id) -> 
  $(id + " a[data-toggle='tab']").click (e) ->
    e.preventDefault()
    $(this).tab("show")

show_data = (elem,target) ->
  $(elem).each ->
    $(this).click ->
      window.location.href=$(this).attr "data-show-url"

$(document).ready ->
  tabify "#inventory"
  $('#inventory a[data-toggle="tab"]').bind 'show', (e) ->
    console.log $(e.target).attr "href"
    dcb_id=$($(e.target).attr "href").attr "data-dc-record"
    if $(e.target).attr('href') == '#servers'
      tbody=$("#serverlist TBODY")
      a=$.ajax
        url:dcb_id
        type:"GET"
        dataType:"html"
      a.done (data) ->
        $("#serverlist").dataTable().fnDestroy()
        $(tbody).children().remove()
        $(tbody).append(data)
        $("#serverlist").dataTable
          "bDestroy": true
          "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
          "sPaginationType": "bootstrap"
          "iDisplayLength": 25
          "fnCreatedRow":(nRow,aData,iDataIndex) ->
            $(nRow).click ->
              window.location.href = $(this).attr("data-show-url")
      a.fail ->
        console.log 'fail'
      return
    if $(e.target).attr('href') == '#hosts'
      tbody=$('#hostlist TBODY')
      a=$.ajax
        url:dcb_id
        type:'GET'
        dataType:'html'
      a.done (data) ->
        $('#hostlist').dataTable().fnDestroy()
        $(tbody).children().remove()
        $(tbody).append(data)
        $('#hostlist').dataTable
          'bDestroy':true
          'sDom':"<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
          'sPaginationType':'bootstrap'
          "iDisplayLength": 25
          'fnCreatedRow':(nRow,aData,iDataIndex) ->
            $(nRow).click ->
              window.location.href = $(this).attr('data-show-url')
      a.fail ->
        console.log "fail"
      return
    if $(e.target).attr('href') == '#deployment-control'
      tbody=$('#deploymentlist TBODY')
      a=$.ajax
        url:dcb_id
        type:'GET'
        dataType:'html'
      a.done (data) ->
        $('#deploymentlist').dataTable().fnDestroy()
        $(tbody).children().remove()
        $(tbody).append(data)
        $('#deploymentlist').dataTable
          'bDestroy':true
          'sDom':"<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
          'sPaginationType':'bootstrap'
          "iDisplayLength": 25
          'fnCreatedRow':(nRow,aData,iDataIndex) ->
            $(nRow).children('td').children('select.installstatus').each ->
              cell=$(this).parent()
              $(this).change (e) ->
                a=$.ajax
                  url:$(e.target).parent().parent().attr('data-show-url')+'.json'
                  contentType:'application/json'
                  type:'PUT'
                  dataType:'json'
                  data:JSON.stringify({backend_id: $(e.target).parent().attr('data-dcb-id'), status:$(e.target).val()})
                a.done ->
                  bgColor=cell.css('background-color')
                  cell.animate({backgroundColor:'#ff9900'},500).animate({backgroundColor:bgColor},500)
                a.fail ->
                  console.log "fail"
                return

      a.fail ->
        console.log "fail"
      return
          

  $("#inventory a[data-toggle='tab']:first").tab("show")


