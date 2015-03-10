$(document).ready(function(){

  L.mapbox.accessToken = 'pk.eyJ1IjoiYWlyd2luMzMiLCJhIjoiLTJOUnFoOCJ9.i3f8IJ93mGkh9BCiULG53w';

  var map = L.mapbox.map('map', 'airwin33.ldh7b6gb').locate({setView: true, maxZoom: 14});

  var currentLoc = L.marker();
  var markerLayer = L.mapbox.featureLayer(); 

  var geocoderControl = L.mapbox.geocoderControl('mapbox.places');
  geocoderControl.addTo(map);
  var locateControl = L.control.locate({drawCircle: false, keepCurrentZoomLevel: true, locateOptions: {maxZoom:14}}).addTo(map);
 
  geocoderControl.on('found', function(response){ 
    var lat = response.results.features[0].geometry.coordinates[1];
    var lng = response.results.features[0].geometry.coordinates[0];
    currentLoc.setLatLng([lat,lng]).addTo(map);
      
    markerLayer.clearLayers();
    addMarkers();
  });

  $('#geolocate').on("click", function(event) {
    event.preventDefault();
    event.stopPropagation();
    map.locate({setView: true});
  });

  map.on('locationfound', function(event){
    currentLoc.setLatLng(event.latlng).addTo(map);
    markerLayer.clearLayers();
    addMarkers();
  });

  var addMarkers = function() {
    markerLayer.loadURL('/closest_restaurants?lat=' + currentLoc.getLatLng().lat + '&lng=' + currentLoc.getLatLng().lng)
      .addTo(map);

    markerLayer.on('layeradd', function(e){
      var marker = e.layer,
          feature = marker.feature;

      var content = e.layer.feature.properties
      var content = '<p>' + content.name + '</p>' + '<p>' + content.address + '</p>' + '<form action="/restaurants/' + content.id + '"><input type="submit" value="View Promotions"></form>'

      marker.bindPopup(content);

    });

    markerLayer.on('click', function(e) {
      map.panTo(e.layer.getLatLng());
    });
  }
});
