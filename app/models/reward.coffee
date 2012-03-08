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
  view_it:->
    $.ajax "#{config.api_host}/mobi/rewards/#{@id}/view_it?device_id=#{config.device().id}",{type:'post'}
  state:->
    if @redeemed
      'REDEEMED'
    else
      'NOT REDEEMED'



module.exports = Reward
