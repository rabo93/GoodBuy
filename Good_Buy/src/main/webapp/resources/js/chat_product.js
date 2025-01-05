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


//var sId;
$(function() {
	sId = $("#sId").val();
	console.log(sId);
	
})


function showSlideChat(receiver_id, product_id) {
	//	슬라이드 메뉴를 열 때
	console.log(sId);
	console.log("receiver_id : " + receiver_id);
	console.log("product_id : " + product_id);
	sendMessage(TYPE_INIT_COMPLETE, product_id, "", receiver_id, "", "");
	
	//	슬라이드로 보이기
	$('.chat-container').addClass('open');
}

function closeSlideChat() {
	// 슬라이드 메뉴를 닫을 때
	$('.chat-container').removeClass('open');
}

