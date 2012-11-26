# GLOBAL SCOPE
root = exports ? this

jQuery ->
	Hive.start()

root.Hive =
	start: ->
		if localStorage['api_key']?
			this.loadApp()
		else
			this.handleLogin()

	loadApp: ->
		Hive.UI.clear()
		console.log "LOAD APP TIME"

	handleLogin: ->
		handler = new Hive.LoginHandler
		handler.render()