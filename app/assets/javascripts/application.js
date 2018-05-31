// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require_tree .
$(document).on('turbolinks:load', function() {

	var chatPosition = $('#chat-room')[0].scrollHeight;
	if(chatPosition){
		$('html,body').delay(100).animate({
      		scrollTop: chatPosition
    	},'fast');
	}

	$('#chat-message').submit(function(){
		$('#chat-submit').prop('disabled', true);
		var chatText = $('#chat-text').val();
	   	var chatGroup = $('#group_id').val();
       	App.room.speak(chatText, chatGroup);
       	$('#chat-text').val('');
		setTimeout(function(){
   			$('#chat-submit').prop('disabled', false);
       		$('html,body').animate({scrollTop: chatPosition}, 'fast');
   		}, 800);
       	return false;
    });

});