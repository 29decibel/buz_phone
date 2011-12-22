Spine            = require('spine')
{Panel}          = require('spine.mobile')
Reward         = require('models/reward')
config = require('lib/config')
$			= jQuery

class Rewards extends Panel
	className:'rewards'
	title:'Rewards'
	events:
		'tap .buz_login' : 'login'
	constructor:->
		super
		Reward.bind('refresh change',@render)
		@addButton('Refresh',@refresh)
		@active @render
	render:=>
		if @isActive()
			$('.stage>footer .buttons .btn').removeClass('active')
			$('.stage>footer .buttons .rewards').addClass('active')
		@log 'render orders list'
		if Reward.count()==0
			@html "<div class='empty_info'>You have no rewards</div>"
			if !@loaded?
				@refresh()
		else
			@html "<div id='rewards-wrapper' class='scroll-wrapper'><div class='scroller'></div></div>"
			@$("#rewards-wrapper .scroller").html require('views/rewards/list_item')(Reward.all())
			new iScroll('rewards-wrapper')
	refresh:=>
		@loaded = true
		@html "<div class='loading'>Loading Rewards....</div>"
		Reward.fetch({error:@render_login})

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
		login_url = "#{config.host}/auth/facebook?origin=mobile_app_#{device_info.id},#{device_info.name},#{device_info.platform}"
		console.log "begin show login page..."
		window.plugins.childBrowser.showWebPage(login_url)

	render_login:=>
		@html "<div class='login_info'><button class='buz_login'>Login Facebook</button></div>"


module.exports = Rewards
