# GLOBAL SCOPE
root = exports ? this

Hive.Views =
	statusMessage: (message) ->
		$("""
			<div class="message">#{message}</div>
		""")

	loginHandler: ->
		$("""
		<div class="login_handler">
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
			<div class="user_handler">
				<span class="username">#{data.name}</span> | <a href="#">Logout</a>
			</div>
		""")

	projectSelector: (data) ->
		$("""
			<div class="project_selector">
			</div>
		""")

	projectSelectorItem: (data) ->
		$("""
			<div class="project">
				<h1>#{data.name} <small>#{data.id}</small></h1>
				<p class="description">
					#{data.description}
				</p>
				<a class="button">Select</a>
			</div>
		""")

	projectSwitcher: (data) ->
		$("""
			<div class="project_switcher">
				<span class="name">Stories and Tasks for #{data.name}</span> |
				<a href="#">Switch Project</a>
			</div>
		""")

	projectHandler: (data) ->
		$("""
			<div class="project_handler">
			</div>
		""")

	storyHandler: (data) ->
		$("""
			<div class="story_handler">
				<div class="status #{data.status.toLowerCase()}">#{data.status}</div>
				<p class="text">#{data.text}</p>
				<div class="tasks">
				</div>
			</div>
		""")

	taskHandler: (data) ->
		$("""
			<div class="task_handler">
				<input type="checkbox">
				<span>#{data.text}</span>
			</div>
		""")