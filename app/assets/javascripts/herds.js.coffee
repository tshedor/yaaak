# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).ready ($) ->
	evtSource = new EventSource('/stream')
	isEmpty = (str) ->
		!str || 0 is str.length
	evtSource.onmessage = (e) ->
		resp = JSON.parse(e.data)
		console.log resp.message
		if !isEmpty
			$('.chat-list').append('<li>'+resp.message+'</li>')
	console.log evtSource
	$('form').submit (e)->
		$.post '/stream',
			message: $('input').val()
		console.log e
		return false
	$('.submit').click ->
		$.post '/stream',
			message: $('input').val()

		return false