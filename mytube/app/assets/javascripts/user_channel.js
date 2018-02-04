$(function(){
  $('.refresh').on('click', function(){
    $.ajax({
      method: "GET",
      url: "/user_channels/refresh/" + $(this).data('channel-id'),
      async: true,
      done: function(res){
        console.log(res.message);
        $("videoCnt"+res.user_channel_id).empty().text(res.count);
      },
      fail: function(xhr, res){
        console.log(res.message);
      }
    });
  });
});