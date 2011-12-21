Spine            = require('spine')
{Panel}          = require('spine.mobile')
Offer         = require('models/offer')
OfferShow = require('controllers/offer_show')
OffersMap = require('controllers/offers_map')
$			= jQuery

class OffersList extends Panel
	className:'offer_list'
	title:'Offers List'

	constructor:->
		super
		@html "<div class='loading'>Loading Offers....</div>"
		Offer.bind('refresh change', @render)
		@addButton('Refresh',@refresh)
		@addButton('Map View',@map_view).addClass('right')
	events:
		'tap .item' : 'show_offer'

	show_offer:(e)->
		offer = $(e.target).closest('.item').item()
		console.log offer
		@navigate('/show_offer',offer.id,trans:'right')
	map_view:=>
		@navigate('/offers_map')
	render:=>
		# get items
		items = Offer.select (item)->
			item.landing_picture?
		# append wrapper
		@html "<div id='offers-wrapper' class='scroll-wrapper'><div class='scroller'></div></div>"
		@$('#offers-wrapper .scroller').html require('views/offers/list_item')(items)
		new_scroll = -> new iScroll('offers-wrapper')
		window.addEventListener('load', setTimeout(new_scroll, 200), false)


	refresh:=>
		@html "<div class='loading'>Loading Offers....</div>"
		Offer.fetch()

class OfferController extends Spine.Controller
	constructor: ->
		super
		@offers_list    = new OffersList
		@offer_show = new OfferShow
		@offers_map = new OffersMap
		@routes
			'/offers_list': (params)->@offers_list.active(params)
			'/offers_map': (params)->@offers_map.active(params)
			'/show_offer/:id' : (params)->@offer_show.active(params)
		Offer.fetch()

module.exports = OfferController
