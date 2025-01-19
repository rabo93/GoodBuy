let currentDate = new Date();
const productUrl = location.href;
var baseUrl = productUrl.substring(0, productUrl.lastIndexOf('/ProductDetail'));

//var sId;
$(function() {
	sId = $("#sId").val();
	sNick = $("#sNick").val();
	receiver_id = $("#receiver_id").val();
	product_id = $("#product_id").val();
	mem_nick = $("#chat-mem-nick").val();
	mem_profile = $("#chat-mem-profile").val();
	
	
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
			console.log(result.room_id);
//			window.room_id = result.room_id;
			if($("#room_id").length === 0) {
				$(".chat-container .chat-area").find(".chat-footer").append(`<input type="hidden" id="room_id" value="${result.room_id}">`);
			}
			
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
	
	//	슬라이드로 보이기
	$("html").toggleClass("fixed");
	$('.chat-container').toggleClass('open');
	$(".chat-body").scrollTop($(".chat-body")[0].scrollHeight);
	
}

$("#wrapper-bg").on("click", () => {
	toggleSlideChat();
});

function showChatList(receiver_id, product_id) {
	sendMessage(TYPE_INIT_COMPLETE, product_id, "", receiver_id, "", "", 0);
}

function appendMessage(type, sender_id, receiver_id, message, send_time) {
	let bubble_message = "";
	let div_message = "";
	
	
	if(type == TYPE_REQUEST_PAY || type == TYPE_RESPONSE_PAY || type == TYPE_RESERVATION || type == TYPE_ACCEPT_RESERVATION || type == TYPE_CANCEL_RESERVATION) {
		if(type == TYPE_REQUEST_PAY || type == TYPE_RESPONSE_PAY) {
			message = parseInt(message.replace(/,/g, ''));
		}
		
		let bubble = "chat-bubble";
		let requestPay;
		
		if(receiver_id == sId) {
			if(type == TYPE_REQUEST_PAY) {
				room_id = $(".chat-footer").find("#room_id").val();
				requestPay = `
					<p class="pay-text">${mem_nick}님이 ￦ ${message}원을 요청했어요</p>
					<button class="item-button" onclick="openPayWindow(${product_id}, '${sender_id}', '${message}', '${room_id}')">송금하기</button>
				`;
			} else if(type == TYPE_RESPONSE_PAY) {
				requestPay = `
					<p class="pay-text">${mem_nick}님이 ￦ ${message}원을 송금했어요</p>
					<span><button class="item-button" onclick="closePayWindow('seller')">판매내역으로 이동</button></span>
				`;
			} else if(type == TYPE_RESERVATION) {
				requestPay = `
					<p class="pay-text">${mem_nick}님이 ${message}을 요청했어요</p>
					<button class="item-button" onclick="acceptReservation(${product_id})">요청 수락</button>
				`;
			} else if(type == TYPE_ACCEPT_RESERVATION) {
				requestPay = `
					<p class="pay-text">${mem_nick}님이 예약을 ${message} 했어요</p>
				`;
			} else if(type == TYPE_CANCEL_RESERVATION) {
				requestPay = `
					<p class="pay-text">${mem_nick}님이 예약을 ${message} 했어요</p>
				`;
			}
			
		} else { // sender_id == sId
			bubble += " user";
			
			if(type == TYPE_REQUEST_PAY) {
				requestPay = `
					<p class="pay-text">${sNick}님이 ￦ ${message}원을 요청했어요</p>
					<span></span>
				`;
			} else if(type == TYPE_RESPONSE_PAY) {
				requestPay = `
					<p class="pay-text">${receiver_id}님에게 ￦ ${message}원을 송금했어요</p>
					<span><button class="item-button" onclick="closePayWindow('buyer')">구매내역으로 이동</button></span>
				`;
			} else if(type == TYPE_RESERVATION) {
				requestPay = `
					<p class="pay-text">${sNick}님이 ${message}을 요청했어요</p>
				`;
			} else if(type == TYPE_ACCEPT_RESERVATION) {
				requestPay = `
					<p class="pay-text">${sNick}님이 예약을 ${message} 했어요</p>
					<button class="item-button" onclick="cancelReservation(${product_id})">예약 취소</button>
				`;
			} else if(type == TYPE_CANCEL_RESERVATION) {
				requestPay = `
					<p class="pay-text">${sNick}님이 예약을 ${message} 했어요</p>
				`;
			}
		}
		
		
		bubble_message = `
			<div class="` + bubble + `">
				<div class="pay-container">
					<div class="request-pay">
						` + requestPay + `
					</div>
				</div>
			</div>
		`;
		
	} else if(type == TYPE_TALK) {	// 채팅메세지
		bubble_message = `<div class="bubble">${message}</div>`;
	} else if(type == TYPE_FILE) {
		let hrefUrl = baseUrl + "/resources/upload/chat/" + message.split(":")[0];
		let imgUrl = baseUrl + "/resources/upload/chat/" + message.split(":")[1];
		bubble_message = `<div class="bubble"><a href="${hrefUrl}" target="_blank"><img class="img" src="${imgUrl}"</div>`
	} else if(type == TYPE_LEAVE) {
		bubble_message = `<div class="bubble">${message}</div>`
	}
	
	
	if(sender_id == sId) {	// 자신이 보낸 메세지(송신자가 자신인 경우)
		div_message = '<div class="message user">' + bubble_message + '</div>';
	} else if(receiver_id == sId) {	//	상대방이 보낸 메세지
		
		if(mem_profile == "") {
			window.mem_profile = "/resources/img/user_thumb.png";
		}
		div_message = `
		<div class="chat-bubble">
			<div class="chat-profile">
				<img src="${baseUrl +  mem_profile}">
			</div>
			<div class="message other">
			<span class="chat-mem-nick">${mem_nick}</span>
				${bubble_message}
			</div>
		</div>
		`;
	} else {
		div_message = `<div class="message center">${bubble_message}</div>`;
	}

	$(".chat-body").append(div_message);
	$(".chat-body").scrollTop($(".chat-body")[0].scrollHeight);
	
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
		sendMessage(TYPE_TALK, "", sId, receiver_id, room_id, message, 0);
	});
	
	$(".chatMessage").val("");
	$(".chatMessage").focus();
	
}

