#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require websocket_rails/main
#= require_tree .
#= require_self


count_down_1_sec = (h,m,s) ->
  time = h * 3600 + m * 60 + s
  time = time - 1
  if time <= 0
    return ""
  h = parseInt(time / 3600)
  m = parseInt((time / 60) % 60)
  s = parseInt(time % 60)
  if h == 0
    str =  "还剩：" + check_num(m) + '分' + check_num(s) + '秒'
  else
    str =  "还剩：" + check_num(h) + '小时' + check_num(m) + '分' + check_num(s) + '秒'
  return str

check_num = (num) ->
  if num < 10
    num = "0" + num
  return num

time_down = (selector) ->
  if $(selector).length

    $(selector).each ->

      if $(this).text().length == 13
        h = parseInt($(this).text().slice(3,5))
        m = parseInt($(this).text().slice(7,9))
        s = parseInt($(this).text().slice(10,12))
        str = count_down_1_sec(h,m,s)
        $(this).text(str)
      else if $(this).text().length == 9
        m = parseInt($(this).text().slice(3,5))
        s = parseInt($(this).text().slice(6,8))
        str = count_down_1_sec(0,m,s)
        if str.length > 5
          $(this).text(str)
        else
          $(this).text("已经截止...")
    t=setTimeout(()->
      time_down(selector)
    ,1000);



$(document).on 'page:change', ->
  time_down('.time-down')
