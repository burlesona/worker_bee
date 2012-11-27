# Load all the necessary files via requireJS, then start the app.
require ['jquery','controller','views','ui','login','user','projects','stories'], ($) ->
	jQuery ->
		Hive.start()

# GLOBAL SCOPE
root = exports ? this

# The Parent Hive Object, basically a container for the app.
root.Hive =
	# Data obtained from the API is stored here using its resource name as the key.
	data:
		{}

	# This method is called first. It checks for a logged-in user,
	# and if it finds one if loads the app. If there is no logged-in user,
	# it calls the login handler.
	start: ->
		console.log "START!"
		# See if a user is already logged in, and load the app if so.
		if localStorage['api_key']?
			# Set the default Ajax values for the app.
			$.ajaxSetup
				dataType: 'JSON'
				headers: { 'X-Zen-ApiKey': localStorage['api_key'] }

			# Load the User Handler (allows logout)
			userHandler = new Hive.UserHandler # Shows logged-in status and allows logout

			# Load the current view
			Hive.Controller.load()

		# If a user is not logged in, prompt to login.
		else
			loginHandler = new Hive.LoginHandler


	# Login a user and restart the app
	login: (key, user) ->
		localStorage['api_key'] = key
		Hive.data.user = user
		Hive.start()

	# Logout a user, clear local storage, and restart the app
	logout: ->
		localStorage.removeItem('api_key')
		this.data = {}
		this.setMessage 'Logged Out'
		Hive.start()

	# Converts a resource name into a URL
	resource: (name) ->
		"https://agilezen.com/api/v1/" + name

	# Get data from the memory or load from API, then run the callback function.
	getData: (name, callback) ->
		if Hive.data[name]?
			callback(Hive.data[name])
		else
			$.ajax
				url: Hive.resource(name)
				async: false
				error: (xhr, status, error) ->
					# TODO: Display error in the toolbar?
				success: (data, status, error) ->
					Hive.data[name] = data
					callback(data) if callback?

	# Send data to the API and save it to memory.
	setData: (name, data, callback) ->
		console.log "send data"
		console.log data
		$.ajax
			url: Hive.resource(name)
			async: false
			contentType: 'application/json'
			type: 'PUT'
			data: JSON.stringify(data)
			dataType: 'text'
			error: (xhr, status, error) ->
				console.log xhr
				console.log status
				console.log error
			success: (response, status, error) ->
				Hive.data[name] = response
				callback(response) if callback?


	# Set application status messages.
	setMessage: (message) ->
		element = Hive.Views.statusMessage(message)
		Hive.Controller.setViewport 'toolbar', element