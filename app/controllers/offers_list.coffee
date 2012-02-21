Spine            = require('spine')
{Panel}          = require('spine.mobile')
Offer         = require('models/offer')
config = require('lib/config')
$     = jQuery

class OffersList extends Panel
  className:'offer_list'
  title:'Offers'

  constructor:->
    super
    Offer.bind('refresh change', @render)
    @active @render
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
    if @isActive()
      $('.stage>footer .buttons .btn').removeClass('active')
      $('.stage>footer .buttons .offers').addClass('active')
    return if @redered==true
    if Offer.count()==0
      @html "<div class='loading'>Loading Offers....</div>"
      Offer.fetch()
    else
      # get items
      items = Offer.select (item)->
        item.landing_picture?
      # append wrapper
      @html "<div id='offers-wrapper' class='scroll-wrapper'><div class='scroller'></div></div>"
      @$('#offers-wrapper .scroller').html require('views/offers/list_item')(items)
      new_scroll = -> new iScroll('offers-wrapper')
      #window.addEventListener('load', setTimeout(new_scroll, 200), false)
      new_scroll()
      # get location and add location infos
      if PhoneGap.available
        @fetch_location_infos()
      else
        document.addEventListener "deviceready",@fetch_location_infos,false
      @redered = true

  fetch_location_infos:=>
    navigator.geolocation.getCurrentPosition(@add_distance_info, @fetch_location_error)
  fetch_location_error:=>
    console.log 'can not get the location'
  refresh:=>
    @html "<div class='loading'>Loading Offers....</div>"
    @redered = false
    Offer.fetch()

  add_distance_info:(position)=>
    config.position = position.coords
    Offer.each (offer)->
      dis = offer.distance(position.coords)
      console.log "distance is #{dis}"
      $(".item[data-id=offer_item_#{offer.id}] .distance").html("#{dis} km")

module.exports = OffersList
