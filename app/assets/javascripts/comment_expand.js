$(document).on('turbolinks:load',function(){
  $(".toggleComment").click(function(){
     $(this).next('div').toggleClass('collapse');
     $(this).hide()
  });
  $(".toggleNewComment").click(function(){
     $(this).parent().prev('div').children('div').toggleClass('collapse');
     $(this).hide()
  });
});
