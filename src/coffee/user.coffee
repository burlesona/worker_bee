# GLOBAL SCOPE
root = exports ? this

class Hive.UserHandler extends Hive.UiObject
	constructor: ->
		@name = 'userHandler'
		@viewport = 'session'
		this.loadUser()
		console.log "Called this constructor"

	bind: (container) ->
		@container = container
		@logout = @container.find('a')
		console.log @logout
		this.bindLink()

	loadUser: ->
		console.log "Loading User"
		self = this
		if Hive.data.user ?
			@data = Hive.data.user
		else
			$.ajax
				url: Hive.resource('me')
				error: (xhr, status, error) ->
					# Display error in the messagebar
				success: (data, status, error) ->
					Hive.data.user = data
					self.data = data 

	bindLink: ->
		console.log "Called bind link"
		@logout.click (event) ->
			event.preventDefault()
			console.log "Calling logout"
			Hive.logout()