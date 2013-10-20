(function() {
  var callNotification, supportsSvg, supportssvg, updateLocation, yakapp, yakfunc;

  supportssvg = function() {
    if (document.implementation.hasFeature("http://www.w3.org/TR/SVG11/feature#Image", "1.1")) {
      return true;
    } else {
      return false;
    }
  };

  supportsSvg = supportssvg();

  yakapp = {
    mapStyles: []
  };

  yakfunc = {
    customMarkerBubble: function(content, pos, map) {
      var customLocationMarker, customLocationWindow;
      customLocationWindow = new google.maps.InfoWindow({
        content: '<div class="hdr">' + '<div class="quick-view-hdr">' + '<strong>' + content + '</strong>' + '</div><!-- /hdr -->' + '<div class="grunts">' + '</div><!-- /grunts -->' + '<div class="quick-view-meta">' + '</div><!-- /meta -->' + '<button class="yak">Yaaak!</button>' + '</div><!-- /quick view -->'
      });
      customLocationMarker = new google.maps.Marker({
        position: pos,
        map: map,
        animation: google.maps.Animation.DROP,
        title: content
      });
      google.maps.event.addListener(customLocationMarker, 'click', function() {
        return customLocationWindow.open(map, customLocationMarker);
      });
      return customLocationMarker;
    },
    customChatMarker: function(herddata, pos, map) {
      var customLocationMarker, customLocationWindow, herderstring;
      herderstring = '<div class="quick-view">' + '<div class="quick-view-hdr">' + '<strong>Herd</strong>' + '</div><!-- /hdr -->'
      herderstring += '<ul class="chat-list">'
  	  $.each(herddata, function(key, val){
  	  	console.log(val)
  	      herderstring += messageDisplay(val)
  	    });
  	    herderstring += '</ul>'
        herderstring += '<div class="quick-view-meta">' + '</div><!-- /meta -->' + '<a class="i-chats yaaak" href="/herds/">Start Yaaak</a>' + '</div><!-- /quick view -->'

      customLocationMarker = new google.maps.Marker({
        position: pos,
        map: map,
        animation: google.maps.Animation.DROP,
      });
  	  	customLocationWindow = new google.maps.InfoWindow({
  	  		content: herderstring
      	});
      	console.log(herderstring)
      	google.maps.event.addListener(customLocationMarker, 'click', function() {
      		return customLocationWindow.open(map, customLocationMarker);
      	});
      	return customLocationMarker;

    },
    currentLocationMarker: function(map) {
      var currentPosition;
      currentPosition = new google.maps.LatLng(yakapp.position[0], yakapp.position[1]);
      return yakfunc.customMarkerBubble('Current Location', currentPosition, map);
    },
    useSVG: function(item) {
      if (!supportsSvg) {
        return item + '.png';
      } else {
        return item + '.svg';
      }
    }
  };

  updateLocation = function() {
    return navigator.geolocation.getCurrentPosition((function(position) {
      var gmapsPosition;

      yakapp.position = [position.coords.latitude, position.coords.longitude];
      $('#grunt_geo_long').val(position.coords.longitude)
      $('#grunt_geo_lat').val(position.coords.latitude)
      if($('body').hasClass('range')){
        gmapsPosition = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        yakapp.rangemap.panTo(gmapsPosition);
      }
    }), function(error) {
      alert('Lone ranger, get back on the beaten trail. We can\'t locate you.');
    });
  };

  if(window.webkitNotifications){
      var havePermission = window.webkitNotifications.checkPermission();
      if (havePermission !== 0) {
   	    window.webkitNotifications.requestPermission();
   	  }
  } else if (Notification && Notification !== "granted") {
    Notification.requestPermission(function(status) {
      if (Notification.permission !== status) {
        return Notification.permission = status;
      }
    });
  }

  jQuery(document).ready(function($) {

    if ($('body').hasClass('range')) {
      yakapp.rangeOptions = {
        zoom: 8,
        streetViewControl: false,
        mapTypeControl: false,
        zoomControlOptions: {
          style: google.maps.ZoomControlStyle.SMALL,
        },
        styles: yakapp.mapStyles,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      yakapp.rangemap = new google.maps.Map($('#map_canvas')[0], yakapp.rangeOptions);
      $.getJSON('/herds/index.json', function(data){
      	$.each(data, function(key, val){
      	  var gmapsSPOT = new google.maps.LatLng(val.geo_lat, val.geo_long);
          yakfunc.customChatMarker(val.grunts, gmapsSPOT, yakapp.rangemap);
      	});
      });
      if (navigator.geolocation) {
        yakapp.rangemap.setZoom(16);
      } else {
        return alert('Find your herd and turn on your geolocation.');
      }
    }
    if (navigator.geolocation) {
      updateLocation();
      /*return setInterval(function() {
        return updateLocation();
      }, 25000);*/
    }
  });

}).call(this);