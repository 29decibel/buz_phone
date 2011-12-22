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
		window.order = Order
		if Order.count()==0
			Order.fetch({error:@render_login})
		else
			@html require('views/orders/list_item')(Order.all())
	render_login:=>
		@html 'You should login first'
module.exports = Orders
			
		
