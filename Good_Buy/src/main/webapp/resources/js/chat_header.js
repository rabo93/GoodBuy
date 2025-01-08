var ws;
var startChat;

$(function() {
	connect();
	
	window.onmessage = function(e) {
		console.log("chat_header.js 메세지 : " + e.data);
		let data = JSON.parse(e.data);
		
//		if (data.type == TYPE_INIT) {	//	채팅 윈도우 초기화
//			showChatList(data);
//		}
//		if (data.type == TYPE_REQUEST_CHAT_LIST) {
//			console.log("채팅내역 수신");
//			console.log(data.message);
//			for(let message of JSON.parse(data.message)) {
//				appendMessage(message.type, message.sender_id, message.receiver_id, message.message, message.send_time);
//			}
//		}
//		if (data.type == TYPE_TALK) {	// 채팅 입력
//			appendMessage(data.type, data.sender_id, data.receiver_id, data.message, data.send_time);
//		}
		
	};
});

function connect() {
//	let ws_base_url = "ws://itwillbs.com";
	let ws_base_url = "ws://localhost:8081";
//	let ws_base_url = "ws://localhost:8080";
	ws = new WebSocket(ws_base_url + "/echo");
	console.log("WebSocket 객체 : " + ws);
	console.log("웹소켓 연결 상태 : " + ws.readyState);
	
	ws.onopen = onOpen;
	ws.onmessage = onMessage;
	ws.onclose = onClose;
	ws.onerror = onError;
}

function startChat() {
	let url = "ChatMain"
	let width = 840;
	let height = 640;
	let left = window.innerWidth - width;  // 화면의 오른쪽 끝에서 시작
	let top = 0;  // 화면의 상단
	
	
	startChat = window.open(url, "start_chat", `width=${width},height=${height},left=${left},top=${top}`);
	
//	startChat.receiver_id = receiver_id;
//	startChat.product_id = product_id;
}

function onOpen () {
	console.log("onOpen()");
}

function onMessage(event) {
	console.log("onMessage()");
	startChat.postMessage(event.data);
	test(event.data);
}

//	==============================================================================
//	자신의 채팅창에 메세지를 표시하는 함수
function appendMessage(message, align) {
	$(".chat-body").append("<div class='message "+ align +"'>"
							+ "<div class='bubble'>" + message + "</div>"
							+ "</div>");
}
//	전달받은 메세지를 웹소켓 서버측으로 전송하는 함수
function sendMessage(type, product_id, sender_id, receiver_id, room_id, message) {
	console.log("전송할 메세지(JSON) : " + toJsonString(type, product_id, sender_id, receiver_id, room_id, message));
	
	ws.send(toJsonString(type, product_id, sender_id, receiver_id, room_id, message));
}

//	전달받은 메세지타입과 메세지를 JSON 형식 문자열로 변환하는 함수
function toJsonString(type, product_id, sender_id, receiver_id, room_id, message) {
	//	전달받은 파라미터들을 하나의 객체로 묶기
	let data = {
		type : type,
		product_id : product_id,
		sender_id : sender_id,
		receiver_id : receiver_id,
		room_id : room_id,
		message : message
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






