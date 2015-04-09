#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require websocket_rails/main
#= require moment
#= require bootstrap-datetimepicker
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
      arr = $(this).text().match(/\d+/g)
      if $(this).text().length >= 13
        h = parseInt(arr[0])
        m = parseInt(arr[1])
        s = parseInt(arr[2])
        str = count_down_1_sec(h,m,s)
        $(this).text(str)
      else if $(this).text().length == 9
        m = parseInt(arr[0])
        s = parseInt(arr[1])
        str = count_down_1_sec(0,m,s)
        if str.length > 5
          $(this).text(str)
        else
          $(this).text("已经截止...")
    time_down_in=setTimeout(()->
      time_down(selector)
    ,1000);
    $(document).one 'page:change', ->
      clearInterval time_down_in


time_picker_func = () ->
  if $('#datetimepicker').length
    $('#datetimepicker').datetimepicker({
      inline: false,
      sideBySide: true,
      format: 'YYYY/MM/DD HH:mm',
      extraFormats: [ 'YYYY/MM/DD HH:mm' ]
    });


time_picker_know = () ->
  if $('#show-time-diff').length
    t = $('#datetimepicker input').val()
    if t != ""
      s = moment(t, "YYYY/MM/DD HH:mm")
      del = parseInt((s.toDate() - moment().toDate())/1000)
      h = parseInt(del / 3600)
      m = parseInt((del / 60) % 60)
      s = parseInt(del % 60)
      str = count_down_1_sec(h,m,s)
      $('#show-time-diff').text(str)
    time_picker_know_in=setTimeout(time_picker_know, 900);
    $(document).one 'page:change', ->
      clearInterval time_picker_know_in

star_hover_in = (selector) ->
  $(selector).removeClass("glyphicon-star-empty").addClass("glyphicon-star").css("color", "green")
star_hover_out = (selector) ->
  $(selector).removeClass("glyphicon-star").addClass("glyphicon-star-empty").css("color", "black")

star_success = (num) ->
  $(".star").removeClass("star").addClass("star-set")
  i = 1
  s = ""
  while i <= num
    s = s + " ." + i
    i = i + 1
  s = ".star-set" + s
  star_hover_in(s)




star_click = (num) ->
  $.ajax
      url: 'star'
      type: 'POST'
      data :
        order : window.location.href.split("/")[4]
        star: num
      success: (data, status, response) ->
        if data.error
          alert(data.error);
        else
          star_success(num)
      error: ->
        alert("评分出错啦");
      dataType: "json"


star_pick = () ->
  if $(".star").length
    $(".star .1").hover(
      -> star_hover_in(".star .1")
      -> star_hover_out(".star .1")
    ).click(
      -> star_click(1)
    )
    $(".star .2").hover(
      -> star_hover_in(".star .1, .star .2")
      -> star_hover_out(".star .1, .star .2")
    ).click(
      -> star_click(2)
    )
    $(".star .3").hover(
      -> star_hover_in(".star .1, .star .2, .star .3")
      -> star_hover_out(".star .1, .star .2, .star .3")
    ).click(
      -> star_click(3)
    )
    $(".star .4").hover(
      -> star_hover_in(".star .1, .star .2, .star .3, .star .4")
      -> star_hover_out(".star .1, .star .2, .star .3, .star .4")
    ).click(
      -> star_click(4)
    )
    $(".star .5").hover(
      -> star_hover_in(".star .1, .star .2, .star .3, .star .4, .star .5")
      -> star_hover_out(".star .1, .star .2, .star .3, .star .4, .star .5")
    ).click(
      -> star_click(5)
    )



$(document).on 'page:change', ->
  time_down('.time-down')
  time_picker_func()
  star_pick()



