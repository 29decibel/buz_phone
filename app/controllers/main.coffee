Spine            = require('spine')
OfferShow = require('controllers/offer_show')
OffersMap = require('controllers/offers_map')
Orders = require('controllers/orders')
Rewards = require('controllers/rewards')
RewardShow = require('controllers/reward_show')
OffersList = require('controllers/offers_list')
Reward = require('models/reward')
# new added
MainRewards = require('controllers/main_rewards')
ShareRewards = require('controllers/share_rewards')
ShareRewards = require('controllers/share_rewards')
FriendsList = require('controllers/stores/friends_list')
ShareSuccess = require('controllers/stores/share_success')

class MainController extends Spine.Controller
  constructor: ->
    super
    @reward_show = new RewardShow
    @offers_list    = new OffersList
    @offer_show = new OfferShow
    @offers_map = new OffersMap
    @orders = new Orders
    @rewards = new Rewards
    # new one
    @share_rewards = new ShareRewards
    @main_rewards = new MainRewards
    @friends_list = new FriendsList
    @share_success = new ShareSuccess
    @routes
      '/offers_list'        : (params)->@offers_list.active(params)
      '/offers_map'         : (params)->@offers_map.active(params)
      '/show_offer/:id'     : (params)->@offer_show.active(params)
      '/show_reward/:id'    : (params)->@reward_show.active(params)
      '/orders'             : (params)->@main_rewards.active(params)
      '/rewards'            : (params)->@rewards.active(params)
      '/share_rewards'            : (params)->@share_rewards.active(params)
      '/friends_list'            : (params)->@friends_list.active(params)
      '/share_success'            : (params)->@share_success.active(params)

module.exports = MainController
