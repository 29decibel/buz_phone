BuzUtil =
  alert:(message)->
    if navigator and navigator.notification
      navigator.notification.alert(
        message,  #message
        null,#callback
        'Buzing',# buz title
        'OK' # button
        )
      
    else
      alert message
  confirm:(message,cb)->
    if navigator and navigator.notification
      console.log 'come to confirm call'
      adapt_callback = (e)->
        cb(e==1)
      navigator.notification.confirm(
        message,  #message
        adapt_callback,#callback
        'Buzing',# buz title
        'OK,Cancel', # button
      )
    else
      cb(confirm(message))


module.exports = BuzUtil
