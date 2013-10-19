# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).ready ($) ->

	$("#new_grunt").submit ->
		formData = $(this).serialize();
		$.ajax
			url: $(this).attr('action')
			type: "POST"
			dataType: "JSON"
			data: formData
			success: (msg) ->
				alert msg
			error: (xhr, status) ->
				$('body').html(xhr.responseText)
		return false