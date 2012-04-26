# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
  $('#drag_drop').sortable( 
    axis: 'y'
    handle: '.handle'
    placeholder: "highlight"
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'), location.reload()); 
  )


  $("#drag_drop").sortable({ opacity: 0.6 });

  $("#drag_drop").sortable({ forcePlaceholderSize: true });