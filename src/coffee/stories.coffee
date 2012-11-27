# GLOBAL SCOPE
root = exports ? this

# Handler for a specific story
class Hive.StoryHandler extends Hive.UiObject
	# @data is set in constructor, won't call load.
	constructor: (@data, @project) ->
		@resource = "#{@project.resource}/stories/#{@data.id}"
		@name = 'storyHandler'
		@parent = @project.container
		@status = @data.status
		this.render()

	# Load all the tasks
	bind: (container) ->
		self = this
		@container = container
		@statusIndicator = container.find('div.status')
		Hive.getData @resource+'/tasks', (data) ->
			handler = new Hive.TaskHandler( task, self ) for task in data.items

	# Check whether all the tasks for this story are complete.
	checkTaskStatus: ->
		console.log "Checking Task Status"
		# Kind of hackish to get the data from the dom, but it works.
		unchecked = @container.find("input:checkbox:not(:checked)")
		
		# If there are incomplete tasks, be sure status is 'started'.
		if unchecked.length
			this.toggleStatus('started')

		# Otherwise, mark as ready to pull.
		else
			this.toggleStatus('ready')

	# Change the status if it is not already at the correct state.
	toggleStatus: (string) ->
		if @status == status
			return false
		else
			Hive.setData @resource, {status: string}
			@statusIndicator.attr('class','status ' + string).text(string)

# Handler for task items.
class Hive.TaskHandler extends Hive.UiObject
	# @data is set in constructor, won't call load
	constructor: (@data, @story) ->
		@resource = "#{@story.resource}/tasks/#{@data.id}"
		@name = 'taskHandler'
		@parent = @story.container.find('div.tasks')
		@status = @data.status
		this.render()

	bind: (container) ->
		self = this
		@container = container
		@checkbox = container.find('input[type=checkbox]')
		@text = container.find('span')
		self.checkIfComplete()

		# Toggle status on checkbox toggle
		@checkbox.change ->
			self.toggleStatus()

	# Check the completed tasks when the DOM loads.
	checkIfComplete: ->
		if @data.status == "complete"
			@checkbox.attr 'checked', true
			@text.attr 'class', 'complete'

	# Toggle status of task
	toggleStatus: ->
		if @data.status == "incomplete"
			@data.status = "complete"
			@text.attr 'class', 'complete'
			Hive.setData @resource, {status: 'complete'}, => #fat arrow!
				@story.checkTaskStatus()
		else
			@data.status = "incomplete"
			@text.attr 'class', ''
			Hive.setData @resource, {status: 'incomplete'}, => #fat arrow!
				@story.checkTaskStatus()

			