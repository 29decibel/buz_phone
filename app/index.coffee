require('lib/setup')
$ = jQuery
Spine   = require('spine')
{Stage} = require('spine.mobile')
Offer		= require('models/offer')
OfferController = require('controllers/offers_list')
config = require('lib/config')

class App extends Stage.Global
	constructor: ->
		super
		@offer_controller = new OfferController

		Spine.Route.setup(shim:true)
		@navigate '/offers_list'
		$('.stage>footer').append("<button class='login'>Login</button>")
		#@change_count = 0
	events:
		'tap .login' : 'login'
	onLocationChange:(loc)=>
		@log loc
	onClose:=>
		@log 'close'
	onOpenExternal:=>
		@log 'open external'
	onStartLoad:(loc)=>
		@log "start loading #{loc}"
		if loc=='fbconnect://success'
			window.plugins.childBrowser.close()
	login:=>
		cb = ChildBrowser.install()
		@log cb
		if cb?
			cb.onLocationChange = @onLocationChange
			cb.onClose =@onClose
			cb.onOpenExternal = @onOpenExternal
			cb.onStartLoad = @onStartLoad
			#cb.showWebPage("http://google.com")
			window.plugins.childBrowser.showWebPage("#{config.host}/auth/facebook?origin=iphone_app")
			#window.plugins.childBrowser.close()
			#ChildBrowser.showWebPage("http://google.com")

module.exports = App
