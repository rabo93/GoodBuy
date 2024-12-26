let ws;

$(function() {
	connect();
})

function connect() {
//	let ws_base_url = "ws://itwillbs.com";
	let ws_base_url = "ws://localhost:8081";
	ws = new WebSocket(ws_base_url + "/echo");
	
	ws.onopen = onOpen;
	ws.onmessage = onMessage;
	ws.onclose = onClose;
	ws.onerror = onError;
}

function onOpen () {
	console.log("onOpen()");
}

function onMessage() {
	console.log("onMessage()");
}

function onClose() {
	console.log("onClose()");
}

function onError() {
	console.log("onError()");
}












