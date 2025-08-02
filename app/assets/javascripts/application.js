//= require jquery
//= require jquery_ujs
//= require activestorage
//= require turbolinks
//= require semantic-ui
//= require action_cable
//= require_self
//= require_tree .

(function () {
  this.App || (this.App = {});
  App.cable = ActionCable.createConsumer();
}).call(this);

// 🟣 Handle Enter key for both chat forms
function submit_message() {
  const input = $('#message_body');
  if (!input.length) return;

  input.on('keydown', function (e) {
    if (e.keyCode === 13 && !e.shiftKey) {
      e.preventDefault();
      const form = input.closest('form');
      if (form.length) {
        form.submit();
        input.val(''); // Clear only sender's field
      }
    }
  });
   const sendButton = $('#send-message-button');
  sendButton.on('click', function (e) {
    e.preventDefault();
    const form = input.closest('form');
    if (form.length) {
      form.submit();
      input.val('');
    }
  });
}

// 🔽 Scroll to latest messages
function scroll_bottom() {
  const privateBox = $('#conversation-messages')[0];
  if (privateBox) privateBox.scrollTop = privateBox.scrollHeight;

  const generalBox = $('#message-container')[0];
  if (generalBox) generalBox.scrollTop = generalBox.scrollHeight;
}

// 🧠 ActionCable private chat
$(document).on('turbolinks:load', function () {
  const conversationId = $('#conversation-messages').data('conversation-id');

  if (conversationId) {
    if (App.conversation) {
      App.conversation.unsubscribe();
      delete App.conversation;
    }

    App.conversation = App.cable.subscriptions.create(
      {
        channel: 'ConversationChannel',
        conversation_id: conversationId,
      },
      {
        connected() {
          console.log(`✅ Connected to conversation ${conversationId}`);
        },
        disconnected() {
          console.log('❌ Disconnected from conversation');
        },
        received(data) {
          console.log('📥 Received:', data);
          $('#conversation-messages').append(data.mod);
          
          // Only clear if current user is sender
          if (data.sender_id == window.currentUserId) {
            $('#private-message-form textarea').val('');
          }

          scroll_bottom();
        },
      }
    );
  }

  // UI behavior
  $('.ui.dropdown').dropdown();
  $('.message .close').on('click', function () {
    $(this).closest('.message').transition('fade');
  });

  $('#private-message-form')
    .on('ajax:success', () => console.log('✅ Private message sent'))
    .on('ajax:error', (e) =>
      console.error('❌ Error sending private message:', e.detail)
    );

  $('#chat_form')
    .on('ajax:success', () => console.log('✅ Public message sent'))
    .on('ajax:error', (e) =>
      console.error('❌ Error sending public message:', e.detail)
    );

  submit_message();
  scroll_bottom();
});

// 🧼 Unsubscribe on page change
$(document).on('turbolinks:before-visit', function () {
  if (App.conversation) {
    App.conversation.unsubscribe();
    delete App.conversation;
  }
});
