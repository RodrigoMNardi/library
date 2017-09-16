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

  $.get '/books/filtered', {filter: filter}, (data) ->
    console.log data
    $('#list').html data
    return
  