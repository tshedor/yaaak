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
    customChatMarker: function(herdid, pos, map) {
      var customLocationMarker, customLocationWindow, herderstring;
      herderstring = '<div class="herd"><ul class="chat-list">'
  	  var herdrequest = $.getJSON('/herds/'+herdid+'.json', function(data){
  	    $.each(data.grunts, function(key, val){
  	      herderstring += messageDisplay(val)
  	    });
  	    herderstring += '</ul></div>'
      });

      customLocationMarker = new google.maps.Marker({
        position: pos,
        map: map,
        animation: google.maps.Animation.DROP,
      });
  	  herdrequest.complete(function(){
  	  	customLocationWindow = new google.maps.InfoWindow({
  	  		content: herderstring
      	});
      	google.maps.event.addListener(customLocationMarker, 'click', function() {
      		return customLocationWindow.open(map, customLocationMarker);
      	});
      	return customLocationMarker;
      });

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
      if($('body').hasClass('range')){
        gmapsPosition = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        yakapp.rangemap.panTo(gmapsPosition);
        if (typeof yakapp.CLM !== "undefined") {
          yakapp.CLM.setPosition(gmapsPosition);
        } else {
          yakapp.CLM = yakfunc.currentLocationMarker(yakapp.rangemap);
          yakapp.HLM = yakfunc.customChatMarker(1, gmapsPosition, yakapp.rangemap);
        }
      }
      yakapp.position = [position.coords.latitude, position.coords.longitude];
      $('#grunt_geo_long').val(position.coords.longitude)
      $('#grunt_geo_lat').val(position.coords.latitude)
    }), function(error) {
      alert('Lone ranger, get back on the beaten trail. We can\'t locate you.');
    });
  };

  if (Notification && Notification !== "granted") {
    Notification.requestPermission(function(status) {
      if (Notification.permission !== status) {
        return Notification.permission = status;
      }
    });
  }

  callNotification = function(content) {
    var n;
    if (Notification && Notification.permission === "granted") {
      n = new Notification(content);
      n.onshow = function() {
        return setTimeout(n.close, 5000);
      };
    }
    return Notification.requestPermission(function(status) {
      if (Notification.permission !== status) {
        Notification.permission = status;
      }
      if (status === "granted") {
        n = new Notification(content);
        return n.onshow = function() {
          return setTimeout(n.close, 5000);
        };
      }
    });
  };

  jQuery(document).ready(function($) {

    if ($('body').hasClass('range')) {
      yakapp.rangeOptions = {
        zoom: 8,
        streetViewControl: false,
        mapTypeControl: false,
        zoomControlOptions: {
          style: google.maps.ZoomControlStyle.SMALL,
          position: google.maps.ControlPosition.LEFT_BOTTOM
        },
    	panControlOptions: {
          position: google.maps.ControlPosition.LEFT_BOTTOM
    	},
        styles: yakapp.mapStyles,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      yakapp.rangemap = new google.maps.Map($('#map_canvas')[0], yakapp.rangeOptions);
      if (navigator.geolocation) {
        yakapp.rangemap.setZoom(16);
      } else {
        return alert('Find your herd and turn on your geolocation.');
      }
    }
    if (navigator.geolocation) {
      updateLocation();
      return setInterval(function() {
        return updateLocation();
      }, 25000);
    }
  });

}).call(this);