Spine            = require('spine')
{Panel}          = require('spine.mobile')
Reward         = require('models/reward')
$     = jQuery
require('lib/jquery.simplevideo')
BuzUtil = require('lib/buz_util')

class ShareRewards extends Panel
  className: 'share_rewards'
  title: 'Rewards'
  constructor:->
    super
    @active @change
    @addButton('Back',@back)
  events:
    'click .share_btn' : 'share'
  share:(e)=>
    BuzUtil.alert 'Thanks for share!'
  back:(e)=>
    @navigate('/rewards',trans:'left')
  change:(paras)=>
    @render()
  render:=>
    if @isActive()
      $('.stage>footer .buttons .btn').removeClass('active')
      $('.stage>footer .buttons .rewards').addClass('active')
    @html require('views/rewards/share_rewards')()

module.exports = ShareRewards
