//	채팅 메세지 타입 구분
const TYPE_ENTER = "ENTER";
const TYPE_LEAVE = "LEAVE";
const TYPE_TALK = "TALK";
const TYPE_INIT = "INIT";
const TYPE_INIT_COMPLETE = "INIT_COMPLETE";
const TYPE_START = "START";
const TYPE_REQUEST_CHAT_ROOM_LIST = "REQUEST_CHAT_ROOM_LIST";
const TYPE_REQUEST_CHAT_LIST = "REQUEST_CHAT_LIST";
const TYPE_FILE_UPLOAD_COMPLETE = "FILE_UPLOAD_COMPLETE";
const TYPE_FILE = "FILE";

//	채팅 메세지 정렬 위치
const ALIGN_CENTER = "center";
const ALIGN_LEFT = "other";
const ALIGN_RIGHT = "user";
//	====================================================================
const productUrl = location.href;
var baseUrl = productUrl.substring(0, productUrl.lastIndexOf('/ProductDetail'));

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
	
	$("#chatReporting").on("click", function() {
		let reason = $("select[name=ch-modal-sb] option:selected").text() == "기타" ? $(".ch-modal-otherReason").val() : 
																					  $("select[name=ch-modal-sb] option:selected").text();
		console.log(product_id);
		console.log(receiver_id);
		console.log(reason);
		console.log(sId);
		
		$.ajax({
			url: "ChatReport",
			type: "POST",
			data: {
				reporter_id : sId,
				reported_id : receiver_id,
				product_id : product_id,
				reason : reason,
			},
			dataType: "JSON"
		}).done(function(response){
			console.log(response);
			alert(response);
			window.location.reload();
		});
	})
	
	$(document).ready(function(){
		$(".ch-modal-otherReason").text($("select[name=ch-modal-sb] option:selected").val());
		$("select[name=ch-modal-sb]").change(function(){
			if ($("select[name=ch-modal-sb] option:selected").text() == "기타") {
				$(".ch-modal-otherReason").removeAttr("readonly");
				$(".ch-modal-otherReason").val("");
				$(".ch-modal-otherReason").attr("placeholder", "기타 사유를 입력해주세요.");
			} else {
				$(".ch-modal-otherReason").attr("readonly", "readonly");
				$(".ch-modal-otherReason").val($("select[name=ch-modal-sb] option:selected").val());
			}
		});
	})
	
});

function chatProduct(e) {
	let chatData = JSON.parse(e);
	if(chatData.type == TYPE_START) {
		console.log("room_id : " + chatData.room_id);
		window.room_id = chatData.room_id;
		console.log("window.room_id : " + window.room_id);
//		appendMessage(TYPE_TALK, sId, receiver_id, "")
	}
	
	if (chatData.type == TYPE_TALK || chatData.type == TYPE_FILE) {
		appendMessage(chatData.type, chatData.sender_id, chatData.receiver_id, chatData.message, chatData.send_time);
	}
	
}

//	슬라이드 메뉴를 열 때
function toggleSlideChat() {
	if(childChat && !childChat.closed) {
		childChat.close();
	}
	console.log(sId);
	console.log("receiver_id : " + receiver_id);
	console.log("product_id : " + product_id);
	
	//	AJAX로 기존 채팅방 존재여부 판단
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
		console.log(result);
		if(result == null) {
			showChatList(receiver_id, product_id);
//			return;
		} else {
			window.room_id = result.room_id;
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
				
			});
		}
	});
	
	console.log("채팅방 비어잇나? : " + $(".chat-body").length);
	
	if($(".chat-body").length == 0) {
		console.log("채팅 시작 메세지 ㄱㄱ");
	}
	
	
	//	슬라이드로 보이기
	$("html").toggleClass("fixed");
	$('.chat-container').toggleClass('open');
	$(".chat-body").scrollTop($(".chat-body")[0].scrollHeight);
}

$("#wrapper-bg").on("click", () => {
	toggleSlideChat();
});

function showChatList(receiver_id, product_id) {
	sendMessage(TYPE_INIT_COMPLETE, product_id, "", receiver_id, "", "");
}

function appendMessage(type, sender_id, receiver_id, message, send_time) {
	//	send_time 추가 예정
	let bubble_message = "";
	let div_message = "";	
	
	if(type != TYPE_TALK && type != TYPE_FILE) {
		div_message = '<div class="message center">'
						+ '<div class="bubble">' + message + '</div>'
					 + '</div>';
	}
	
	if(type == TYPE_TALK) {	// 채팅메세지
		bubble_message = '<div class="bubble">' + message + '</div>';
	}
	
	if(type == TYPE_FILE) {
		let hrefUrl = baseUrl + "/resources/upload/chat/" + message.split(":")[0];
		let imgUrl = baseUrl + "/resources/upload/chat/" + message.split(":")[1];
		bubble_message = '<div class="bubble"><a href="' + hrefUrl + '" target="_blank"><img class="img" src="' + imgUrl + '"</div>'
	}
	
	if(sender_id == sId) {	// 자신이 보낸 메세지(송신자가 자신인 경우)
		div_message = '<div class="message user">' + bubble_message + '</div>';
	}
	
	if(receiver_id == sId) {	// 자신이 보낸 메세지(송신자가 자신인 경우)
		div_message = '<div class="message other">' + bubble_message + '</div>';
	}

	$(".chat-body").append(div_message);
//	$(".chat-body").scrollTop($(".chat-body")[0].scrollHeight);
	
}

function sendInputMessage() {
	let message = $(".chatMessage").val();
	
	if(message == "") {
		return;
	}
	
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
		let room_id = result.room_id;
		console.log("TYPE_TALK에서 receiver_id 확인 - " + receiver_id);
		sendMessage(TYPE_TALK, "", sId, receiver_id, room_id, message);
	});
	
	$(".chatMessage").val("");
	$(".chatMessage").focus();
	
}

//	파일전송 메서드
function sendFile() {
	let file = $("#chatFile")[0].files[0];
	let formData = new FormData();
	formData.append("file", file);
	
	$.ajax({
		type : "POST",
		url : "ChatFileUpload",
		data : formData,
		dataType : "JSON",
		processData : false,
		contentType : false
	}).done(function(response) {
		console.log("업로드 성공 후 AJAX 응답");
		console.log(response);
		
		if(response.result == "fail") {
			alert(response.message);
			return;
		}
		
		if(response.fileName != "" && response.thumbnailFileName != "") {
			sendMessage(TYPE_FILE_UPLOAD_COMPLETE, product_id, sId, receiver_id, window.room_id , response.fileName + ":" + response.thumbnailFileName);
		}
		
	});
	
}


//	================================================================
//	모달창 띄우기
function toggleChatModal(action) {
    if (action == 'open') {
        $('.ch-modal-wrap').show();
        $('.ch-modal-bg').show();
    } else if (action == 'close') {
        $('.ch-modal-wrap').hide();
        $('.ch-modal-bg').hide();
    }
}


// ==============================================================================
// 결제창 열기 - 창을 작게 열려고 함수로 만들었음
function openPayWindow(product_id, receiver_id, room_id) {
	var url = "PayTransferRequest?product_id=" + encodeURIComponent(product_id) +
              "&receiver_id=" + encodeURIComponent(receiver_id) +
              "&room_id=" + encodeURIComponent(room_id);
    payWindow = window.open(url, "chat_window", "width=500,height=500");
}
