# GLOBAL SCOPE
root = exports ? this

# Common Logic for all UI Objects
class Hive.UiObject
	# Any class that inherits must set the following properties in its constructor:
	# @name is the name used for instances.
	# @viewport is the name of the viewport this element should appear in.
	# @data is the data for that instance, if there is data that should be rendered to the view.

	# Any class that inherits must also set the following methods:
	# this.bind() is the function for binding any 

	render: ->
		self = this
		element = Hive.Views[@name](@data)
		Hive.Controller.setView @viewport, element, ->
			self.bind element