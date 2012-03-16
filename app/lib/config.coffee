BuzConfig =
  #host   :'http://buz.dev'
  #api_host:'http://api.buz.dev'
  host    :'http://buzing.com'
  api_host:'http://api.buzing.com'
  facebook_api_key: '257973420916663'
  position:{}
  device:->
    if window.device?
      {
        id:window.device.uuid,
        name:escape(window.device.name),
        platform:escape(window.device.platform)
      }
    else
      {
        id:"5555-3333-2222-1111",
        name:"mike_test",
        platform:"mike_mac"
      }

module.exports = BuzConfig
