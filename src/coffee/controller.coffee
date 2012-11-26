# GLOBAL SCOPE
root = exports ? this

Hive.Controller =
	# Selectors for the primary view areas.
	main: -> $('section#main')
	message: ->	$('div#message_bar')
	session: -> $('div#session')

	# Place content in a view.
	setView: (viewName, content, callback) ->
		console.log "SET VIEW: " + viewName
		this[viewName]().fadeOut 500, ->
			$(this).html( content ).fadeIn 500, ->
				callback()