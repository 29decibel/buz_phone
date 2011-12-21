require('lib/setup')
$ = jQuery
Spine   = require('spine')
{Stage} = require('spine.mobile')
Offer		= require('models/offer')
OfferController = require('controllers/offers_list')

class App extends Stage.Global
	constructor: ->
		super
		@offer_controller = new OfferController

		Spine.Route.setup(shim:true)
		@navigate '/offers_list'
		$('.stage>footer').append("<button class='login'>Login</button>")
	events:
		'tap .login' : 'login'

	onLocationChange:=>
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
			window.plugins.childBrowser.showWebPage("http://google.com")
			ChildBrowser.showWebPage("http://google.com")

module.exports = App
