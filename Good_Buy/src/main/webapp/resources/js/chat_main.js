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
const TYPE_READ = "READ";
const TYPE_REQUEST_PAY = "REQUEST_PAY";
const TYPE_RESPONSE_PAY = "RESPONSE_PAY";
const TYPE_RESERVATION = "RESERVATION";
const TYPE_ACCEPT_RESERVATION = "ACCEPT_RESERVATION";
const TYPE_CANCEL_RESERVATION = "CANCEL_RESERVATION";

//	채팅 메세지 정렬 위치
const ALIGN_CENTER = "center";
const ALIGN_LEFT = "other";
const ALIGN_RIGHT = "user";
//	====================================================================
var ws;
var receiver_id;
//var sId;
var product_id;
var sNick;
const childUrl = location.href;
var baseUrl = childUrl.substring(0, childUrl.lastIndexOf('/ChatMain'));


$(".sidebar-item").on("dblclick", function() {
	let room_id = $(this).find(".item-container .room_id").val();
	let roomItem = $(".sidebar-item." + room_id + " .item-container");
	let title = $(roomItem).find(".title").val();
	let receiver_id = $(roomItem).find(".receiver_id").val();
	let product_id = $(roomItem).find(".product_id").val();
	let grade = $(roomItem).find(".grade").val();
	let mem_nick = $(roomItem).find(".mem_nick").val();
	let mem_profile = $(roomItem).find(".mem_profile").val();
	let product_img = $(roomItem).find(".product_img").val();
	
	console.log("title : " + title);
	console.log("receiver_id : " + receiver_id);
	console.log("product_id : " + product_id);
	console.log("grade : " + grade);
	console.log("mem_nick : " + mem_nick);
	console.log("mem_profile : " + mem_profile);
	console.log("product_img : " + product_img);
	
//	window.room_id = room_id;
	window.product_id = product_id;
	window.mem_nick = mem_nick;
	window.mem_profile = mem_profile;
	window.product_img = product_img;
	
	//	room_id, title, sender_id, receive_id
	let room = {
		room_id : room_id,
		title : title,
		receiver_id : receiver_id,
		sender_id : sId,
		product_id : product_id,
		grade : grade
	}
	
	$(roomItem).find("#messageStatus").remove();
	
	showChatRoom(room);
})

$(function() {
	
	sId = $("#sId", opener.document).val();
	console.log("sId : " + sId);
	sNick = $(opener.document).find("#sNick").val();
	console.log("sNick : " + sNick);
	
	if (!sId) {
		alert("로그인이 필요합니다.\n로그인 페이지로 이동합니다.")
		opener.location.href = "MemberLogin";
		window.close();
	}
	window.onmessage = function(e) {
		console.log("부모창 메세지 : " + e.data);
		let data = JSON.parse(e.data);
		let recent_div = "";
		let fileMessage
		
		if (data.type == TYPE_INIT) {	//	채팅 윈도우 초기화
			showChatList(data);
			return;
		} else if (data.type == TYPE_REQUEST_CHAT_LIST) {
			console.log("채팅내역 수신");
			console.log(data.message);
			for(let message of JSON.parse(data.message)) {
				appendMessage(message.type, message.sender_id, message.receiver_id, message.message, message.send_time);
			}
			return;
		
		} else if (data.type == TYPE_TALK) {	// 채팅 입력
			console.log("TYPE_TALK - room_id : " + data.room_id);
			recent_div = `${data.message}<span class="item-send-time">${data.send_time}</span>`;
		} else if(data.type == TYPE_FILE) {	// 파일 전송
			fileMessage = "사진을 보냈습니다.";
			recent_div = `${fileMessage}<span class="item-send-time">${data.send_time}</span>`
		} else if(data.type == TYPE_REQUEST_PAY) {
			recent_div = `${data.message}원을 요청했어요.<span class="item-send-time">${data.send_time}</span>`
		} else if(data.type == TYPE_RESPONSE_PAY) {
			recent_div = `${data.message}원을 송금했어요<span class="item-send-time$">${data.send_time}</span>`
		} else if(data.type == TYPE_RESERVATION) {
			recent_div = `${data.message}을 요청했어요<span class="item-send-time">${data.send_time}</span>`;
		} else if(data.type == TYPE_ACCEPT_RESERVATION) {
			recent_div = `상품예약을 ${data.message} 했어요<span class="item-send-time">${data.send_time}</span>`;
		} else if(data.type == TYPE_CANCEL_RESERVATION) {
			recent_div = `상품예약을 ${data.message} 했어요<span class="item-send-time">${data.send_time}</span>`;
		} else if(data.type == TYPE_LEAVE) {
			recent_div = `${data.message}`;
		}
		
		//	채팅방이 열려있는지 & 해당 채팅방이 현재 수신된 메세지의 상대방과의 채팅방인지 체크
		if(isOpenedChatRoom && getOpenedChatRoomId() == data.room_id) {
			appendMessage(data.type, data.sender_id, data.receiver_id, data.message, data.send_time);
			if(data.receiver_id == sId) {
				sendMessage(TYPE_READ, data.product_id, data.sender_id, data.receiver_id, data.room_id, data.message, data.idx);
			}
		} else { // 채팅방이 열려있지 않을 경우
			let messageCnt = $(".sidebar-item." + data.room_id).find("#messageStatus").text();
			if(!messageCnt) {
				messageCnt = 0;
				$(".sidebar-item." + data.room_id).find(".item").append(`<span id="messageStatus" class="unread_msg">${Number(messageCnt) + 1}</span>`);
			} else {
				$(".sidebar-item." + data.room_id).find(".item").find("span").text(Number(messageCnt) + 1);
			}
			
		}
		
		$(".sidebar-item." + data.room_id + " .item-chat").empty();
		$(".sidebar-item." + data.room_id + " .item-chat").append(recent_div);
		
	};
	
	initChat();
	
});

