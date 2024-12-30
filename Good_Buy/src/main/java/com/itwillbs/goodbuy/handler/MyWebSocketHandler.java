package com.itwillbs.goodbuy.handler;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.itwillbs.goodbuy.service.ChatService;
import com.itwillbs.goodbuy.service.MemberService;
import com.itwillbs.goodbuy.vo.ChatMessage;

public class MyWebSocketHandler extends TextWebSocketHandler {
	//	접속한 클라이언트(사용자)들에 대한 정보를 저장할 용도의 Map 객체(userSessionList) 생성
	private Map<String, WebSocketSession> userSessionList = new ConcurrentHashMap<String, WebSocketSession>();
	// 접속한 클라이언트(사용자)들의 사용자 아이디(HttpSession)와 WebSocketSession 객체의 아이디를 관리할 용도의 Map 객체(userList) 생성
	private Map<String, String> userList = new ConcurrentHashMap<String, String>();
	//	JSON 데이터 파싱 작업을 처리할 Gson 객체 생성
	private final Gson gson = new Gson();
	//	==================================================================
	@Autowired
	private MemberService memberService;
	@Autowired
	private ChatService chatService;
	//	==================================================================
	// 1. afterConnectionEstablished - 웹소켓 최초 연결 시 자동으로 호출되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("웹소켓 연결됨!(afterConnectionEstablished)");
		userSessionList.put(session.getId(), session);
		userList.put(getHttpSessionId(session), getWebSocketSessionId(session));
		
//		System.out.println("클라이언트 세션 목록(" + userSessionList.keySet().size() + " 명) : " + userSessionList);
//		System.out.println("사용자 목록(" + userList.keySet().size() + " 명) : " + userList);
	}
	
	// 2. handleTextMessage - 클라이언트로부터 메세지를 수신할 경우 자동으로 호출되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//		System.out.println("메세지 수신됨!(handleTextMessage)");
//		System.out.println("메세지 전송한 사용자 : " + getHttpSessionId(session));
		
		String jsonMsg = message.getPayload();
//		System.out.println("전송된 메세지 : " + jsonMsg);
		
		ChatMessage chatMessage = gson.fromJson(jsonMsg, ChatMessage.class);
//		System.out.println("파싱된 메세지 : " + chatMessage);
		
		String sender_id = getHttpSessionId(session);
		String receiver_id = chatMessage.getReceiver_id();
//		System.out.println("송신자 아이디 : " + sender_id + ", 수신자 아이디 : " + receiver_id);
		sendMessage(session, chatMessage);
		
	}
	
	// 3. afterConnectionClosed - 웹소켓 연결 해제 시 자동으로 호출되는 메서드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("웹소켓 연결 해제됨!(afterConnectionClosed)");
		userSessionList.remove(session.getId());
		
		userList.put(getHttpSessionId(session), "");
//		System.out.println("클라이언트 세션 목록(" + userSessionList.keySet().size() + " 명) : " + userSessionList);
//		System.out.println("사용자 목록(" + userList.keySet().size() + " 명) : " + userList);
	}
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println("웹소켓 오류 발생!(handleTransportError)");
		
	}
	
	//	========================================================================
	//	HttpSession 객체에 저장된 세션 닉네임 리턴 메서드
	private String getHttpSessionId(WebSocketSession session) {
		return session.getAttributes().get("sNick").toString();
	}
	//	WebSocketSession 객체의 아이디 리턴 메서드
	private String getWebSocketSessionId(WebSocketSession session) {
		return session.getId();
	}
	//	각 웹소켓 세션들에게 메세지 전송 메서드
	public void sendMessage(WebSocketSession session, ChatMessage chatMessage) throws Exception {
		//	=========================================================
		//	1:1 채팅이 아닌 공통 채팅방
		String sender_id = getHttpSessionId(session);
		System.out.println("발신자 아이디 : " + sender_id);
		for (WebSocketSession ws : userSessionList.values()) {
			if(!ws.getId().equals(session.getId())) {
				if(chatMessage.getType().equals(ChatMessage.TYPE_ENTER)) {
					chatMessage.setMessage(">> " + sender_id + " 님이 입장하셨습니다 <<");
				}
				if (chatMessage.getType().equals(ChatMessage.TYPE_LEAVE)) {
					chatMessage.setMessage(">> " + sender_id + " 님이 퇴장하셨습니다 <<");
				}
				chatMessage.setSender_id(sender_id);
				
				ws.sendMessage(new TextMessage(toJson(chatMessage)));
				
			}
		}
		//	=========================================================
//		try {
//			session.sendMessage(new TextMessage(toJson(chatMessage)));
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
	}
	//	ChatMessage 객체 정보를 JSON 문자열로 변환 메서드
	public String toJson(ChatMessage chatMessage) {
		return gson.toJson(chatMessage);
	}
	
}








































