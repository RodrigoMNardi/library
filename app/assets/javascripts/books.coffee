# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@image_add_preview = () ->
  url = $('#book_image').val()
  if url
    $('.image_preview').html("<img src=\"#{url}\" style=\"width:228px;height:304px;\">")
  else
    $('.image_preview').html('')

  return

@books_filter = () ->
  filter = $('#filter').val()
  if filter.length < 3
    filter = ''

  $.get '/books/filtered', {sort: 'title', filter: filter}, (data) ->
    $('#list').html data
    toggle_all()
    return

@sortby = (order) ->
  filter = $('#filter').val()
  $.get '/books/sortby', {sort: 'title', order: order, filter: filter}, (data) ->
    $('#list').html data
    toggle_all()
    return

@toggle = (id) ->
  div = $("#"+id)
  if div.hasClass("hidden")
    div.removeClass("hidden").addClass("show")
  else
    div.removeClass("show").addClass("hidden")

