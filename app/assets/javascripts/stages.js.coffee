# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

refresh_map = (stages) -> 
	for stage, i in stages
		polyline._latlngs[i].lat = stage[0]
		polyline._latlngs[i].lng = stage[1]
	polyline.redraw()


$('#stage').sortable
	axis: 'y'
	handle: '.index'
	update: ->
		stages_id = []
		$('.stage').each ->
			stages_id.push($(this).attr('id'))
		$.post $(this).data('update-url'), 'stages_id': stages_id, refresh_map
