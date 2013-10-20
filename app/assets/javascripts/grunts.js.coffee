$(window).load () ->
  $("#new_grunt").submit (e) ->
    e.preventDefault()
    $.ajax
      url: $('#new_grunt').attr('action')
      type: "POST"
      dataType: "json"
      data: $('#new_grunt').serialize()
      success: (msg) ->
        alert msg
      error: (xhr, status) ->
        $('body').html(xhr.responseText)
