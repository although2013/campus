$(document).on "ajax:success", "form", (xhr, data, response) ->
  if data.error
    $('#right-panel').append('<div>' + data.error + '</div>')


$(document).on "ajax:error", "form", (xhr, data, response) ->
