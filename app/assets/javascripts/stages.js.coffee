# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#stage').sortable
	axis: 'y'
	handle: '.handle'
	update: ->
		stages_id = []
		$('.stage').each ->
			stages_id.push($(this).attr('id'))
		$.post $(this).data('update-url'), 'stages_id': stages_id

