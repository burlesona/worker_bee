# GLOBAL SCOPE
root = exports ? this

Hive.Controller =
	# Selectors for the primary viewports.
	main: -> $('section#main')
	toolbar: ->	$('div#toolbar')
	session: -> $('div#session')

	# Place content in a viewport.
	setViewport: (viewName, content, callback) ->
		console.log "SET VIEWPORT: " + viewName
		this[viewName]().fadeOut 500, ->
			$(this).html( content ).fadeIn 500, ->
				callback() if callback?

	# Load the view for a given resource.
	load: (resource) ->
		if resource?
			# load that view
		else if localStorage['active_resource']?
			# load that view
		else if localStorage['active_project']?
			# load that project view
		else
			projectSelector = new Hive.ProjectSelector
