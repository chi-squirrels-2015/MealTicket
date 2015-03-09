$(document).ready(function() {
  var yelpSearchView = new YelpSearchView();
  yelpSearchView.render();
  $("#search").append(yelpSearchView.el);

  $("#search").on("click", "a.result", function(e) {
    e.preventDefault();
    $("#search-results").hide();
    
    var resultIndex = $(this).data("result-index");
    if(resultIndex !== undefined) {
      var newRestaurantView = new NewRestaurantView({
        model: yelpSearchView.collection.models[resultIndex]
      });
    } else {
      var newRestaurantView = new NewRestaurantView({
        model: new Restaurant()
      });
    }

    newRestaurantView.render();
    $("#search").append(newRestaurantView.el);
  });
});
