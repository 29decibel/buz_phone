Spine = require('spine')
$			= jQuery

class Offer extends Spine.Model
	@configure 'Offer','name','main_picture'
	@extend Spine.Model.Ajax
	@url: "http://api.buz.dev/mobi/offers"

module.exports = Offer
