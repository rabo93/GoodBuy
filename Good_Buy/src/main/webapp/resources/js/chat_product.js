//	채팅 메세지 타입 구분
const TYPE_ENTER = "ENTER";
const TYPE_LEAVE = "LEAVE";
const TYPE_TALK = "TALK";
const TYPE_INIT = "INIT";
const TYPE_INIT_COMPLETE = "INIT_COMPLETE";
const TYPE_START = "START";
const TYPE_REQUEST_CHAT_ROOM_LIST = "REQUEST_CHAT_ROOM_LIST";
const TYPE_REQUEST_CHAT_LIST = "REQUEST_CHAT_LIST";

//	채팅 메세지 정렬 위치
const ALIGN_CENTER = "center";
const ALIGN_LEFT = "other";
const ALIGN_RIGHT = "user";
//	====================================================================


//var sId;
$(function() {
	sId = $("#sId").val();
	receiver_id = $("#receiver_id").val();
	product_id = $("#product_id").val();
	
	
	$(".chat-area").on("keypress", ".chatMessage", function(event) {
		let keyCode = event.keyCode;
		if (keyCode == 13) {
			sendInputMessage();
		}
	});
	
	$(".btnSend").on("click", function() {
		sendInputMessage();
	});
	
	$(".chatMessage").on("keypress", function(event) {
		let keyCode = event.keyCode;
		if (keyCode == 13) {
			sendInputMessage();
		}
	});
	
})

function toggleSlideChat() {
	//	슬라이드 메뉴를 열 때
	console.log(sId);
	console.log("receiver_id : " + receiver_id);
	console.log("product_id : " + product_id);
	
	$.ajax({
		url : "ChatRoomAjax",
		type : "POST",
		dataType : "JSON",
		data : {
			sender_id : sId,
			receiver_id : receiver_id,
			product_id : product_id
		}
	}).done(function(result){
		if(result.room_id == null) {
			showChatList(receiver_id, product_id);
			return;
		} else {
			$.ajax({
				url : "ChatListAjax",
				type : "POST",
				dataType : "JSON",
				data : {
					room_id : result.room_id
				}
			}).done(function(response) {
				$(".chat-body").empty();
				for(let message of response) {
					appendMessage(message.type, message.sender_id, message.receiver_id, message.message, message.send_time);
				}
				console.log("!@#!@#");
				console.log(response);
			});
		}
	});
	
	//	슬라이드로 보이기
	$("html").toggleClass("fixed");
	$('.chat-container').toggleClass('open');
}

$("#wrapper-bg").on("click", () => {
	toggleSlideChat();
});

//function closeSlideChat() {
//	// 슬라이드 메뉴를 닫을 때
//	$('.chat-container').removeClass('open');
//	$('html').removeClass("fixed");
//}

function showChatList(receiver_id, product_id) {
	sendMessage(TYPE_INIT_COMPLETE, product_id, "", receiver_id, "", "");
}

function appendMessage(type, sender_id, receiver_id, message, send_time) {
//	//	send_time 추가 예정
	let div_message = "";
	
	if(sender_id == sId) {	// 자신이 보낸 메세지(송신자가 자신인 경우)
		 div_message = `
			 <div class="message user">
				<div class="bubble">${message}</div>
			 </div>
		 `;
	}
	
	if(receiver_id == sId) {	// 자신이 보낸 메세지(송신자가 자신인 경우)
		div_message = '<div class="message other">'
						+ '<div class="bubble">' + message + '</div>'
					 + '</div>';
	}

	$(".chat-body").append(div_message);
	
	
}

function test(data) {
	let x = JSON.parse(data);
	console.log("모달창에서 데이터 확인");
	console.log(x);
}

function sendInputMessage() {
	let message = $(".chatMessage").val();
	
	if(message == "") {
		return;
	}
	
	let room_id = $(".chat-footer > #room_id").val();
	let receiver_id = $(".chat-footer > #receiver_id").val();
	console.log("TYPE_TALK에서 receiver_id 확인 - " + receiver_id);
	
	sendMessage(TYPE_TALK, "", sId, receiver_id, room_id, message);
	
//	$.ajax({
//		url : "ChatRoomAjax",
//		type : "POST",
//		dataType : "JSON",
//		data : {
//			sender_id : sId,
//			receiver_id : receiver_id,
//			product_id : product_id
//		}
//	}).done(function(result){
//		let room_id = result.room_id;
//		console.log("TYPE_TALK에서 receiver_id 확인 - " + receiver_id);
//		sendMessage(TYPE_TALK, "", sId, receiver_id, room_id, message);
//	});
	
	$(".chatMessage").val("");
	$(".chatMessage").focus();
	
}



// ==============================================================================
// 결제창 열기 - 창을 작게 열려고 함수로 만들었음
function openPayWindow(product_id, receiver_id) {
	var url = "PayTransferRequest?product_id=" + encodeURIComponent(product_id) +
              "&receiver_id=" + encodeURIComponent(receiver_id) ;
    payWindow = window.open(url, "chat_window", "width=500,height=500");
}
