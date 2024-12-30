let ws;
//	채팅 메세지 타입 구분
const TYPE_ENTER = "ENTER";
const TYPE_LEAVE = "LEAVE";
const TYPE_TALK = "TALK";
const TYPE_INIT = "INIT";
const TYPE_INIT_COMPLETE = "INIT_COMPLETE";

//	채팅 메세지 정렬 위치
const ALIGN_CENTER = "center";
const ALIGN_LEFT = "other";
const ALIGN_RIGHT = "user";
//	====================================================================
$(function() {
	connect();
});


function connect() {
//	let ws_base_url = "ws://itwillbs.com";
	let ws_base_url = "ws://localhost:8081";
	ws = new WebSocket(ws_base_url + "/echo");
	console.log("WebSocket 객체 : " + ws);
	console.log("웹소켓 연결 상태 : " + ws.readyState);
	
	ws.onopen = onOpen;
	ws.onmessage = onMessage;
	ws.onclose = onClose;
	ws.onerror = onError;
}

function onOpen () {
	console.log("onOpen()");
	sendMessage(TYPE_ENTER, "", "", "", ">> 채팅방에 입장했습니다 <<");
}

function onMessage(event) {
	console.log("onMessage()");
	let data = JSON.parse(event.data);
	console.log("data : " + data);
	
	if(data.type == TYPE_INIT) {
		$(".sidebar").empty();
		if (data.message == "null") {
			$(".sidbar").html("채팅중인 채팅방 없음");
			return;
		}
		sendMessage(TYPE_INIT_COMPLETE, "", data.receiver_id, "", "");
	} else if(data.type == TYPE_ENTER || data.type == TYPE_LEAVE) {
		appendMessage(data.message, ALIGN_CENTER);
	} else if(data.type == TYPE_TALK) {
		appendMessage(data.sender_id + " : " + data.message, ALIGN_LEFT)
	}
}

function onClose() {
	console.log("onClose()");
}

function onError() {
	console.log("onError()");
}


//	==============================================================================
//	자신의 채팅창에 메세지를 표시하는 함수
function appendMessage(message, align) {
	$(".chat-body").append("<div class='message "+ align +"'>"
							+ "<div class='bubble'>" + message + "</div>"
							+ "</div>");
}
//	전달받은 메세지를 웹소켓 서버측으로 전송하는 함수
function sendMessage(type, sender_id, receiver_id, room_id, message) {
	console.log("전송할 메세지(JSON) : " + toJsonString(type, sender_id, receiver_id, room_id, message));
	
	ws.send(toJsonString(type, sender_id, receiver_id, room_id, message));
}
//	전달받은 메세지타입과 메세지를 JSON 형식 문자열로 변환하는 함수
function toJsonString(type, sender_id, receiver_id, room_id, message) {
	let data = {
		type : type,
		sender_id : sender_id,
		receiver_id : receiver_id,
		room_id : room_id,
		message : message
	}
	return JSON.stringify(data);
}








