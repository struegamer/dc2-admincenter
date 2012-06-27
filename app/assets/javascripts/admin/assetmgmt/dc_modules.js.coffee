# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
$(document).ready ->
  $('#check_all').click ->
    if this.checked==true
      $('.del_check').each ->
        this.checked=true
    else
      $('.del_check').each ->
        this.checked=false

  create_buttonbar '#modulebtn',
    add_url:'/admin/assetmgmt/dc_modules/new'
    refresh_url:'/admin/assetmgmt/dc_modules'
    delete_func:delete_am_modules

  $('#modulelist TABLE TBODY TR').each ->
    $(this).children('TD.data-cell').clicl ->
      window.location.href=$(this).parent().attr 'url'

delete_am_modules = () ->
  $('.del_check').each ->
    if this.checked==true
      a=$.ajax
        url:this.value
        type:'delete'
        dataType:'json'
      a.done ->
        window.location.href='/admin/assetmgmt/dc_modules'


