# GLOBAL SCOPE
root = exports ? this

# Handler for Login
Hive.LoginHandler = ->

class Hive.LoginHandler extends Hive.UiObject
	constructor: ->
		@name = 'loginHandler'
		@viewport = 'main'
		this.render()

	bind: (container) ->
		@container = container
		@form = container.find('form')
		@text_field = container.find('input#api_key')
		@submit = container.find('input[type=submit]')
		@status = container.find('div.status')
		this.bindForm()
		@text_field.focus()

	bindForm: ->
		self = this
		@form.submit (event) ->
			event.preventDefault()
			self.tryLogin()
			return false

	# Special method for only the login handler, normal objects delegate API calls to Hive.

	# Send a request to get 'me' info from server.
	# If it succeeds, save the user info and api_key and continue as logged in.
	# Otherwise, tell the user the api_key wasn't valid.
	tryLogin: ->
		self = this
		key = @text_field.val()
		$.ajax
			url: Hive.resource('me')
			headers: { 'X-Zen-ApiKey': key }
			dataType: 'JSON'
			error: (xhr, status, error) ->
				self.status.text('Error: invalid key.').attr 'class', 'status error'
				console.log xhr
			success: (data, status, xhr) ->
				self.status.text('').attr 'class', 'status'
				Hive.login key, data