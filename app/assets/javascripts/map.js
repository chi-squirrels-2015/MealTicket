$(document).ready(function(){

  L.mapbox.accessToken = 'pk.eyJ1IjoiYWlyd2luMzMiLCJhIjoiLTJOUnFoOCJ9.i3f8IJ93mGkh9BCiULG53w';

  var map = L.mapbox.map('map', 'airwin33.ldh7b6gb').locate({setView: true, maxZoom: 14});

  map.on('locationfound', function(event){
    var currentLoc = L.marker(event.latlng).addTo(map);
    var featureLayer = L.mapbox.featureLayer()
      .loadURL('/closest_restaurants?lat=' + currentLoc.getLatLng().lat + '&lng=' + currentLoc.getLatLng().lng)
      .addTo(map);
  });
});