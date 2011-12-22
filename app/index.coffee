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
		$('.stage>footer').append("<button class='orders'>Purchases</button>")
		#@change_count = 0
	events:
		'tap .login' : 'login'
		'tap .orders' : 'orders'
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
	orders:->
		@navigate('/orders')
	login:=>
		cb = ChildBrowser.install()
		@log cb
		if cb?
			cb.onLocationChange = @onLocationChange
			cb.onClose =@onClose
			cb.onOpenExternal = @onOpenExternal
			cb.onStartLoad = @onStartLoad
			device_info = config.device()
			login_url = "#{config.host}/auth/facebook?origin=mobile_app_#{device_info.id},#{device_info.name},#{device_info.platform}"
			window.plugins.childBrowser.showWebPage(login_url)

module.exports = App
