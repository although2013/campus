$(document).on "ajax:success", "form", (xhr, data, response) ->
  if data.error
    $('#information').append('<div class="alert alert-warning alert-dismissible"  role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + data.error + '</div>')
