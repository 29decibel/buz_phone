Spine            = require('spine')
{Panel}          = require('spine.mobile')
Reward         = require('models/reward')

class RewardShow extends Panel
  className: 'reward_show'
  constructor:->
    super
    @active @render
    @addButton('Back',@back)
  back:(e)=>
    @navigate('/rewards',trans:'left')
  render:=>
    @html require('views/rewards/show')({name:'aaaa'})

module.exports = RewardShow
