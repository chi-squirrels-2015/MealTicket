// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require underscore
//= require backbone
//= require_tree ./templates
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views
//= require_tree .

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

 

  L.mapbox.accessToken = 'pk.eyJ1IjoiYWlyd2luMzMiLCJhIjoiLTJOUnFoOCJ9.i3f8IJ93mGkh9BCiULG53w';

  var coords = navigator.geolocation.getCurrentPosition(function(pos){ return pos });

  var map = L.mapbox.map('map', 'airwin33.ldh7b6gb').locate({setView: true, maxZoom: 16});
});


