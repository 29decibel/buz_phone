$     = jQuery

load_facebook_sdk = (success_callback)->
  id = 'facebook-jssdk'
  if document.getElementById(id)
    console.log 'facebook-jssdk script exist..'
    success_callback()
  else
    js = document.createElement('script')
    js.id = id
    js.src = "http://connect.facebook.net/en_US/all.js"
    # reasign the callback func
    window.fbAsyncInit = success_callback
    document.getElementsByTagName('head')[0].appendChild(js)
    console.log 'attach the facebook sdk js to head'

init_fb_sdk = (app_id)->
  console.log 'begin init fb client'
  FB.init {
    appId      : app_id, #"167583056680567" # App ID
    #channelUrl : '//WWW.YOUR_DOMAIN.COM/channel.html', // Channel File
    status     : true, # check login status
    cookie     : true, # enable cookies to allow the server to access the session
    xfbml      : true  # parse XFBML
  }
  console.log 'fb init complete'

get_fb_friends = (callback)->
  console.log 'begin get facebook status...'
  FB.api '/me/friends',(rsp)->
    console.log 'test getting friends.'
    console.log rsp
  FB.getLoginStatus (rsp)->
    console.log 'get login status...'
    console.log rsp
    console.log rsp.status
    if(rsp.status=='connected')
      FB.api '/me/friends',(rsp)->
        console.log 'begin get current user facebook info'
        callback(rsp)
    else if rsp.status == 'not_authorized'
      console.log 'not auth'
    else
      console.log 'can not get facebook login status'
      callback(rsp)

Facebook =
  friends_list:(app_id,callback)->
    # create fb sdk dom holder
    if($('#fb-root').size()==0)
      console.log 'not found fb-root, begin create one and append'
      ele = document.createElement('div')
      ele.setAttribute('id','fb-root')
      ele.setAttribute('style',"display:none;")
      $('body').append(ele)
    console.log "begin load facebook sdk"
    # make facebook skd available
    load_facebook_sdk ->
      console.log "successful load facebook sdk"
      init_fb_sdk(app_id)
      get_fb_friends(callback)
module.exports = Facebook
