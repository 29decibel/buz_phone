Spine            = require('spine')
config = require('lib/config')

BuzLogin =
	onLocationChange:(loc)->
		@log loc
	onClose:->
		@log 'close'
		if @logged_in
			@render()
	onOpenExternal:->
		@log 'open external'
	onStartLoad:(loc)->
		@log "start loading #{loc}"
		if loc=='fbconnect://success'
			window.plugins.childBrowser.close()
			@logged_in = true
	login:->
		@log "got login events"
		console.log "test log ..."
		if !@cb?
			@cb = ChildBrowser.install()
		@cb.onLocationChange = @onLocationChange
		@cb.onClose =@onClose
		@cb.onOpenExternal = @onOpenExternal
		@cb.onStartLoad = @onStartLoad
		device_info = config.device()
		login_url = "#{config.host}/auth/facebook?origin=mobile_app_#{device_info.id},#{device_info.name},#{device_info.platform}"
		console.log "begin show login page..."
		window.plugins.childBrowser.showWebPage(login_url)

module.exports = BuzLogin
