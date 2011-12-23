Spine = require('spine')
$			= jQuery
config = require('lib/config')

class Checkin extends Spine.Model
	@configure 'Checkin','offer_id','confirmed'
	@extend Spine.Model.Ajax
	@url: ->
		"#{config.api_host}/mobi/checkins?device_id=#{config.device().id}"

module.exports = Checkin
