# GLOBAL SCOPE
root = exports ? this

class Hive.UserHandler extends Hive.UiObject
	constructor: ->
		@resource = 'me'
		@name = 'userHandler'
		@viewport = 'session'
		this.load()
		this.render()

	bind: (container) ->
		@container = container
		@logout = @container.find('a')
		this.bindLink()

	bindLink: ->
		@logout.click (event) ->
			event.preventDefault()
			Hive.Controller.setViewport 'session', '', ->
				Hive.logout()