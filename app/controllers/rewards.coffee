Spine            = require('spine')
{Panel}          = require('spine.mobile')
Reward         = require('models/reward')
$			= jQuery

class Rewards extends Panel
	className:'rewards'
	title:'Rewards'
	constructor:->
		super
		@html "<div class='loading'>Loading Your Rewards ....</div>"
		Reward.bind('refresh change',@render)
		@active @render
	render:=>
		@log 'render orders list'
		if Reward.count()==0
			Reward.fetch({error:@render_login})
		else
			@html require('views/rewards/list_item')(Reward.all())
	render_login:=>
		@html 'You should login first'


module.exports = Rewards
