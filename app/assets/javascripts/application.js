//= require jquery
//= require jquery_ujs
//= require activestorage
//= require turbolinks
//= require semantic-ui
//= require action_cable
//= require_self
//= require_tree .

(function() {
  this.App || (this.App = {});
  App.cable = ActionCable.createConsumer();
}).call(this);

// 🟣 Handle enter key for public or private chat forms
function submit_message() {
  const input = $('#message_body');
  if (input.length) {
    input.on('keydown', function(e) {
      if (e.keyCode === 13 && !e.shiftKey) {
        e.preventDefault();

        const form = input.closest('form');
        if (form.length) {
          form.submit();
          input.val('');
        }
      }
    });
  }
}

// 🔽 Scroll to latest message
function scroll_bottom() {
  const container = $('#conversation-messages')[0];
  if (container) {
    container.scrollTop = container.scrollHeight;
  }
  const generalBox = $('#message-container')[0];
  if (generalBox) {
    generalBox.scrollTop = generalBox.scrollHeight;
  }
}


$(document).on('turbolinks:load', function() {
  $('.ui.dropdown').dropdown();
  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });

  // 🟣 Attach AJAX events for private chat
  $('#private-message-form')
    .on('ajax:success', function(event) {
      console.log("✅ Private message sent");
    })
    .on('ajax:error', function(event) {
      console.error("❌ Error sending private message:", event.detail);
    });

  // 🟣 Attach AJAX events for public chat (optional)
  $('#chat_form')
    .on('ajax:success', function(event) {
      console.log("✅ Public message sent");
    })
    .on('ajax:error', function(event) {
      console.error("❌ Error sending public message:", event.detail);
    });

  submit_message();
  scroll_bottom();
});
