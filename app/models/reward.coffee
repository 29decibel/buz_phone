Spine = require('spine')
$     = jQuery
config = require('lib/config')

class Reward extends Spine.Model
  @configure 'Reward'
  @extend Spine.Model.Ajax
  @url:->
    "#{config.api_host}/mobi/rewards?device_id=#{config.device().id}"
  full_url:(url)->
    "#{config.host}#{url}"
  state:->
    if @redeemed
      'REDEEMED'
    else
      'NOT REDEEMED'



module.exports = Reward
