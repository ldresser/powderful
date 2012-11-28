

  var map
  

  function initialize(lat,lng) {
  	
    var mapOptions = {
      center: new google.maps.LatLng(lat,lng),
      zoom: 8,
      mapTypeId: google.maps.MapTypeId.TERRAIN
    };
    
    map = new google.maps.Map(document.getElementById("map_canvas"),
        mapOptions);
    
    var markerOptions = {map: map, position: new google.maps.LatLng(lat,lng), title: 'You are here'};
    var marker = new google.maps.Marker(markerOptions);
  }
 


function addMarkers(lat,lng,title) {

  var markerOptions = {map: map, position: new google.maps.LatLng(lat,lng), title: title};
  var marker = new google.maps.Marker(markerOptions);

}



function zoomToFit(lat_max,lng_max,lat_min,lng_min) {
 // function zoomToFit(map_bounds) {
  // fitbounds() takes a SE/NW square of lat/lng coords

  var bounds_box = new google.maps.LatLngBounds(
    new google.maps.LatLng(lat_min,lng_min),
    new google.maps.LatLng(lat_max,lng_max)
    );

  map.fitBounds(bounds_box);
}
