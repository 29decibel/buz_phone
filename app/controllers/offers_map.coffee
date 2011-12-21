Spine            = require('spine')
{Panel}          = require('spine.mobile')
Offer         = require('models/offer')
OfferShow = require('controllers/offer_show')
$			= jQuery

class OffersMap extends Panel
	className:'offer_map'
	title:'Offers'

	constructor:->
		super
		@html "<div class='loading'>Loading Offers....</div>"
		Offer.bind('refresh change', @render)
		@active @refresh
		@addButton('Refresh',@refresh)
		@addButton('List View',@list_view).addClass('right')

	list_view:=>
		@navigate('/offers_list')
	render:=>
		@html 'here is the map view'
		map_view = this
		onSuccess=(position)->
			map_view.position = position
			map_view.refresh(position)
		onError = (msg)->
			console.log 'can not get the location'
		navigator.geolocation.getCurrentPosition(onSuccess, onError)
	add_point:=>
		console.log 'nice'

	refresh:=>
		@log 'see current map view is active'
		@log @isActive()
		@log @isActive
		if @position and @isActive()
			@html ''
			@append "<div id='offers_map'></div>"
			console.log '--------------- position is rendering...........'
			map_center = new google.maps.LatLng(Offer.first().store.latitude,Offer.first().store.longitude)
			# map_center = new google.maps.LatLng(@position.coords.latitude,@position.coords.longitude)
			myOptions = {zoom: 15,center: map_center,mapTypeId: google.maps.MapTypeId.ROADMAP}
			@map = new google.maps.Map(document.getElementById("offers_map"), myOptions)
			console.log @map
			# add pins 
			map_view = this
			Offer.each (offer)->
				map_view.add_pin(offer)

	add_pin:(offer)->
		myLatlng = new google.maps.LatLng(offer.store.latitude,offer.store.longitude)
		#infowindow = new google.maps.InfoWindow({maxWidth:50,pixelOffset:{width:4,height:3},content: this})
		icon = 'http://www.google.com/intl/en_us/mapfiles/ms/micons/green-dot.png'
		marker = new google.maps.Marker({icon:icon,animation:google.maps.Animation.DROP,position: myLatlng,map: @map,title:offer.name})



module.exports = OffersMap
