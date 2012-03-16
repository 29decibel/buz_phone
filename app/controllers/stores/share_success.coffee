Spine            = require('spine')
{Panel}          = require('spine.mobile')
Reward         = require('models/reward')
$     = jQuery
require('lib/jquery.simplevideo')
BuzUtil = require('lib/buz_util')
config = require('lib/config')

class ShareSuccess extends Panel
  className: 'share_success'
  title:"<p class='small right'>SHOWCASE CINEMA DE LUX</p>"
  constructor:->
    super
    @active @change
    @addButton('Back',@back)
  back:(e)=>
    @navigate('/orders',trans:'left')
  change:(paras)=>
    @render()
  render:=>
    if @isActive()
      $('.stage>footer .buttons .btn').removeClass('active')
      $('.stage>footer .buttons .orders').addClass('active')
    @html require('views/orders/share_success')()

module.exports = ShareSuccess
