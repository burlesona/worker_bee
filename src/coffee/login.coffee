# Handler Object, presents a login form and
Hive.LoginHandler = ->

Hive.LoginHandler.prototype =
	initialize: (container) ->
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
			self.callApi()
			return false

	callApi: ->
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

	render: ->
		container = Hive.Templates.loginHandler()
		Hive.UI.viewport().hide().html( container ).fadeIn(1500)
		this.initialize container


Hive.UserHandler = ->
	this.loadUser() unless Hive.data.user?


Hive.UserHandler.prototype =
	initialize: (element) ->
		@container = element.parent()
		@logout = @container.find('a')
		console.log @logout
		this.bindLink()

	loadUser: ->
		console.log "Loading User"
		$.ajax
			url: Hive.resource('me')
			error: (xhr, status, error) ->
				# Display error in the messagebar
			success: (data, status, error) ->
				Hive.data.user = data

	bindLink: ->
		console.log "Called bind link"
		@logout.click (event) ->
			event.preventDefault()
			console.log "Calling logout"
			Hive.logout()

	render: ->
		console.log "called render"
		self = this
		element = Hive.Templates.userHandler( Hive.data.user )
		Hive.UI.user().hide().html( element ).fadeIn 1000, ->
			self.initialize( element )
