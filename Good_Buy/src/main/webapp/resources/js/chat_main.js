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
var ws;
var receiver_id;
var sId;
var product_id;


$(function() {
	
	sId = $("#sId", opener.document).val();
	console.log("sId : " + sId);
	
	if (!sId) {
		alert("로그인이 필요합니다.\n로그인 페이지로 이동합니다.")
		opener.location.href = "MemberLogin";
		window.close();
	}
	
	
	console.log("부모창에서 받은 receiver_id : " + receiver_id);
	console.log("부모창에서 받은 product_id : " + product_id);
	
	
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
	//	product_id 임시로 13 메세지 전달
	sendMessage(TYPE_INIT_COMPLETE, product_id, "", receiver_id, "", "");
}
//	채팅방 생성 및 채팅창 목록 추가
function startChat(data) {
	console.log("startChat - 채팅방 생성");
	//	"채팅중인 채팅방 없음" 삭제
	$(".sidebar-item.empty").remove();
	
	appendChatRoomList(JSON.parse(data.message));
}
//	채팅방 정보 추가
function appendChatRoomList(room) {
	console.log(room);
	
	if(!$(".sidebar-item").hasClass(room.room_id)) {
		let title = room.title;
		let divRoom = "<div class='sidebar-item " + room.room_id + "'>" + title + "<span class='messageStatus'></span></div>";
		$(".sidebar").prepend(divRoom);
		
		//	채팅방 더블클릭시 채팅창 활성화
		$(".sidebar-item." + room.room_id).on("dblclick", function() {
//			if($(".chat-area").length == 1 && $(".sidebar-item .room_id").val() != room.room_id) {
//				closeRoom();
//				showChatRoom(room);
//			}
			showChatRoom(room);
		})
		
	}
	
}
//	채팅창 생성
function showChatRoom(room) {
	console.log("showChatRoom -  채팅화면 표시 ");
	console.log(room);
	
	let divRoom = '<div class="chat-header">'
		           	+ '<a><img src="${pageContext.request.contextPath}/resources/img/testPicture.png" alt="item"></a>'
		           	+ '<div class="title">'+ room.title +' </div>'
		           	+ '<button class="item-button" onclick="location.href=' + '\'PayTransferRequest?product_id=' + product_id + '&receiver_id=' + receiver_id + '\'' + '">구매하기</button>'
		           + '</div>'
		           + '<div class="chat-body">'
		           + '</div>'
		           + '<div class="chat-footer">'
		           	+ '<input type="hidden" id="room_id" value="' + room.room_id +'">'
		           	+ '<input type="hidden" id="receiver_id" value="' + room.receiver_id +'">'
		           	+ '<input type="text" class="chatMessage" placeholder="메시지를 입력하세요...">'
		            + '<button class="btnSend">전송</button>'
		           + '</div>';
		           
	$(".chat-area").html(divRoom);
	
	
}



//	=========================채팅방 목록 작업 끝===========================

//	=========================메세지 보내기 작업 시작===========================


function sendInputMessage() {
	let message = $(".chatMessage").val();
	
	if(message == "") {
		return;
	}
	
	$(".chatMessage").val("");
	$(".chatMessage").focus();
	
}















//	===============================================================================
//	부모창의 sendMessage() 함수 호출
function sendMessage(type, product_id, sender_id, receiver_id, room_id, message) {
	opener.sendMessage(type, product_id, sender_id, receiver_id, room_id, message);
}


