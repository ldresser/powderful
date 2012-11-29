

  var map
  var markersArray = []
  

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
    markersArray.push(marker);
  }
 


function addMarkers(lat,lng,title) {

  var markerOptions = {map: map, position: new google.maps.LatLng(lat,lng), title: title};
  var marker = new google.maps.Marker(markerOptions);
  markersArray.push(marker);
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

 function delMarker(delLat,delLng) {
   //var markerOptions = {map: map, position: LatLng(lat,lng), title: "Killington"};
   //var marker = google.maps.Marker(markerOptions);
   //marker.setMap(null);
  //google.maps.Marker(markerOptions).setMap(null);
  //alert(markersArray[0].position);
  var pos = new google.maps.LatLng(delLat,delLng);
  console.log("marker to remove: " + pos); //debug
  for (i = 0; i < markersArray.length; i++){
//    console.log("marker " + i + ": " + markersArray[i].position); // debug
      if (String(markersArray[i].position) == String(pos)) {
        console.log("removing from map " + i + ": " + markersArray[i].position); //debug
        markersArray[i].setMap(null); // remove from the map
        markersArray.splice(i,1); // remove from the array

      }
  }
 }
