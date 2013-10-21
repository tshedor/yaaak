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
				yakfunc.customChatMarker(val, gmapsSPOT, yakapp.rangemap);
			});
		});
		if (navigator.geolocation) {
			yakapp.rangemap.setZoom(14);
		} else {
			alert('Find your herd and turn on your geolocation.');
		}
	}
	if (navigator.geolocation) {
		yakfunc.updateLocation();
		setInterval(function() {
			yakfunc.updateLocation();
		}, 25000);
	}
	$('.range-grunt').toggle().toggleClass('flipInY animated');
});

