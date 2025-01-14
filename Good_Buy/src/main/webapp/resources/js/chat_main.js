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
	let index = $(this).data("index");
	let recentMessage = $(".item-chat" + index).data("message");
	let room_id = $("#room_id" + index).val();
	let title = $("#title" + index).val();
	let receiver_id = $("#receiver_id" + index).val();
	let grade = $("#grade" + index).val();
	let mem_nick = $("#mem_nick" + index).val();
	let mem_profile = $("#mem_profile" + index).val();
	product_id = $("#product_id" + index).val();
	window.index = index;
	window.mem_nick = mem_nick;
	window.mem_profile = mem_profile;
	console.log("index =" + index);
	console.log("room_id =" + room_id);
	console.log("title =" + title);
	console.log("receiver_id =" + receiver_id);
	console.log("sender_id =" + sId);
	console.log("product_id =" + product_id);
	console.log("lastMessage =" + recentMessage);
	console.log("grade =" + grade);
	console.log("mem_nick =" + mem_nick);
	console.log("mem_profile =" + mem_profile);
	
	//	room_id, title, sender_id, receive_id
	let room = {
		room_id : room_id,
		title : title,
		receiver_id : receiver_id,
		sender_id : sId,
		product_id : product_id,
		grade : grade
	}
	
	$(".messageStatus"+ index).empty();
	
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
		
		if (data.type == TYPE_INIT) {	//	채팅 윈도우 초기화
			showChatList(data);
		}
		if (data.type == TYPE_REQUEST_CHAT_LIST) {
			console.log("채팅내역 수신");
			console.log(data.message);
			for(let message of JSON.parse(data.message)) {
				appendMessage(message.type, message.sender_id, message.receiver_id, message.message, message.send_time);
			}
			
		}
		if (data.type == TYPE_TALK) {	// 채팅 입력
			appendMessage(data.type, data.sender_id, data.receiver_id, data.message, data.send_time);
			console.log("채팅리스트 덮어쓰기 작업");
			let recent_div = `${data.message}<span class="item-send-time${index}">&nbsp; · &nbsp; ${data.send_time}</span>`;
			$(".item-chat" + index).empty();
			$(".item-chat" + index).append(recent_div);
			
		}
		
		if(data.type == TYPE_FILE) {	// 파일 전송
			appendMessage(data.type, data.sender_id, data.receiver_id, data.message, data.send_time);
			data.message = "사진을 보냈습니다.";
			let recent_div = `${data.message}<span class="item-send-time${index}">&nbsp; · &nbsp; ${data.send_time}</span>`
			$(".item-chat" + index).empty();
			$(".item-chat" + index).append(recent_div);
		} 
		
		if(data.type == TYPE_REQUEST_PAY) {
			appendMessage(data.type, data.sender_id, data.receiver_id, data.message, data.send_time);
			let recent_div = `${data.message}원을 요청했어요.<span class="item-send-time${index}">&nbsp; · &nbsp; ${data.send_time}</span>`
			$(".item-chat" + index).empty();
			$(".item-chat" + index).append(recent_div);
		}
		
		if(data.type == TYPE_RESPONSE_PAY) {
			appendMessage(data.type, data.sender_id, data.receiver_id, data.message, data.send_time);
			let recent_div = `${data.message}원을 송금했어요<span class="item-send-time${index}">&nbsp; · &nbsp; ${data.send_time}</span>`
			$(".item-chat" + index).empty();
			$(".item-chat" + index).append(recent_div);
		}
	};
	
	initChat();
	
});
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
	if(room.grade == "seller") {
			divRoom = 	  '<div class="extra-header">'
							+ '<button class="close-chat-button" onclick="closeChat()">'
								+ '<i class="fa-solid fa-arrow-left"></i>'
							+ '</button>'
							+ '<button class="report-chat-button" onclick="toggleChatModal(\'open\')">'
								+ '<i class="fa-solid fa-land-mine-on"></i>&nbsp;신고하기'
							+ '</button>'
						+ '</div>'
						+ '<div class="chat-header">'
				           	+ '<a><img src="${pageContext.request.contextPath}/resources/img/testPicture.png" alt="item"></a>'
				           	+ '<div class="title">'+ room.title +' </div>'
				           	+ '<button class="item-button" onclick="requestPay(' + room.product_id + ', \'' + room.receiver_id + '\', \'' + room.room_id + '\')">송금요청</button>'
				           + '</div>'
				           + '<div class="chat-body">'
				           + '</div>'
			           + '<div class="chat-footer">'
				           	+ '<input type="hidden" id="room_id" value="' + room.room_id +'">'
				           	+ '<input type="hidden" id="receiver_id" value="' + room.receiver_id +'">'
				           	+ '<input type="hidden" id="sId" value="' + room.sender_id +'">'
				           	+ '<span class="fileArea">'
				           	+ '<label for="chatFile"><i class="fa-solid fa-circle-plus"></i></label>'
				           	+ '<input type="file" id="chatFile" onchange="sendFile()" accept="image/*">'
				           	+ '</span>'
				           	+ '<input type="text" class="chatMessage" placeholder="메시지를 입력하세요...">'
				            + '<button class="btnSend">전송</button>'
			            + '</div>';
	} else {
		
		divRoom = '<div class="extra-header">'
							+ '<button class="close-chat-button" onclick="closeChat()">'
								+ '<i class="fa-solid fa-arrow-left"></i>'
							+ '</button>'
							+ '<button class="report-chat-button" onclick="toggleChatModal(\'open\')">'
								+ '<i class="fa-solid fa-land-mine-on"></i>&nbsp;신고하기'
							+ '</button>'
						+ '</div>'
						+ '<div class="chat-header">'
				           	+ '<a><img src="${pageContext.request.contextPath}/resources/img/testPicture.png" alt="item"></a>'
				           	+ '<div class="title">'+ room.title +' </div>'
				           	+ '<button class="item-button" onclick="openPayWindow(' + room.product_id + ', \'' + room.receiver_id + '\')">구매하기</button>'
				           + '</div>'
				           + '<div class="chat-body">'
				           + '</div>'
			           + '<div class="chat-footer">'
				           	+ '<input type="hidden" id="room_id" value="' + room.room_id +'">'
				           	+ '<input type="hidden" id="receiver_id" value="' + room.receiver_id +'">'
				           	+ '<input type="hidden" id="sId" value="' + room.sender_id +'">'
				           	+ '<span class="fileArea">'
				           	+ '<label for="chatFile"><i class="fa-solid fa-circle-plus"></i></label>'
				           	+ '<input type="file" id="chatFile" onchange="sendFile()" accept="image/*">'
				           	+ '</span>'
				           	+ '<input type="text" class="chatMessage" placeholder="메시지를 입력하세요...">'
				            + '<button class="btnSend">전송</button>'
			            + '</div>';
	}
	
	
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
	
	//	채팅목록 수신메세지 표시 제거 작업 예정
	
	//	기존 채팅 내역 불러오기 작업
	sendMessage(TYPE_REQUEST_CHAT_LIST, product_id, sId, "", room.room_id, "");
	
}
//	=========================채팅방 목록 작업 끝===============================
//	===========================================================================
//	=========================메세지 보내기 작업 시작===========================
function appendMessage(type, sender_id, receiver_id, message, send_time) {
	//	send_time 추가 예정
	let bubble_message = "";
	let div_message = "";
	
	if(type == TYPE_REQUEST_PAY) {
		message = parseInt(message.replace(/,/g, ''));
		if(receiver_id == sId) {
			bubble_message = `
			<div class="chat-bubble">
				<div class="pay-container">
					<div class="request-pay">
						<p class="pay-text">${mem_nick}님이 ￦ ${message}원을 요청했어요</p>								
						<button class="item-button" onclick="openPayWindow(${product_id}, '${sender_id}', ${message})">송금하기</button>
					</div>
				</div>
			</div>
			 `
		}
		
		if(sender_id == sId) {
			bubble_message = `
			<div class="chat-bubble user">
				<div class="pay-container">
					<div class="request-pay">
						<p class="pay-text">${sNick}님이 ￦ ${message}원을 요청했어요</p>								
						<button class="item-button" onclick="openPayWindow(${product_id}, '${sender_id}', ${message})">송금하기</button>
					</div>
				</div>
			</div>
			 `
		}
		
	}
	if(type == TYPE_RESPONSE_PAY) {
		message = parseInt(message.replace(/,/g, ''));
		bubble_message = `
			<div class="bubble">
				${receiver_id}님에게 ￦ ${message}원을 송금했어요
			</div>
			 `
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
	
	if(receiver_id == sId) {	//	상대방이 보낸 메세지
		if(mem_profile == "") {
			window.mem_profile = "/resources/img/user_thumb.png";
		}
		div_message = `
		<div class="chat-bubble">
			<div class="chat-profile">
				<img src="${baseUrl +  mem_profile}">
			</div>
			<div class="message other">
				${bubble_message}
			</div>
		</div>
		`;
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
			sendMessage(TYPE_FILE_UPLOAD_COMPLETE, product_id, sId, $("#receiver_id").val(), $("#room_id").val(), response.fileName + ":" + response.thumbnailFileName);
		}
		
	});
	
}

