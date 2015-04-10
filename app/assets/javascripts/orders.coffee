
$(document).on "ajax:success", "form", (xhr, data, response) ->
  if data.error
    $('#information').append('<div class="alert alert-warning alert-dismissible"  role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + data.error + '</div>')


$(document).on "ajax:success", "form", (xhr, data, response) ->
  if $('.finished-btn').length
    if data.error
      alert("出错了,无法确认订单已完成。")

