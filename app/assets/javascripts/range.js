jQuery(document).ready(function($) {
	if ($('body').hasClass('range')) {
		yakapp.rangeOptions = {
			zoom: 5,
			streetViewControl: false,
			mapTypeControl: false,
			center: new google.maps.LatLng(38.96237430000001, -95.24213780000001),
			zoomControlOptions: {
				style: google.maps.ZoomControlStyle.SMALL,
			},
			styles: yakapp.mapStyles,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		};
		yakapp.rangemap = new google.maps.Map($('#map_canvas')[0], yakapp.rangeOptions);
		yakapp.customChatWindow = new google.maps.InfoWindow()
		$.getJSON('/herds/index.json', function(data){
			$.each(data, function(key, val){
				var gmapsSPOT = new google.maps.LatLng(val.geo_lat, val.geo_long);
				yakfunc.customChatMarker(val, gmapsSPOT, yakapp.rangemap);
			});
		});
		if (navigator.geolocation) {
			yakapp.rangemap.setZoom(12);
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

	yakfunc.localStore('returningUser', true);
});

