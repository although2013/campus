MessageBus.start();


MessageBus.subscribe("/create_new", function(data){
  alert(data);
});