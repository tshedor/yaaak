# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).ready ($) ->
	formData = $(this).serialize();
	console.log $('form').html()
	$("form").submit ->
		console.log formData
		$.ajax
			url: $(this).attr('action')
			type: "POST"
			dataType: "JSON"
			data: formData
			success: (msg) ->
				console.log formData
				alert msg
			error: (xhr, status) ->
				console.error 'errrr'
				console.log formData
				console.log xhr.responseText
				$('body').html(xhr.responseText)
				alert xhr.error
		return false