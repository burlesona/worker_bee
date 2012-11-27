# GLOBAL SCOPE
root = exports ? this

# Handler to display the project selector window.
class Hive.ProjectSelector extends Hive.UiObject
	constructor: ->
		@resource = 'projects'
		@name = 'projectSelector'
		@viewport = 'main'
		this.load()
		this.render ->
			Hive.setMessage 'Please Select a Project'

	# Load up the individual project selectors
	bind: (container) ->
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
		@container.css {opacity: 0}
		@parent.append(@container)
		@container.animate {opacity: 1}, 500, => #fat arrow!
			this.bind()

	bind: ->
		@container.find('a').click (event) => #fat arrow!
			event.preventDefault()
			Hive.Controller.load 'project', @data.id


# Handler to display a specific project
class Hive.ProjectHandler extends Hive.UiObject
	constructor: (projectId) ->
		@resource = "projects/#{projectId}"
		@name = 'projectHandler'
		@viewport = 'main'
		this.load()
		this.render => #fat arrow!
			Hive.setMessage "#{@data.name}"
			localStorage['active_project'] = @data.id

	bind: (container) ->
		self = this
		@container = container
		Hive.getData @resource+'/stories?where=phase:ready or phase:working', (data) ->
			stories = data.items
			new Hive.StoryHandler( story, self ) for story in stories