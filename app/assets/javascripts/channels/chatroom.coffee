App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    console.log "✅ Connected to chatroom"

  disconnected: ->
    console.log "❌ Disconnected from chatroom"

  received: (data) ->
    console.log "📥 Received:", data
    $('#message-container').append data.mod_message
    scroll_bottom()
