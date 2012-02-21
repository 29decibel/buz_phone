Spine = require('spine')
$     = jQuery
config = require('lib/config')

class Order extends Spine.Model
  @configure 'Order','offer','price'
  @extend Spine.Model.Ajax
  @url: ->
    "#{config.api_host}/mobi/orders?device_id=#{config.device().id}"
  full_url:(url)->
    "#{config.host}#{url}"

module.exports = Order
