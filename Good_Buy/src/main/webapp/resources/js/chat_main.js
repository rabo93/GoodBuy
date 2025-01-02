//	채팅 메세지 타입 구분
const TYPE_ENTER = "ENTER";
const TYPE_LEAVE = "LEAVE";
const TYPE_TALK = "TALK";
const TYPE_INIT = "INIT";
const TYPE_INIT_COMPLETE = "INIT_COMPLETE";
const TYPE_START = "START";

//	채팅 메세지 정렬 위치
const ALIGN_CENTER = "center";
const ALIGN_LEFT = "other";
const ALIGN_RIGHT = "user";
//	====================================================================
var ws;
var receiver_id;
var sId;


$(function() {
	
	sId = $("#sId", opener.document).val();
	console.log("sId : " + sId);
	
	console.log("부모창에서 받은 receiver_id : " + receiver_id);
	
	
	window.onmessage = function(e) {
		console.log("부모창 메세지 : " + e.data);
		let data = JSON.parse(e.data);
		
		if (data.type == TYPE_INIT) {
			showChatList(data);
		}
		if (data.type == TYPE_START) {
			startChat(data);
		}
		
		
	};
	
	
//	let wsCheckInterval = setInterval(() => {
//		if (ws != null && ws != undefined && ws.readyState == ws.OPEN) {
//			console.log("웹소켓 연결 완료!");
//			
//			startChat();
//			
//			clearInterval(wsCheckInterval);
//			
//		}
//	}, 1000);
//	
//	$(".chat-area").on("click", ".btnSend", function() {
//		sendInputMessage();
//	});
//	
//	$(".chat-area").on("keypress", ".chatMessage", function(event) {
//		let keyCode = event.keyCode;
//		if (keyCode == 13) {
//			sendInputMessage();
//		}
//	});
	
	
//	$(".btnSend").on("click", function() {
//		sendInputMessage();
//	});
	
//	$(".chatMessage").on("keypress", function(event) {
//		console.log(event);
//		let keyCode = event.keyCode;
//		if (keyCode == 13) {
//			sendInputMessage();
//		}
//	});
	initChat();
	
});
//	====================================================
function initChat() {
	let wsCheckInterval = setInterval(function() {
		ws = opener.ws;
		console.log("chat_main.js - 웹소켓 연결 상태 : " + ws.readyState);
		
		if(ws == null || ws.readyState != ws.OPEN || ws.readyState == ws.CLOSING || ws.readyState == ws.CLOSED) {
			opener.connect();
		} else {
			console.log("웹소켓 연결 완료!")
			//	부모창에게 메세지 전송(sendMessage 함수 호출)
			sendMessage(TYPE_INIT, "", "", "", "");
			
			clearInterval(wsCheckInterval);
		}
		
	}, 1000);
	
}

//	채팅방 목록 표시
function showChatList(data) {
	console.log("receiver_id : " + receiver_id);
	console.log(data.message + " : " + typeof(data.message));
	$(".sidebar").empty();
	
	if(data.message == "null") {
		$(".sidebar").html("<div class='sidebar-item empty'>채팅중인 채팅방 없음</div>")
	} else {
		for(let room of JSON.parse(data.message)) {
			appendChatRoomList(room);
		}
	}
	sendMessage(TYPE_INIT_COMPLETE, "", receiver_id, "", "");
	
}

function sendMessage(type, sender_id, receiver_id, room_id, message) {
	opener.sendMessage(type, sender_id, receiver_id, room_id, message);
}

function startChat(data) {
	console.log("startChat - 채팅방 생성");
}

function appendChatRoomList(room) {
	console.log(room);
}


function sendInputMessage() {
	let message = $(".chatMessage").val();
	
	if(message == "") {
		return;
	}
	
	sendMessage(TYPE_TALK, "", "", "", message);
	
	appendMessage(message, ALIGN_RIGHT);
	
	$(".chatMessage").val("");
	$(".chatMessage").focus();
	
}














