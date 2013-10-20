$(document).ready () ->
	
	$('select').selectpicker()
	
	$('#show-hdr').click (e) ->
  	e.preventDefault()
  	$(this).toggleClass('i-close-active').toggleClass('i-settings')
  	$('.hdr').toggleClass('hdr-out')
  	$('.hdr-controls').toggle().toggleClass('flipInY animated')
  	
 