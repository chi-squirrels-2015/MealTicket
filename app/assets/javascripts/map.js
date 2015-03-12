$(document).ready(function(){

  L.mapbox.accessToken = 'pk.eyJ1IjoiYWlyd2luMzMiLCJhIjoiLTJOUnFoOCJ9.i3f8IJ93mGkh9BCiULG53w';

  var map = L.mapbox.map('map', 'airwin33.ldh7b6gb').locate({setView: true, maxZoom: 14});

  var currentLoc = L.marker();
  var markerLayer = L.mapbox.featureLayer();
  markerLayer.on('click', function(e) {
    map.panTo(e.layer.getLatLng());
  });

  var geocoderControl = L.mapbox.geocoderControl('mapbox.places');
  geocoderControl.addTo(map);
  var locateControl = L.control.locate({drawCircle: false, keepCurrentZoomLevel: true, locateOptions: {maxZoom:14}, showPopup: false});
  locateControl.addTo(map);

  map.on('locationfound', function(event){
    currentLoc.setLatLng(event.latlng).addTo(map);
    addMarkers();
  });

  geocoderControl.on('found', function(response){
    var lat = response.results.features[0].geometry.coordinates[1];
    var lng = response.results.features[0].geometry.coordinates[0];
    currentLoc.setLatLng([lat,lng]).addTo(map);
    addMarkers();
  });

  var addMarkers = function() {
    markerLayer.clearLayers();
    markerLayer.loadURL('/closest_restaurants?lat=' + currentLoc.getLatLng().lat + '&lng=' + currentLoc.getLatLng().lng)
      .addTo(map);

    markerLayer.on('layeradd', function(e){
      var marker  = e.layer,
          feature = marker.feature,
          content = e.layer.feature.properties;

      var markerColor = "#999999",
          popup       = '<p>' + content.name + '<br /><img src="' + content.rating_url + '"/><br />' + content.review_count + ' reviews</p>' + '<p>' + content.address + '</p><p>No MealTicket at this time.</p>';

      if(feature.properties.active_promotions > 0) {
        markerColor = "#F07241";
        popup   = '<p>' + content.name + '<br /><img src="' + content.rating_url + '"/><br />' + content.review_count + ' reviews</p>' + '<p>' + content.address + '</p>' + '<a class="btn btn-promotions" href="/restaurants/' + content.id + '">' + content.active_promotions + ' Promotions</a>';
      }

      marker.setIcon(L.mapbox.marker.icon({
          'marker-color': markerColor,
      }));

      marker.bindPopup(popup);
    });

  }
});
