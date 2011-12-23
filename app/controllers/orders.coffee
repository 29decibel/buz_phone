Spine            = require('spine')
{Panel}          = require('spine.mobile')
Order         = require('models/order')
config = require('lib/config')
$			= jQuery

class Orders extends Panel
	className:'orders'
	title:'Purchases'
	events:
		'tap .buz_login' : 'login'
	constructor:->
		super
		Order.bind('refresh change',@render)
		@addButton('Refresh',@refresh)
		@active @render
	render:=>
		if @isActive()
			$('.stage>footer .buttons .btn').removeClass('active')
			$('.stage>footer .buttons .orders').addClass('active')
		@log 'render orders list'
		if Order.count()==0
			@html "<div class='empty_info'>You have no purchases.</div>"
			if !@loaded?
				@refresh()
		else
			@html "<div id='orders-wrapper' class='scroll-wrapper'><div class='scroller'></div></div>"
			@$("#orders-wrapper .scroller").html require('views/orders/list_item')(Order.all())
			new iScroll('orders-wrapper')
	refresh:=>
		@loaded = true
		@html "<div class='loading'>Loading Purchases....</div>"
		Order.fetch({error:@render_login})

	onLocationChange:(loc)=>
		@log loc
	onClose:=>
		@log 'close'
		if @logged_in
			@refresh()
	onOpenExternal:=>
		@log 'open external'
	onStartLoad:(loc)=>
		@log "start loading #{loc}"
		if loc=='fbconnect://success'
			window.plugins.childBrowser.close()
			@logged_in = true
	login:=>
		@log "got login events"
		console.log "test log ..."
		if !@cb?
			@cb = ChildBrowser.install()
		@cb.onLocationChange = @onLocationChange
		@cb.onClose =@onClose
		@cb.onOpenExternal = @onOpenExternal
		@cb.onStartLoad = @onStartLoad
		device_info = config.device()
		login_url = "#{config.host}/auth/facebook?origin=mobile_app_#{device_info.id},#{device_info.name},#{device_info.platform}&display=touch"
		console.log "begin show login page..."
		window.plugins.childBrowser.showWebPage(login_url)

	render_login:=>
		@html "<div class='login_info'><button class='buz_login'>Login Facebook</button></div>"



module.exports = Orders
