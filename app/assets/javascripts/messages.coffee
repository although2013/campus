dispatcher = new WebSocketRails('localhost:3000/websocket');

channel = dispatcher.subscribe('orders');

channel.bind('new_order', (user) ->
  if !($('#newest-order').length)
    $('.orders').prepend('<div id="newest-order">' + user + ' 发布了新的任务</div>')
  else
    $('#newest-order').html(user + ' 发布了新的任务')
)

channel.bind('order_gotten', (order_id) ->
  selector = '.order' + order_id
  if ($(selector).length)
    $((selector + ' .button_to .btn')).val('已被接单').prop('disabled', true);
)