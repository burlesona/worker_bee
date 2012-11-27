# GLOBAL SCOPE
root = exports ? this

# Common Logic for all UI Objects
class Hive.UiObject
	# Any class that inherits must set the following properties in its constructor:
	# @resource is the name of the corresponding resource in the API.
	# @name is the name used for instances.

	# UI Objects can define either a Viewport or Parent.
	# @viewport is the name of the viewport this element should appear in.
	# @parent is the name of the parent object, if the element will not take a whole viewport.
		
	# Any class that inherits must also set the following methods:
	# this.bind() is the function for binding any events on the dom.

	# To render with data, a child class must provide @data, or call load().

	render: (callback) ->
		self = this
		element = Hive.Views[@name] @data
		
		if @viewport?
			Hive.Controller.setViewport @viewport, element, ->
				self.bind element
		else if @parent?
			@parent.append element
			self.bind element
		else
			console.log "Warning: Nowhere to render #{@name}"

		callback() if callback?

	load: ->
		Hive.getData @resource, => #fat arrow!
			@data = Hive.data[@resource]

	bind: ->
		console.log "Warning: Bind was not set on #{@name}"