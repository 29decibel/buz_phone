Spine            = require('spine')
{Panel}          = require('spine.mobile')
Reward         = require('models/reward')
$     = jQuery
require('lib/jquery.simplevideo')
BuzUtil = require('lib/buz_util')
config = require('lib/config')

class FriendsList extends Panel
  className: 'friends_list'
  title:"<p class='small right'>SHOWCASE CINEMA DE LUX</p>"
  constructor:->
    super
    @active @change
    @addButton('Back',@back)
  events:
    'click li' : 'select'
    'click .share_btn' : 'share'
  select:(e)->
    e.preventDefault()
    $(e.target).closest('li').toggleClass('selected')
  share:(e)=>
    @navigate('/share_success',trans:'right')
  back:(e)=>
    @navigate('/orders',trans:'left')
  change:(paras)=>
    @render()
    self = this
    $.get "#{config.api_host}/mobi/users/fb_friends?uuid=#{config.device().id}",(rsp)->
      self.friends = rsp
      self.render()
  render_friends:(friends)=>
    @render()
    @friends = friends
    view = this
    for f in friends
      do (f)->
        view.append f.name
  render:=>
    if @isActive()
      $('.stage>footer .buttons .btn').removeClass('active')
      $('.stage>footer .buttons .orders').addClass('active')
    @html require('views/orders/friends_list')(friends:@friends)
    new iScroll('friends_list_wrapper')
    

module.exports = FriendsList