//	파일전송 메서드
function sendFile() {
	let file = $("#chatFile")[0].files[0];
	let formData = new FormData();
	formData.append("file", file);
	room_id = $("#room_id").val();
	$.ajax({
		type : "POST",
		url : "ChatFileUpload",
		data : formData,
		dataType : "JSON",
		processData : false,
		contentType : false
	}).done(function(response) {
		if(response.result == "fail") {
			alert(response.message);
			return;
		}
		room_id = $("#room_id").val();
		
		if(response.fileName != "" && response.thumbnailFileName != "") {
			sendMessage(TYPE_FILE_UPLOAD_COMPLETE, product_id, sId, receiver_id, room_id , response.fileName + ":" + response.thumbnailFileName, 0);
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
function requestReservation(product_id) {
	room_id = $("#room_id").val();
	
	if (!room_id) {
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
			sendMessage(TYPE_RESERVATION, product_id, sId, receiver_id, result.room_id, "상품예약");
		});
	} else {
		sendMessage(TYPE_RESERVATION, product_id, sId, receiver_id, room_id, "상품 예약");
	}
}

//	===============================================================================

function openPayWindow(product_id, receiver_id, price, room_id) {
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
			var url = "PayTransferRequest?product_id=" + encodeURIComponent(product_id) +
		              "&receiver_id=" + encodeURIComponent(receiver_id) +
		              "&price=" + encodeURIComponent(price) +
		              "&room_id=" + encodeURIComponent(result.room_id)
		              ;
		    payWindow = window.open(url, "chat_window", "width=500,height=500");
		});
}

function closePayWindow(type) {
	if(type == 'seller') {
    	window.open("MySales", "_blank");
		
	} else if (type == 'buyer') {
    	window.open("MyOrder", "_blank");
	} else if (type == 'transfer') {
    	window.open("AllPayList", "_blank");
		
	}
    window.close();
}
