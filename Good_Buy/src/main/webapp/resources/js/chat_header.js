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

var ws;
var childChat;

$(function() {
	connect();
	
	sId = $("#sId").val();
	if(sId) {
		//	읽지않은 메세지 요청
		$.ajax({
			url : "GetUnreadMsg",
			type : "POST",
			data : {sId : sId}
		}).done(function(response){
			if(response != 0) {
				$("#chat-btn").append(`<span class="messageStatus"></span>`)
			}
		});
	}
});

function connect() {
//	let ws_base_url = "ws://itwillbs.com";
//	let ws_base_url = "ws://localhost:8081";
//	let ws_base_url = "ws://localhost:8080";
//	let ws_base_url = "ws://c3d2407t1p2.itwillbs.com/";

	let ws_base_url = window.location.href.replaceAll(window.location.href.split(':')[0], 'ws');	

	ws = new WebSocket(ws_base_url + "/echo");
	console.log("WebSocket 객체 : " + ws);
	console.log("웹소켓 연결 상태 : " + ws.readyState);
	
	ws.onopen = onOpen;
	ws.onmessage = onMessage;
	ws.onclose = onClose;
	ws.onerror = onError;
}

function startChat() {
	let chatUrl = "ChatMain"
	let width = 920;
	let height = 800;
	let left = window.innerWidth - width;  // 화면의 오른쪽 끝에서 시작
	let top = 0;  // 화면의 상단
	$(".messageStatus").remove();
	
	childChat = window.open(chatUrl, "start_chat", `width=${width},height=${height},left=${left},top=${top}`);
	window.childChat = childChat;
}

function onOpen () {
	console.log("onOpen()");
}

function onMessage(event) {
	console.log("onMessage()");
	sId = $("#sId").val();
	let data = JSON.parse(event.data);
	if(childChat && !childChat.closed) {
		childChat.postMessage(event.data);
		
	} else {
		if(!data.sender_id == sId) {
			console.log("sender_id확인");
		}
		chatProduct(event.data);
	}
	
}

function chatProduct(e) {
	let chatData = JSON.parse(e);
	if(chatData.type == TYPE_START) {
		console.log("room_id : " + chatData.room_id);
		window.room_id = chatData.room_id;
		console.log("window.room_id : " + window.room_id);
		if($(".chat-body").children().length == 0) {
			sendMessage(TYPE_TALK, "", sId, receiver_id, room_id, "안녕하세요 판매글 보고 연락드립니다.");
		}
	} else if (chatData.type == TYPE_TALK || chatData.type == TYPE_FILE) {
		appendMessage(chatData.type, chatData.sender_id, chatData.receiver_id, chatData.message, chatData.send_time);
	}
	
}


//	==============================================================================
//	자신의 채팅창에 메세지를 표시하는 함수
//function appendMessage(message, align) {
//	$(".chat-body").append("<div class='message "+ align +"'>"
//							+ "<div class='bubble'>" + message + "</div>"
//							+ "</div>");
//}
//	전달받은 메세지를 웹소켓 서버측으로 전송하는 함수
function sendMessage(type, product_id, sender_id, receiver_id, room_id, message, idx) {
//	console.log("전송할 메세지(JSON) : " + toJsonString(type, product_id, sender_id, receiver_id, room_id, message));
	console.log("sendMessage() 호출됨!");
	ws.send(toJsonString(type, product_id, sender_id, receiver_id, room_id, message, idx));
}

//	전달받은 메세지타입과 메세지를 JSON 형식 문자열로 변환하는 함수
function toJsonString(type, product_id, sender_id, receiver_id, room_id, message, idx) {
	console.log("전송할 메세지 : " + type + ", " + product_id + ", " + sender_id + ", " + receiver_id + ", " + room_id + ", " + message + ", " + idx);
	
	//	전달받은 파라미터들을 하나의 객체로 묶기
	let data = {
		type : type,
		product_id : product_id,
		sender_id : sender_id,
		receiver_id : receiver_id,
		room_id : room_id,
		message : message,
		idx : idx
	}
	return JSON.stringify(data);
}

//	=====================================================================
function onClose() {
//	console.log("onClose()");
}

function onError() {
	console.log("onError()");
}






