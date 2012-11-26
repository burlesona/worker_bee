# GLOBAL SCOPE
root = exports ? this

Hive.UI =
	viewport: ->
		$('section#main')

	message_bar: ->
		$('header div.message_bar')

	user: ->
		$('header div.user')

	all: ->
		$('section#main, header div.message_bar, header div.user')
	
	# Fade out and clear the viewport, message bar, and user.
	clear: (callback) ->
		self = this
		console.log "Called clear"
		
		$(":animated").promise().done ->
			self.all().each ->
				$(this).fadeOut 500, ->
					$(this).html('').show()

		$(":animated").promise().done ->
			callback()


Hive.Templates =
	loginHandler: ->
		$("""
		<div id="login">
			<h1>Welcome to Worker Bee</h1>
			<p>Please login with your AgileZen API Key.</p>
			<div class="input">
				<form action="/" method="get">
					<input id="api_key" type="text"></input>
					<input type="submit" value="Login"></input>
					<div class="status"></div>
				</form>
			</div>
			<p class="hint">Test API Key: d67bb4e8a3124603a69f7587020cffc2</p>
		</div>
		""")

	userHandler: (data) ->
		$("""
			<span class="username">#{data.name}</span> | <a href="#">Logout</a>
		""")