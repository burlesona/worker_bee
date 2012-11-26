# GLOBAL SCOPE
root = exports ? this

# Common Logic for all UI Objects
class Hive.UiObject
	# Any class that inherits must set the following properties in its constructor:
	# @resource is the name of the corresponding resource in the API.
	# @name is the name used for instances.
	# @viewport is the name of the viewport this element should appear in.
		
	# Any class that inherits must also set the following methods:
	# this.bind() is the function for binding any events on the dom.

	# To render with data, a child class must provide @data, or call load().

	render: ->
		self = this
		element = Hive.Views[@name] @data
		Hive.Controller.setViewport @viewport, element, ->
			self.bind element

	load: ->
		self = this
		Hive.getData @resource, ->
			self.data = Hive.data[self.resource]