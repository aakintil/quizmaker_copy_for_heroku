# Inspired by twitter's signup page: twitter.com/signup

$ ->
  # Force this CSS
  $('span.placeholder').parent().css({
    position: 'relative'
  })
  
  # Dynamically find placeholder value
  $(".placeholder").each( ->
    placeholderText = $(this).parent().find("input").attr('placeholder')
    $(this).html(placeholderText)
    $(this).hide()
  )
  
  # Placeholder Behavior
  $("input").focus(->
    # Display only if there isn't any text in the field on focus already
    if($(this).val() == '')
      $(this).parent().find(".placeholder").show()
    else
      $(this).parent().find(".placeholder").hide()
  ).blur(->
      # The regular placeholder kicks in when you lose focus
      $(this).parent().find(".placeholder").hide()
  ).keyup(->
    # Display if they backspace and clear all the text in the field
    if($(this).val() == '')
      $(this).parent().find(".placeholder").show()
    else
      $(this).parent().find(".placeholder").hide()
  )

  # Set focus automatically in the username field on page load
  $("#login").focus()