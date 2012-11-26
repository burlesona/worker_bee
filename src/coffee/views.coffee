# GLOBAL SCOPE
root = exports ? this

Hive.Views =
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
			<div id="user">
				<span class="username">#{data.name}</span> | <a href="#">Logout</a>
			</div>
		""")