//	채팅창 열려있는지 판단 메서드
function isOpenedChatRoom() {
	if($(".chat-area").length == 1) {
		return true;
	}
	return false;
}
//	채팅창에서 room_id 리턴 메서드
function getOpenedChatRoomId() {
	if(isOpenedChatRoom()) {
		return $(".chat-footer").find("#room_id").val();
	}
	
}
//	채팅창에서 receiver_id 리턴 메서드
function getOpenedReciverId() {
	if(isOpenedChatRoom()) {
		return $(".chat-footer").find("#receiver_id").val();
	}
	
}

//	=========================채팅방 목록 작업 시작===========================
function initChat() {
	let wsCheckInterval = setInterval(function() {
		ws = opener.ws;
		console.log("chat_main.js - 웹소켓 연결 상태 : " + ws.readyState);
		
		if(ws == null || ws.readyState != ws.OPEN || ws.readyState == ws.CLOSING || ws.readyState == ws.CLOSED) {
			opener.connect();
		} else {
			console.log("웹소켓 연결 완료!")
			//	부모창에게 메세지 전송(sendMessage 함수 호출)
			sendMessage(TYPE_INIT, "", "", "", "", "");
			
			clearInterval(wsCheckInterval);
		}
		
	}, 1000);
	
}
//	채팅방 목록 표시
function showChatList(data) {
	sendMessage(TYPE_INIT_COMPLETE, product_id, "", receiver_id, "", "");
}

