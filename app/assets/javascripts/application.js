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
		var chatUser = $('#user_id').val();
		App.room.speak(chatText, chatGroup, chatUser);
		$('#chat-text').val('');
		$("#chat-text").height(30);
		$("#chat-text").css("lineHeight","30px");
		$(".chat-room").css("padding-bottom","55px");
		setTimeout(function(){
			$('#chat-submit').prop('disabled', false);
			$('html,body').animate({scrollTop: chatPosition}, 'fast');
		}, 800);
		return false;
	});

    $("#chat-text").height(30);//init
	$("#chat-text").css("lineHeight","30px");//init
	$(".chat-room").css("padding-bottom","55px");//init

	$("#chat-text").focus(function(evt){
    	var chatHeight = evt.target.scrollHeight;
    	var roomHeight = chatHeight + 70;
    	$(evt.target).height(chatHeight);
		$(".chat-room").css("padding-bottom",roomHeight - 35 +"px");
	}).blur(function(){
    	$("#chat-text").height(30);
		$("#chat-text").css("lineHeight","30px");
		$(".chat-room").css("padding-bottom","55px");
	});

	$("#chat-text").on("input",function(evt){
		var roomHeight = evt.target.scrollHeight + 70;
		if(evt.target.scrollHeight > evt.target.offsetHeight){
			$(evt.target).height(evt.target.scrollHeight);
			$(".chat-room").css("padding-bottom",roomHeight - 35 +"px");
			$("#chat-text").css("lineHeight","20px");
		}else{
			var lineHeight = Number($(evt.target).css("lineHeight").split("px")[0]);
			while (true){
				$(evt.target).height($(evt.target).height() - lineHeight);
				if(evt.target.scrollHeight > evt.target.offsetHeight){
					$(evt.target).height(evt.target.scrollHeight);
					$(".chat-room").css("padding-bottom",roomHeight - 35 +"px");
					break;
				}
			}
		}
	});

	$('#logout-btn').on('click', function(){
		if(!$('#logout-modal-page').hasClass('active')){
			$('#logout-modal-page').addClass('active');
			$('#logout-modal-page').show();
		}
	});
	$('#logout-modal-page').on('click', function(e){
		if($('#logout-modal-page').hasClass('active') && !$(e.target).closest('#logout-modal').length){
			$('#logout-modal-page').removeClass('active');
			$('#logout-modal-page').hide();
		}
	});

});