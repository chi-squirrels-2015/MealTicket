$(document).ready(function(){
  $(".btn").on("click", function() {
    $(this).next().toggle();
  });
});
