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
		# new image
		image = new Image()
		main_image = @$('img.main')
		img_loading = @$('.image_loading')
		image.onload = ->
			main_image.attr('src',url)
			img_loading.hide()
		image.src = url
		# only show the loading sign when the image not load
		if !image.complete
			img_loading.show()

	change:(paras)->
		@offer = Offer.find(paras.id)
		@render()

	back:->
		@navigate('/offers_list',trans:'left')

	render:=>
		@html require('views/offers/show')(@offer)
		new iScroll('offer_show_wrapper')

module.exports = OfferShow