//	채팅창 생성
function showChatRoom(room) {
	console.log("showChatRoom -  채팅화면 표시 - " + room);
	console.log(room);
	let divRoom = "";
	let itemButton;
	if(room.grade == "seller") {
		itemButton = `
			<button class="item-button" onclick="requestPay(${room.product_id} , '${room.receiver_id}', '${room.room_id}')">송금요청</button>
		`;
	} else {
		itemButton = `
			<button class="item-button" onclick="requestReservation(${room.product_id})">예약요청</button>	
		`;
	}
	
	divRoom = `
		<div class="extra-header">
			<button class="close-chat-button" onclick="closeChat()">
				<i class="fa-solid fa-arrow-left"></i>
			</button>
			<button id="chat-option">
				<i class="fa-solid fa-ellipsis"></i>
			</button>
			<div id="chat-panel">
				<button class="report-chat-button" onclick="toggleChatModal(\'open\')">
					<i class="fa-solid fa-land-mine-on"></i>&nbsp;신고하기
				</button>
				<button class="report-chat-leave" onclick="leaveChat()">
					<i class="fa-solid fa-arrow-right-from-bracket"></i>&nbsp;나가기
				</button>
			</div>
		</div>
		<div class="chat-header">
           	<a><img src="${baseUrl}/resources/upload/${product_img}" alt="item"></a>
           	<div class="title">${room.title}</div>
           	${itemButton}
           </div>
           <div class="chat-body">
           </div>
       	<div class="chat-footer">
         	<input type="hidden" id="room_id" value="${room.room_id}">
           	<input type="hidden" id="receiver_id" value="${room.receiver_id}">
           	<input type="hidden" id="sId" value="${room.sender_id}">
           	<span class="fileArea">
           	<label for="chatFile"><i class="fa-solid fa-circle-plus"></i></label>
           	<input type="file" id="chatFile" onchange="sendFile()" accept="image/*">
           	</span>
           	<input type="text" class="chatMessage" placeholder="메시지를 입력하세요...">
            <button class="btnSend">전송</button>
        </div>
	`;
	
	//	chat-area 영역에 채팅창 div 출력
	$(".chat-area").html(divRoom);
		$(".chat-area").on("click", ".btnSend", function() {
		sendInputMessage();
	});
	
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
	
	$("#chat-option").on("click", function(e){
		e.stopPropagation();
		$("#chat-panel").toggleClass("on");
	});
	
	$("#chat-panel").on("click", function(e){
		e.stopPropagation();
	});
	
	$(document).on("click", function() {
		$("#chat-panel").removeClass("on");
	});
	
	//	채팅목록 수신메세지 표시 제거 작업 예정
	
	//	기존 채팅 내역 불러오기 작업
	sendMessage(TYPE_REQUEST_CHAT_LIST, product_id, sId, "", room.room_id, "");
	sendMessage(TYPE_READ, product_id, sId, "", room.room_id, "");
}
//	=========================채팅방 목록 작업 끝===============================
//	===========================================================================
//	=========================메세지 보내기 작업 시작===========================
function appendMessage(type, sender_id, receiver_id, message, send_time) {
	//	send_time 추가 예정
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
		div_message = `
		<div class="message user">
			${bubble_message}
		</div>
		`;
	} else if(receiver_id == sId && type != TYPE_LEAVE) {	//	상대방이 보낸 메세지
		
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
	} else if (type == TYPE_LEAVE) {
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
	
	let room_id = $(".chat-footer > #room_id").val();
	let receiver_id = $(".chat-footer > #receiver_id").val();
	console.log("TYPE_TALK에서 receiver_id 확인 - " + receiver_id);
	
	sendMessage(TYPE_TALK, "", sId, receiver_id, room_id, message);

	
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
			sendMessage(TYPE_FILE_UPLOAD_COMPLETE, product_id, sId, $("#receiver_id").val(), $("#room_id").val(), response.fileName + ":" + response.thumbnailFileName, 0);
		}
		
	});
	
}

//	=========================메세지 보내기 작업 끝============================
//	===============================================================================
//	부모창의 sendMessage() 함수 호출
function sendMessage(type, product_id, sender_id, receiver_id, room_id, message, idx, price) {
	console.log(type, product_id, sender_id, receiver_id, room_id, message, idx, price);
	opener.sendMessage(type, product_id, sender_id, receiver_id, room_id, message, idx, price);
}
function closeChat() {
	$(".chat-area").empty();
}

function isOpenedSidebar() {
	return $(".sidebar").length;
}
//	===============================================================================
//	==============================extra-header 영역================================
//	[ 모달창 ]
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

