var ws;
var slideChat;

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

function openSlideChat(receiver_id) {
	console.log("receiver_id : " + receiver_id);
	let url = "ChatMain"
	
	slideChat = window.open(url, "slide_chat");
	
	slideChat.receiver_id = receiver_id;
	
}

function onOpen () {
	console.log("onOpen()");
}

function onMessage(event) {
	console.log("onMessage()");
	let data = JSON.parse(event.data);
	console.log("data : " + JSON.stringify(data));
	
	slideChat.postMessage(event.data);
	
}

//function testOpenChat(product_id) {
//	$(".chat-area").empty();
//	connect();
//	console.log("product_id : " + product_id);
//	//	상품리스트와 연동 완료시 AJAX로 활용 예정
//	$(".chat-area").append(
//		'<div class="chat-header">'
//			+ '<a><img src="${pageContext.request.contextPath}/resources/img/testPicture.png" alt="item"></a>'
//			+ '<div class="title">아기 유아 어그부츠 150cm</div>'
//			+ '<button class="item-button">구매하기</button>'
//		+ '</div>'
//		+ '<div class="chat-body">'
//		+ '</div>'
//		+ '<div class="chat-footer">'
//			+ '<input type="text" class="chatMessage" placeholder="메시지를 입력하세요...">'
//			+ '<button class="btnSend">전송</button>'
//		+ '</div>'
//	);
//	
//}


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
	//	전달받은 파라미터들을 하나의 객체로 묶기
	let data = {
		type : type,
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






