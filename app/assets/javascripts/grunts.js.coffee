# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).ready ($) ->
	formData = $('form').serialize();
	$("form").submit ->
		$.ajax
			url: "/grunts/create"
			type: "POST"
			dataType: "json"
			data: formData
			processData: false
			success: (msg) ->
				console.log 'success'
				alert msg
			error: (xhr, status) ->
				alert xhr.error