//	=========================메세지 보내기 작업 끝============================
//	===============================================================================
//	부모창의 sendMessage() 함수 호출
function sendMessage(type, product_id, sender_id, receiver_id, room_id, message) {
	console.log('sendMessage : ' );
	console.log(type, product_id, sender_id, receiver_id, room_id, message);
	opener.sendMessage(type, product_id, sender_id, receiver_id, room_id, message);
}
function closeChat() {
	$(".chat-area").empty();
}

function isOpenedSidebar() {
	
	return $(".sidebar").length;
}
//	===============================================================================
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
		sendMessage(TYPE_REQUEST_PAY, product_id, sId, receiver_id, room_id, price);
		window.close();
	});
    
});
//	========================= 송금 요청 끝 =========================

// ==============================================================================
// 결제창 열기 - 창을 작게 열려고 함수로 만들었음
function openPayWindow(product_id, receiver_id, price) {
	var url = "PayTransferRequest?product_id=" + encodeURIComponent(product_id) +
              "&receiver_id=" + encodeURIComponent(receiver_id)+
              "&price=" + encodeURIComponent(price) ;
    payWindow = window.open(url, "chat_window", "width=500,height=500");
    
    
    
    
    // 송금 데이터 생성
    const transferData = {
        status: "success",
        message: "송금이 완료되었습니다!",
        amount: 10000,
        receiver: "John Doe"
    };

    // 부모 창에서 즉시 데이터 처리
////    handleTransferResult(transferData);
//
//    // 팝업 창에도 데이터를 전달
//    if (transferPopup) {
//        transferPopup.onload = function () {
//            transferPopup.postMessage(transferData, window.location.origin);
//        };
//    }
}
function handleTransferResult(data) {
    // 받은 데이터를 처리 (예: UI 업데이트)
//    alert("송금 결과: " + data.message);  // alert창 기능은 필요없으니 삭제 
    console.log("송금처리결과 Transfer data:", data);
}

// 팝업 창에서 전달받는 메시지를 처리 (예비 처리)
window.addEventListener("message", function(event) {
    if (event.origin !== window.location.origin) return;
    console.log("팝업창에서 받은 메세지 : ", event.data);
});