$("#chatReporting").on("click", function() {
	let reason = $("select[name=ch-modal-sb] option:selected").text() == "기타" ? $(".ch-modal-otherReason").val() : 
																				  $("select[name=ch-modal-sb] option:selected").text();
	console.log(product_id);
	let reported_id = $("#receiver_id").val();
	console.log(reported_id);
	console.log(reason);
	console.log(sId);
	
	$.ajax({
		url: "ChatReport",
		type: "POST",
		data: {
			reporter_id : sId,
			reported_id : reported_id,
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

function leaveChat(){
	if(confirm("채팅방을 나가시겠습니까?")) {
		room_id = getOpenedChatRoomId();
		receiver_id = getOpenedReciverId();
		sendMessage(TYPE_LEAVE, 0, sId, receiver_id, room_id);
		
		$(".chat-area").empty();
		$(".sidebar-item." + room_id).remove();
	}
}
//	===============================================================================
//	========================= 송금 요청 시작 =========================
function requestPay(product_id, receiver_id, room_id) {
	var requestPayUrl = "ChatRequestPay?product_id=" + product_id + "&receiver_id=" + receiver_id + "&room_id=" + room_id;
	window.open(requestPayUrl, "chat_request_pay", "width=500,height=500");
}

$(document).ready(function() {
	
    // 초기 가격을 숫자로 설정 (₩을 제외한 숫자만)
    let product_price = parseInt($("#priceDisplay").text().replace(/[^\d]/g, ''));

    // 상품 가격 초기화 화면에 표시 (숫자 값으로)
    $('#priceDisplay').text('₩ ' + formatNumber(product_price));

    const $inputField = $('#inputField');
    const $priceDisplay = $('#priceDisplay');
    const $keys = $('.key');

    // 숫자 버튼 클릭 시 처리
    $keys.each(function() {
        $(this).click(function() {
            const value = $(this).data('value');
            
            if (value === 'clear') {
                $inputField.val('');  // C 버튼 클릭 시 입력값 초기화
                $priceDisplay.text('₩ ' + formatNumber(product_price));  // 초기 가격 표시
            } else if (value === 'enter') {
                // 엔터 버튼 클릭 시 입력한 가격을 상품 가격으로 표시
                let enteredValue = parseInt($inputField.val().replace(/[^\d]/g, '')); // 입력된 값에서 숫자만 추출
                if (!isNaN(enteredValue)) {
                    product_price = enteredValue;  // 실제 product_price 값 갱신
                    $priceDisplay.text('₩ ' + formatNumber(product_price));
                }
                $inputField.val('');  // 입력 필드는 초기화
            } else {
                // 숫자 버튼 클릭 시 입력값에 숫자 추가
                if ($inputField.val() === '') {
                    $priceDisplay.text(''); // 기존 가격 없애기
                }
                let currentValue = $inputField.val() + value;
                $inputField.val(currentValue);  // 숫자 추가
                $inputField.val(formatNumber(currentValue.replace(/[^\d]/g, ''))); // 쉼표 추가
            }
        });
    });

    // 숫자 형식에 쉼표 추가하는 함수
    function formatNumber(number) {
        return Number(number).toLocaleString();
    }
    
    $("#requsetBtn").on("click", function() {
		room_id = $("#room_id").val();
		receiver_id = $("#receiver_id").val();
		product_id = $("#product_id").val();
		let priceText = $("#priceDisplay").text();
		let price = priceText.replace('₩', '').trim();
		console.log(price);
		console.log(room_id);
		console.log(receiver_id);
		console.log(product_id);
		sendMessage(TYPE_REQUEST_PAY, product_id, sId, receiver_id, room_id, 0, price);
		window.close();
	});
    
   $("#transfer-btn-chat").on("click", function() {
//		alert('transfer-btn-chat'); 잘들어옴.
		receiver_id = $("#receiver_id").val();
		product_id = $("#product_id").val();
		room_id = $("#room_id").val();
		price = $("#tran_amt").val();
		sendMessage(TYPE_RESPONSE_PAY, product_id, sId, receiver_id, room_id, 0, price); // 이거 안됨
//		sendMessage(TYPE_REQUEST_PAY, product_id, sId, receiver_id, room_id, price); // 이거 됨

	});		
	
    
});
//	========================= 송금 요청 끝 =========================
//	========================= 예약요청 요청=========================
function requestReservation(product_id, room_id) {
	room_id = $("#room_id").val();
	receiver_id = $("#receiver_id").val();
	sendMessage(TYPE_RESERVATION, product_id, sId, receiver_id, room_id, "상품 예약");
}
function acceptReservation(product_id) {
	room_id = $("#room_id").val();
	receiver_id = $("#receiver_id").val();
	sendMessage(TYPE_ACCEPT_RESERVATION, product_id, sId, receiver_id, room_id, "수락");
}
function cancelReservation(product_id) {
	room_id = $("#room_id").val();
	receiver_id = $("#receiver_id").val();
	sendMessage(TYPE_CANCEL_RESERVATION, product_id, sId, receiver_id, room_id, "취소");
}

//	========================= 예약요청 요청 끝 =========================

// ==============================================================================
// 결제창 열기 - 창을 작게 열려고 함수로 만들었음
function openPayWindow(product_id, receiver_id, price, room_id) {
	
	var url = "PayTransferRequest?product_id=" + encodeURIComponent(product_id) +
              "&receiver_id=" + encodeURIComponent(receiver_id) +
              "&price=" + encodeURIComponent(price) +
              "&room_id=" + encodeURIComponent(room_id)
              ;
//    payWindow = window.open(url, "chat_window", "width=500,height=500"); // 부모창에 전달안되는게 변수 때문인가? 싶어서 주석침.
    payWindow = window.open(url, "chat_window", "width=500,height=500");
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