Spine = require('spine')
$			= jQuery
config = require('lib/config')

class Offer extends Spine.Model
	@configure 'Offer','name','landing_picture'
	@extend Spine.Model.Ajax
	@url: "#{config.api_host}/mobi/offers"

	full_url:(url)->
		"#{config.host}#{url}"
	distance:(pos)->
		console.log 'begin calculating dis'
		console.log pos
		console.log @store
		(distance(@store.latitude,pos.latitude,@store.longitude-pos.longitude)/1000).toFixed(2)

module.exports = Offer
