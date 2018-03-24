$(document).on 'turbolinks:load', ->
  if App.streaming
    App.cable.subscriptions.remove App.streaming
  App.streaming = App.cable.subscriptions.create { channel: "StreamingChannel", slug: $(location).attr('pathname').split('/').pop()},
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      $('.live-streaming-box').prepend data.message
      $('#notification-modal').modal('show')
      setTimeout(window.change_src, 5000)
