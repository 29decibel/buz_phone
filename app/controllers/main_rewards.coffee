Spine            = require('spine')
{Panel}          = require('spine.mobile')
Reward         = require('models/reward')
$     = jQuery
require('lib/jquery.simplevideo')
BuzUtil = require('lib/buz_util')

class MainRewards extends Panel
  className: 'main_rewards'
  title:"<p class='small right'>SHOWCASE CINEMA DE LUX</p>"
  constructor:->
    super
    @active @change
    @addButton('Back',@back)
  events:
    'click li' : 'share'
  share:(e)=>
    @navigate('/share_rewards',trans:'right')
  back:(e)=>
    @navigate('/rewards',trans:'left')
  change:(paras)=>
    @render()
  render:=>
    if @isActive()
      $('.stage>footer .buttons .btn').removeClass('active')
      $('.stage>footer .buttons .orders').addClass('active')
    @html require('views/orders/main_rewards')()

module.exports = MainRewards
