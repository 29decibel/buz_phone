require('lib/setup')
$ = jQuery
Spine   = require('spine')
{Stage} = require('spine.mobile')
MainController = require('controllers/main')
config = require('lib/config')

class App extends Stage.Global
	constructor: ->
		super
		@main_controller = new MainController

		Spine.Route.setup(shim:true)
		@navigate '/offers_list'
		$('.stage>footer').append("<button class='offers'>Offers</button>")
		$('.stage>footer').append("<button class='orders'>Purchases</button>")
		$('.stage>footer').append("<button class='rewards'>Rewards</button>")
		#@change_count = 0
	events:
		'tap .orders' : 'orders'
		'tap .rewards' : 'rewards'
		'tap .offers' : 'offers'

	orders:->
		@navigate('/orders')
	rewards:->
		@navigate('/rewards')
	offers:->
		@navigate('/offers_list')

module.exports = App
