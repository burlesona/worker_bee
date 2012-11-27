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
	load: (resource, data = null) ->
		if resource?
			# load that view
			handler = this.handlerizeString( resource )
			viewHandler = new Hive[handler] data

		else if localStorage['active_project']?
			# load the last project that was open
			handler = new Hive.ProjectHandler localStorage['active_project']
		
		else
			# load the project selector
			projectSelector = new Hive.ProjectSelector

	# Convert a string for a resouce into the name of its handler.
	handlerizeString: (string) ->
    string = string.replace /\w\S*/g, (txt) ->
    	txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
    string + "Handler"