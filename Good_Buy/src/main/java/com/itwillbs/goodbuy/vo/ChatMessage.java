package com.itwillbs.goodbuy.vo;

import org.springframework.web.socket.WebSocketSession;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatMessage {
	private String type;
	private String sender_id;
	private String receiver_id;
	private String room_id;
	private String message;
	private String send_time;
	private String product_id;
	
	public static final String TYPE_ENTER = "ENTER";
	public static final String TYPE_LEAVE = "LEAVE";
	public static final String TYPE_TALK = "TALK";
	public static final String TYPE_INIT = "INIT";
	public static final String TYPE_INIT_COMPLETE = "INIT_COMPLETE";
	public static final String TYPE_ERROR = "ERROR";
	public static final String TYPE_START = "START";
	public static final String TYPE_REQUEST_CHAT_LIST = "REQUEST_CHAT_LIST";
	public static final String TYPE_FILE_UPLOAD_COMPLETE = "FILE_UPLOAD_COMPLETE";
	public static final String TYPE_FILE = "FILE";
	public static final String TYPE_READ = "READ";
	public static final String TYPE_REQUEST_PAY = "REQUEST_PAY";
	public static final String TYPE_RESERVATION = "RESERVATION";
	public static final String TYPE_ACCEPT_RESERVATION = "ACCEPT_RESERVATION";
	public static final String TYPE_CANCEL_RESERVATION = "CANCEL_RESERVATION";
	public static final String TYPE_RESPONSE_PAY = "RESPONSE_PAY";
	
}
