require('lib/setup')
$ = jQuery
Spine   = require('spine')
{Stage} = require('spine.mobile')
MainController = require('controllers/main')
Reward         = require('models/reward')
config = require('lib/config')
BuzUtil = require('lib/buz_util')

class App extends Stage.Global
  constructor: ->
    super
    @main_controller = new MainController

    Spine.Route.setup(shim:true)
    @navigate '/offers_list'
    $('.stage>footer').append("<div class='buttons'></div>")
    $('.stage>footer .buttons').append("<button class='offers btn'>Offers</button>")
    $('.stage>footer .buttons').append("<button class='orders btn'>Stores</button>")
    $('.stage>footer .buttons').append("<button class='rewards btn'>Rewards</button>")
    #@change_count = 0
    # check the newly rewards 
    if PhoneGap.available
      @run_when_device_ready()
    else
      document.addEventListener "deviceready",@run_when_device_ready,false

  run_when_device_ready:=>
    console.log 'device ready`````````````````'
    @check_rewards()
    document.addEventListener("resume", @app_resume, false)

  app_resume:(e)=>
    #BuzUtil.alert 'resume'
    console.log 'app resume------'

  receive_notification:(notification)->
    console.log notification
    BuzUtil.alert 'I guess you just received notification'
    @navigate('/orders')
  # fire reward fetch
  # bind success to navigator
  check_rewards:=>
    self = this
    Reward.bind('refresh',->
      new_r = Reward.select (r)->
        !r.viewed
      if new_r.length > 0
        BuzUtil.confirm "Got #{new_r.length} new rewards! Check them?",(e)->
          if e
            console.log "confirm result #{e}"
            self.navigate('/show_reward',new_r[0].id,trans:'right')
    )
    Reward.fetch()
    # Reward.fetch({success:(rsp)->
    #   # check if there is
    #   new_r = _.select rsp,(r)->
    #     !r.viewed
    #   if new_r.length>0 and confirm("Got #{new_r.length} new rewards! Check them?")
    #     self.navigate('/show_reward',new_r[0].id,trans:'right')
    # })
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
