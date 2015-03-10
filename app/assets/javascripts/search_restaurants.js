$(document).ready(function() {
  var yelpSearchView = new YelpSearchView();
  yelpSearchView.render();
  $("#search").append(yelpSearchView.el);

  $("#search").on("click", "a.result", function(e) {
  });
});
