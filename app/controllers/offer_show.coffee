Spine            = require('spine')
{Panel}          = require('spine.mobile')
Offer         = require('models/offer')
Checkin       = require('models/checkin')
BuzUtil = require('lib/buz_util')

class OfferShow extends Panel
  className:'offer_show'
  constructor:->
    super
    Offer.bind 'change',@render
    @active @change
    @addButton 'Back',@back
  events:
    'tap img.thumb' : 'change_main_pic'
    'click .checkin' : 'checkin'

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
  toggle_checkin_btn:=>
    @$('.checkin').toggleClass('ing')
    if @$('.checkin').hasClass('ing')
      @$('.checkin').html 'Checking in ...'
    else
      @$('.checkin').html 'Checkin Here!'
  checkin:->
    if @$('.checkin').hasClass('ing')
      return
    #share = confirm('Do you also want to share it on Facebook?')
    checkin = new Checkin({offer_id:@offer.id,confirmed:share})
    toggle_func = @toggle_checkin_btn
    toggle_func()
    checkin.bind 'ajaxSuccess',->
      BuzUtil.alert 'Checkin Success!'
      toggle_func()
    checkin.bind 'ajaxError',(ck,resp)->
      console.log ck
      console.log resp
      if resp.status==405
        BuzUtil.alert "Checkin Failed,#{resp.responseText}"
      else if resp.status==401
        BuzUtil.alert 'You have to login facebook before checkin!'
      else
        BuzUtil.alert 'Checkin Failed..'
      toggle_func()
    checkin.save()

  back:->
    @navigate('/offers_list',trans:'left')

  render:=>
    if @isActive()
      $('.stage>footer .buttons .btn').removeClass('active')
      $('.stage>footer .buttons .offers').addClass('active')
    @html require('views/offers/show')(@offer)
    new iScroll('offer_show_wrapper')

module.exports = OfferShow
