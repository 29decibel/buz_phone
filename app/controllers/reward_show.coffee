Spine            = require('spine')
{Panel}          = require('spine.mobile')
Reward         = require('models/reward')
$     = jQuery
require('lib/jquery.simplevideo')
BuzUtil = require('lib/buz_util')

class RewardShow extends Panel
  className: 'reward_show'
  title:"<p class='small right'>SHOWCASE CINEMA DE LUX</p>"
  constructor:->
    super
    @active @change
    @addButton('Back',@back)
  events:
    'click .share_btn' : 'share'
  share:(e)=>
    #BuzUtil.alert 'Thanks for share!'
    @navigate('/share_rewards',trans:'right')
  back:(e)=>
    @navigate('/rewards',trans:'left')
  change:(paras)=>
    @reward = Reward.find(paras.id)
    @render()
  render:=>
    if @isActive()
      $('.stage>footer .buttons .btn').removeClass('active')
      $('.stage>footer .buttons .rewards').addClass('active')
    if @reward? and !@reward.viewed
      @reward.view_it()
    @html require('views/rewards/show2')({reward:@reward})
    $('#test-video').simpleVideo()
    new iScroll('reward_show_wrapper')

module.exports = RewardShow
