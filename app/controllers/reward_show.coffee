Spine            = require('spine')
{Panel}          = require('spine.mobile')
Reward         = require('models/reward')
$     = jQuery
require('lib/jquery.simplevideo')
BuzUtil = require('lib/buz_util')

class RewardShow extends Panel
  className: 'reward_show'
  title: 'Rewards'
  constructor:->
    super
    @active @render
    @addButton('Back',@back)
  events:
    'click .share_btn' : 'share'
  share:(e)=>
    BuzUtil.alert 'Thanks for share!'
  back:(e)=>
    @navigate('/rewards',trans:'left')
  render:=>
    @html require('views/rewards/show')({name:'aaaa'})
    $('#test-video').simpleVideo()
    new iScroll('reward_show_wrapper')

module.exports = RewardShow
