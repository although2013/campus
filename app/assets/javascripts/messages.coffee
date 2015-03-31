

dispatcher = new WebSocketRails('localhost:3000/websocket');


channel = dispatcher.subscribe('orders');
channel.bind('get_order', (server)->
  console.log('User: ' + server + ' get your order!');
)

