Spine = require('spine')
$			= jQuery
config = require('lib/config')

class Offer extends Spine.Model
	@configure 'Offer','name','landing_picture'
	@extend Spine.Model.Ajax
	@url: "#{config.api_host}/mobi/offers"

	full_url:(url)->
		"#{config.host}#{url}"

module.exports = Offer
