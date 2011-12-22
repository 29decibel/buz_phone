Spine            = require('spine')
{Panel}          = require('spine.mobile')
Order         = require('models/order')
$			= jQuery

class Orders extends Panel
	className:'orders'
	title:'Purchases'
	constructor:->
		super
		@html "<div class='loading'>Loading Your Purchases Infos....</div>"
		Order.bind('refresh change',@render)
		@active @render
	render:=>
		@log 'render orders list'
		if Order.count()==0
			Order.fetch({error:@render_login})
		else
			@html "<div id='orders-wrapper' class='scroll-wrapper'><div class='scroller'></div></div>"
			@$("#orders-wrapper .scroller").html require('views/orders/list_item')(Order.all())
			new iScroll('orders-wrapper')
	render_login:=>
		@html 'You should login first'


module.exports = Orders
			
		
