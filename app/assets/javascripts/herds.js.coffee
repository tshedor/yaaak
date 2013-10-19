# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



jQuery(document).load ($) ->
	evtSource = new EventSource('/herds/1/stream')
	console.log evtSource
	isEmpty = (str) ->
		!str || 0 is str.length

	evtSource.onmessage = (e) ->
		resp = JSON.parse(e.data)
		console.log resp.message
		if !isEmpty
			$('.chat-list').append('<li>'+resp.message+'</li>')

  evtSource.onopen(e) ->
    console.log 'open'

  evtSource.onerror(e) ->
    console.log 'error'


