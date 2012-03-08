BuzUtil =
  alert:(message,cb)->
    if navigator and navigator.notification
      console.log 'show message from buz util'
      console.log navigator.notification.alert
      navigator.notification.alert(
        message,  #message
        cb,#callback
        'Buzing',# buz title
        'OK' # button
        )
      
    else
      alert message

module.exports = BuzUtil
