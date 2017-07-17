$(function(){
  $('.refresh').on('click', function(){
    $.ajax({
      method: "GET",
      url: "/user_channels/refresh/" + $(this).data('channel-id'),
      async: false,
      done: function(res){
        console.log(res.message);
      },
      fail: function(xhr, res){
        console.log(res.message);
      }
    });
  });
});