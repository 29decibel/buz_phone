Spine            = require('spine')
{Panel}          = require('spine.mobile')
Offer         = require('models/offer')

class OfferList extends Panel
	className:'offer_list'
	title:'nice'

	constructor:->
		super
		console.log 'init offer list pannel````````'
		Offer.bind('refresh change', @render)

	render:=>
		items = Offer.all()
		console.log '!!!! begin render pannel data...'
		console.log items
		@html require('views/offers/list_item')(items)


class OfferController extends Spine.Controller
	constructor: ->
		console.log 'init controller........'
		super
		@list    = new OfferList
		@routes
			'/offers':
				(params)->@list.active(params)
		Offer.fetch()

module.exports = OfferController
