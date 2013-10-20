window.toggle_overlay = () ->
	content = $('.overlay-content')
	if content.hasClass('overlayShowing')
		$('body').removeClass('noscroll')
		$('.overlay, .overlay-bg').hide()
		content.removeClass('overlayShowing')
	else
		$('body').addClass('noscroll')
		$('.overlay, .overlay-bg').show()
		content.addClass('overlayShowing')
		center_content()
		overlay_resize()

overlay_resize = () ->
	maskHeight = $(document).height()
	maskWidth = $(window).width()
	$('.overlay-bg').css({ 'width':maskWidth,'height':maskHeight })

window.center_content = () ->
	top = Math.max($(window).height() - $('.overlay').outerHeight(), 0) / 2
	left = Math.max($(window).width() - $('.overlay').outerWidth(), 0) / 2
	$('.overlay').css({ top:top + $(window).scrollTop(), left:left + $(window).scrollLeft() })

$('.overlay-content .destroy').on 'click', () -> toggle_overlay()
$('.overlay-bg').on 'click', () -> toggle_overlay()

$(window).resize () ->
	center_content()
	overlay_resize()
