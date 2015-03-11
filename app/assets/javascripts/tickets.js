$(document).ready(function(){
  $(".view-tickets-btn").on("click", function(event) {
    event.preventDefault();

    var request = $.ajax({
      url: $(this).attr('href'),
      method: "GET"
    })

    request.done(function(response) {
      $(".ticket-div").empty();
      $(".ticket-div").append(response)
    })

  });
});