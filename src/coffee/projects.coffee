# GLOBAL SCOPE
root = exports ? this

# Displays a list of the user's projects
class Hive.ProjectSelector extends Hive.UiObject
	constructor: ->
		@resource = 'projects'
		@name = 'projectSelector'
		@viewport = 'main'
		this.load()
		this.render()

	bind: (container) ->
		console.log "Called bind on project"
		@container = container
		projects = @data.items
		new Hive.ProjectSelector.Item(project) for project in projects

# Handler for the invididual projects in a project selector
class Hive.ProjectSelector.Item extends Hive.UiObject
	# Won't call load, so no need to define @resource
	# @data is set in constructor
	constructor: (@data) ->
		@container = Hive.Views.projectSelectorItem( data )
		@parent = $('div.project_selector')
		@container.hide()
		@parent.append(@container)
		@container.fadeIn 500, =>
			this.bind()

	bind: ->
		@container.find('a').click (event) ->
			event.preventDefault()
			console.log "Selected Project"



