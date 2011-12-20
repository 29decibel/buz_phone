Spine            = require('spine')
{Panel}          = require('spine.mobile')
Offer         = require('models/offer')

class OfferShow extends Panel
	className:'offer_show'
	constructor:->
		super
		Offer.bind 'change',@render
		@active @change
		@addButton 'Back',@back
	events:
		'tap img.thumb' : 'change_main_pic'

	change_main_pic:(e)=>
		url = $(e.target).attr('data-full')
		@$('img.main').attr('src',url)

	change:(paras)->
		@offer = Offer.find(paras.id)
		@render()

	back:->
		@navigate('/offers',trans:'left')

	render:=>
		@html require('views/offers/show')(@offer)
		new iScroll('offer_show_wrapper')

module.exports = OfferShow
