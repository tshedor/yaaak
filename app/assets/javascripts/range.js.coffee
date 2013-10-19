# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

supportssvg = ->
	if document.implementation.hasFeature("http://www.w3.org/TR/SVG11/feature#Image", "1.1")
		true
	else
		false

supportsSvg = supportssvg()

yakapp =
	mapStyles: []

yakfunc =
	customMarkerBubble: (content, pos, map)->
		customLocationWindow = new google.maps.InfoWindow
			content: content

		customLocationMarker = new google.maps.Marker
			position: pos,
			map:map,
			animation: google.maps.Animation.DROP,
			title: content

		google.maps.event.addListener customLocationMarker, 'click', ->
			customLocationWindow.open(map,customLocationMarker)

		customLocationMarker

	currentLocationMarker: (map)->
		currentPosition = new google.maps.LatLng(yakapp.position[0],yakapp.position[1])
		yakfunc.customMarkerBubble('Current Location', currentPosition, map)

	useSVG: (item)->
		unless supportsSvg
			return item+'.png'
		else
			return item+'.svg'


updateLocation = ->
	navigator.geolocation.getCurrentPosition ((position) ->
		gmapsPosition = new google.maps.LatLng(position.coords.latitude,position.coords.longitude)
		yakapp.position = [position.coords.latitude,position.coords.longitude]
		yakapp.rangemap.panTo gmapsPosition
		if typeof yakapp.CLM isnt "undefined"
			yakapp.CLM.setPosition gmapsPosition
		else
			yakapp.CLM = yakfunc.currentLocationMarker(yakapp.rangemap)
		return
	), (error) ->
		alert 'Lone ranger, get back on the beaten trail. We can\'t locate you.'
		return
#GLOBALS

if Notification && Notification isnt "granted"
	Notification.requestPermission (status) ->
		Notification.permission = status  if Notification.permission isnt status

callNotification = (content) ->
	if Notification && Notification.permission is "granted"
		n = new Notification(content)
		n.onshow = ->
			setTimeout(n.close, 5000);

	Notification.requestPermission (status) ->
		if Notification.permission isnt status
			Notification.permission = status
		if status is "granted"
			n = new Notification(content)
			n.onshow = ->
				setTimeout(n.close, 5000);



jQuery(document).ready ($) ->

	if $('body').hasClass 'range'
		yakapp.rangeOptions =
			zoom:8
			streetViewControl:false
			mapTypeControl: false
			zoomControlOptions:
				style: google.maps.ZoomControlStyle.SMALL
			styles: yakapp.mapStyles
			mapTypeId: google.maps.MapTypeId.ROADMAP
		yakapp.rangemap = new google.maps.Map($('#map_canvas')[0], yakapp.rangeOptions)

		if navigator.geolocation
			yakapp.rangemap.setZoom 16
			updateLocation()
			setInterval(->
				updateLocation()
			, 25000)
		else
			alert 'Find your herd and turn on your geolocation.'

