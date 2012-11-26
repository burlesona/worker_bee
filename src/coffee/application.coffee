# GLOBAL SCOPE
root = exports ? this

jQuery ->
	localStorage.removeItem('api_key')
	Hive.start()

root.Hive =
	# Data needed throughout the app is stored here.
	data:
		{}

	# This method is called first. It checks for a logged-in user,
	# and if it finds one if loads the app. If there is no logged-in user,
	# it calls the login handler.
	start: ->
		console.log "START!"
		if localStorage['api_key']?
			this.loadApp()
		else
			login = new Hive.LoginHandler
			login.render()


	# This method runs the rest of the app.
	loadApp: ->
		console.log "Load App!"

		# Set the default Ajax values for the app.
		$.ajaxSetup
			dataType: 'JSON'
			headers: { 'X-Zen-ApiKey': localStorage['api_key'] }

		# Load the User Handler (allows logout)
		userHandler = new Hive.UserHandler # Shows logged-in status and allows logout
		userHandler.render()

	# Login a user
	login: (key, user) ->
		localStorage['api_key'] = key
		Hive.data.user = user
		Hive.UI.clear ->
			Hive.start()

	# Logout a user, clear local storage
	logout: ->
		console.log "Called Logout"
		localStorage.removeItem('api_key')
		this.data = {}
		Hive.UI.clear ->
			Hive.start()

	# Converts a resource name into a URL
	resource: (name) ->
		"https://agilezen.com/api/v1/" + name