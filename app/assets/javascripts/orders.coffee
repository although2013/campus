$(document).on "page:change", ->
  $(".get_order").on("ajax:success", (e, data, status, xhr) ->

  ).on "ajax:error", (e, xhr, status, error) ->
    alert("get_order失败")