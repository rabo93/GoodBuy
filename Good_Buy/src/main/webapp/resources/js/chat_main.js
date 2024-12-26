$(function() {
	let wsCheckInterval = setInterval(() => {
		if (ws != null && ws != undefined && ws.readyState == ws.OPEN) {
			console.log("웹소켓 연결 완료!");
			
			startChat();
			
			clearInterval(wsCheckInterval);
			
		}
	}, 1000);
	
	$(".btnSend").on("click", function() {
		sendInputMessage();
	});
	
	$(".chatMessage").on("keypress", function(event) {
//		console.log(event);
		let keyCode = event.keyCode;
		if (keyCode == 13) {
			sendInputMessage();
		}
	});
	
});

function startChat() {
	let urlParams = new URL(location.href).searchParams;
	
	let receiver_id = urlParams.get("receiver_id") == null ? "" : urlParams.get("receiver_id");
	
	sendMessage(TYPE_INIT, "", receiver_id, "", "");
	
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














