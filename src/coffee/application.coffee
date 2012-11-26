# Load all the necessary files via requireJS, then start the app.
require ['jquery','controller','views','ui','login','user'], ($) ->
	jQuery ->
		Hive.start()

# GLOBAL SCOPE
root = exports ? this

# The Parent Hive Object, basically a container for the app.
root.Hive =
	# Data needed throughout the app is stored here.
	data:
		{}

	# This method is called first. It checks for a logged-in user,
	# and if it finds one if loads the app. If there is no logged-in user,
	# it calls the login handler.
	start: ->
		console.log "START!"
		# See if a user is already logged in, and load the app if so.
		if localStorage['api_key']?
			console.log "CONTINUE!"
			
			# Set the default Ajax values for the app.
			$.ajaxSetup
				dataType: 'JSON'
				headers: { 'X-Zen-ApiKey': localStorage['api_key'] }

			# Load the User Handler (allows logout)
			userHandler = new Hive.UserHandler # Shows logged-in status and allows logout
		
			# Temporary, clear main view and call user handler. Replace with load main view instead.
			Hive.Controller.setView 'main', '', ->
				userHandler.render()
		

		# If a user is not logged in, prompt to login.
		else
			console.log "PROMPT!"
			loginHandler = new Hive.LoginHandler
			loginHandler.render()
	

	# Login a user and restart the app
	login: (key, user) ->
		console.log "LOGIN!"
		localStorage['api_key'] = key
		Hive.data.user = user
		Hive.start()

	# Logout a user, clear local storage, and restart the app
	logout: ->
		console.log "LOGOUT!"
		localStorage.removeItem('api_key')
		this.data = {}
		Hive.start()

	# Converts a resource name into a URL
	resource: (name) ->
		"https://agilezen.com/api/v1/" + name