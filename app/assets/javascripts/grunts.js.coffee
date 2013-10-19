# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).ready ($) ->

	$("form").submit ->
		formData = $(this).serialize();
		$.ajax
			url: $(this).attr('action')
			type: "POST"
			dataType: "JSON"
			data: formData
			success: (msg) ->
				alert msg
			error: (xhr, status) ->
				console.log xhr.responseText
		return false