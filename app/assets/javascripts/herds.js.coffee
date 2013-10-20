# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



jQuery(document).ready ($) ->
	evtSource = new EventSource('/herds/1/stream')
	console.log evtSource
	isEmpty = (str) ->
		!str || 0 is str.length

	evtSource.onmessage = (e) ->
		resp = JSON.parse(e.data)
		$('.chat-list').append('<li>'+e.data+'</li>')

	evtSource.onopen = (e) ->
		console.log 'open'
	evtSource.onerror = (e) ->
		console.log 'error'
		console.log e
	evtSource.onclose = (e) ->
		console.log 'close'