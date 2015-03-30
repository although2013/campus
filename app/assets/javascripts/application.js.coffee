#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require_tree .
#= require_self

time_down = () ->
  if $(".time-down").length

    time_now = parseInt(Date.now() / 1000)
    $(".time-down").each ->
      del = (parseInt($(this).text()) - time_now)

      s = parseInt(del %60)
      m = parseInt((del /60) % 60)
      h = parseInt(del /3600)

      s = check_zero(s) + '秒'
      m = check_zero(m) + '分'
      h = check_zero(h) + '小时'

      str = "还剩: " + h + m + s
      $(this).text(str)

check_zero = (num) ->
  if num == 0
    num = "00"
  else if num < 10
    num = "0" + num

  return num




$(document).on 'page:change', ->
  time_down()
  