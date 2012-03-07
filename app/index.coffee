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
    $('.stage>footer').append("<div class='buttons'></div>")
    $('.stage>footer .buttons').append("<button class='offers btn'>Offers</button>")
    $('.stage>footer .buttons').append("<button class='orders btn'>Purchases</button>")
    $('.stage>footer .buttons').append("<button class='rewards btn'>Rewards</button>")
    #@change_count = 0
  events:
    'tap button.orders' : 'orders'
    'tap button.rewards' : 'rewards'
    'tap button.offers' : 'offers'

  orders:->
    @navigate('/orders')
  rewards:->
    @navigate('/rewards')
  offers:->
    @navigate('/offers_list')

module.exports = App
