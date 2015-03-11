$(document).ready(function() {
  var yelpSearchView = new YelpSearchView();
  yelpSearchView.render();
  $("#search").append(yelpSearchView.el);

  $("#search").on("click", "a.result", function(e) {
    e.preventDefault();
    $("#search-results").hide();

    var options = {};
    var resultIndex = $(this).data("result-index");
    if(resultIndex !== undefined) {
      options.model = yelpSearchView.collection.models[resultIndex];
    } else {
      options.model = new Restaurant();
    }

    var newRestaurantView = new NewRestaurantView(options);
    newRestaurantView.render();

    $("#search").append(newRestaurantView.el);
  });
});
