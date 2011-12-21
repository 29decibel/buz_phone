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
		@change_count = 0
	events:
		'tap .login' : 'login'

	onLocationChange:=>
		@change_count++
		if @change_count==2
			window.plugins.childBrowser.close()
		alert 'localtion change'
	onClose:=>
		alert 'close'
	onOpenExternal:=>
		alert 'open external'
	login:=>
		cb = ChildBrowser.install()
		@log cb
		if cb?
			cb.onLocationChange = @onLocationChange
			cb.onClose =@onClose
			cb.onOpenExternal = @onOpenExternal
			#cb.showWebPage("http://google.com")
			window.plugins.childBrowser.showWebPage("#{config.host}/auth/facebook")
			#window.plugins.childBrowser.close()
			#ChildBrowser.showWebPage("http://google.com")

module.exports = App
