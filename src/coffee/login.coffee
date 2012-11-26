Hive.LoginHandler = ->

Hive.LoginHandler.prototype =
	initialize: (container) ->
		console.log container
		@container = container
		@form = container.find('form')
		@text_field = container.find('input#api_key')
		@submit = container.find('input[type=submit]')
		this.bindForm()

	bindForm: ->
		self = this
		@form.submit (event) ->
			event.preventDefault()
			self.callApi()
			return false

	callApi: ->
		key = @text_field.val()
		$.ajax
			url: 'https://agilezen.com/api/v1/me'
			dataType: 'JSON'
			headers: { 'X-Zen-ApiKey': key }
			error: (xhr, status, error) ->
				console.log status
				console.log xhr
			success: (data, status, xhr) ->
				console.log status
				console.log data
				localStorage['api_key'] = key
				Hive.start()

	render: ->
		container = Hive.Templates.loginHandler()
		$('section#main').hide().html( container ).fadeIn(1500)
		this.initialize $('div#login')