Spine            = require('spine')
{Panel}          = require('spine.mobile')
Offer         = require('models/offer')
OfferShow = require('controllers/offer_show')
$			= jQuery

class OfferList extends Panel
	className:'offer_list'
	title:'Buz Offers'

	constructor:->
		super
		@html "<div class='loading'>Loading Offers....</div>"
		Offer.bind('refresh change', @render)
		@addButton('Refresh',@refresh)
	events:
		'tap .item' : 'show_offer'

	show_offer:(e)->
		offer = $(e.target).closest('.item').item()
		console.log offer
		@navigate('/show_offer',offer.id,trans:'right')

	render:=>
		# get items
		items = Offer.select (item)->
			item.landing_picture?
		# append wrapper
		@html ''
		@append "<div id='offers-wrapper' class='scroll-wrapper'><div class='scroller'></div></div>"
		@$('#offers-wrapper .scroller').html require('views/offers/list_item')(items)
		new_scroll = -> new iScroll('offers-wrapper')
		setTimeout new_scroll,100

	refresh:=>
		@html "<div class='loading'>Loading Offers....</div>"
		Offer.fetch()

class OfferController extends Spine.Controller
	constructor: ->
		super
		@list    = new OfferList
		@offer_show = new OfferShow
		@routes
			'/offers': (params)->@list.active(params)
			'/show_offer/:id' : (params)->@offer_show.active(params)
		Offer.fetch()

module.exports = OfferController
