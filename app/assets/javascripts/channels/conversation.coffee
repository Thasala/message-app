$(document).on 'turbolinks:load', ->
  conversationId = $('#conversation-messages').data('conversation-id')
  return unless conversationId?

  if App.conversation?
    App.conversation.unsubscribe()
    delete App.conversation

  App.conversation = App.cable.subscriptions.create {
    channel: "ConversationChannel"
    conversation_id: conversationId
  },
    connected: ->
      console.log "✅ Connected to conversation #{conversationId}"

    disconnected: ->
      console.log "❌ Disconnected from conversation"

    received: (data) ->
      console.log "📥 Received:", data
      $('#conversation-messages').append(data.mod)
      $('#private-message-form textarea').val('')
      $('#conversation-messages').scrollTop($('#conversation-messages')[0].scrollHeight)

$(document).on 'turbolinks:before-visit', ->
  if App.conversation?
    App.conversation.unsubscribe()
    delete App.conversation
