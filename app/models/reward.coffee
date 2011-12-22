Spine = require('spine')
$			= jQuery
config = require('lib/config')

class Reward extends Spine.Model
	@extend Spine.Model.Ajax
	@url: "#{config.api_host}/mobi/rewards"


module.exports = Reward
