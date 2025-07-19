//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require activestorage
//= require turbolinks
//= require semantic-ui
//= require cable      
//= require_tree .     
function scroll_bottom() {
  if ($('#message-container').length > 0) {
    $('#message-container').animate({
      scrollTop: $('#message-container')[0].scrollHeight
    }, 300);
  }
}

function submit_message() {
  $('#message_body').on('keydown', function(e) {
    if (e.keyCode == 13 && !e.shiftKey) {
      $('form').submit();
      e.preventDefault();
    }
  });
}

$(document).on('turbolinks:load', function() {
  $('.ui.dropdown').dropdown();
  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });

  submit_message();
  scroll_bottom();
});
