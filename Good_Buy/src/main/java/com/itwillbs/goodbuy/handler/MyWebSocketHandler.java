package com.itwillbs.goodbuy.handler;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.itwillbs.goodbuy.service.ChatService;
import com.itwillbs.goodbuy.service.MemberService;
import com.itwillbs.goodbuy.service.ProductService;
import com.itwillbs.goodbuy.vo.ChatMessage;
import com.itwillbs.goodbuy.vo.ChatRoom;
import com.itwillbs.goodbuy.vo.ProductVO;

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
	@Autowired
	private ProductService productService;
	//	==================================================================
	// 1. afterConnectionEstablished - 웹소켓 최초 연결 시 자동으로 호출되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("웹소켓 연결됨!(afterConnectionEstablished)");
		//	사용자의 WebSocketSession 객체를 Map 객체에 저장
		userSessionList.put(session.getId(), session);
		//	HttpSession 객체에 저장된 사용자 아이디와 WebSocketSession 객체의 아이디를 userList에 저장
		userList.put(getHttpSessionId(session), getWebSocketSessionId(session));
		
		System.out.println("클라이언트 세션 목록(" + userSessionList.keySet().size() + " 명) : " + userSessionList);
		System.out.println("사용자 목록(" + userList.keySet().size() + " 명) : " + userList);
	}
	
	// 2. handleTextMessage - 클라이언트로부터 메세지를 수신할 경우 자동으로 호출되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("메세지 수신됨!(handleTextMessage)");
		System.out.println("메세지 전송한 사용자 : " + getHttpSessionId(session));
		
		String jsonMsg = message.getPayload();
		System.out.println("전송된 메세지 : " + jsonMsg);
		ChatMessage chatMessage = gson.fromJson(jsonMsg, ChatMessage.class);
		System.out.println("파싱된 메세지(chatMessage) : " + chatMessage);
		//	----------------------------------------------------------------------
		String sender_id = getHttpSessionId(session);
		String receiver_id = chatMessage.getReceiver_id();
		System.out.println("송신자 아이디 : " + sender_id + ", 수신자 아이디 : " + receiver_id);
		//	=========================================================================
		if(chatMessage.getType().equals(ChatMessage.TYPE_INIT)) { // 채팅페에지 초기 진입메세지
			//	참여중인 채팅방 목록 조회
			List<ChatRoom> chatRoomList = chatService.selectChatRoomList(sender_id);
			//	조회결과 JSON 형식으로 변환
			chatMessage.setMessage(gson.toJson(chatRoomList.size() == 0 ? null : chatRoomList));
			//	초기화 정보 전송
			sendMessage(session, chatMessage);
		}
		
		if (chatMessage.getType().equals(ChatMessage.TYPE_INIT_COMPLETE)) {
			if(chatMessage.getProduct_id() != null) {
				System.out.println("!@#!@#");
				System.out.println("확인");
				//	상품 조회를 위한 product_id 파싱후 저장
				int product_id = Integer.parseInt(chatMessage.getProduct_id());
				//	수신자 아이디 포함 여부 판별
				if(receiver_id != null && !receiver_id.equals("")) {
					//	접속여부 판별(현재 접속중?)
					if(userList.get(receiver_id) == null) {
						//	접속중이 아닐 때 DB에 상대방 아이디 검색
						String dbReceiverId = memberService.selectMemberId(receiver_id);
						//	DB에서 상대방 아이디 존재 여부 판별
						if(dbReceiverId == null) {
							ChatMessage errorMessage = new ChatMessage(0, ChatMessage.TYPE_ERROR, "", sender_id, "", "존재하지 않는 사용자입니다!", "", "");
							sendMessage(session, errorMessage);
							return;
						}
					}	//	사용자 접속 여부 판별 끝
					
					ChatRoom chatRoom = chatService.selectChatRoom(sender_id, receiver_id, product_id);
					if(chatRoom == null) {	// 기존 채팅방 없음
						System.out.println("새 채팅방 생성");
						
						String title = productService.productSearch(product_id).getProduct_title();
						System.out.println(title);
						//	새 채팅방 방번호 생성
						chatMessage.setRoom_id(generateRoomID());
						
						//	새 채팅방 정보 DB 저장 요청
						List<ChatRoom> chatRoomList = new ArrayList<ChatRoom>();
						//	room_id, product_id, title, sender_id, receiver_id, status
						chatRoomList.add(new ChatRoom(chatMessage.getRoom_id(), product_id, title, sender_id, receiver_id, 1, "buyer"));
						chatRoomList.add(new ChatRoom(chatMessage.getRoom_id(), product_id, title, receiver_id, sender_id, 1, "seller"));
						//	DB에 채팅방 저장 요청
						chatService.insertChatRoom(chatRoomList);
						
						//	메세지 타입 TYPE_START 지정
						chatMessage.setType(ChatMessage.TYPE_START);
						//	채팅방 정보 저장
						chatRoom = chatRoomList.get(0);
						//	채팅 메세지 JSON 문자열로 변환하여 저장
						chatMessage.setMessage(gson.toJson(chatRoom));
						//	메세지 전송
						sendMessage(session, chatMessage);
					} else {
						chatMessage.setRoom_id(chatRoom.getRoom_id());
						chatMessage.setType(ChatMessage.TYPE_START);
						chatMessage.setMessage(gson.toJson(chatRoom));
						
						sendMessage(session, chatMessage);
					}
					
				}
				
			}
			
		}
		if (chatMessage.getType().equals(ChatMessage.TYPE_REQUEST_CHAT_LIST)) {
			//	기존 채팅 내역 조회
			List<ChatMessage> chatMessageList = chatService.selectChatMessage(chatMessage);
			//	기존 채팅 내역이 존재할 경우만 클라이언트에게 전송
			if (chatMessageList != null && chatMessageList.size() > 0) {
				chatMessage.setMessage(gson.toJson(chatMessageList));
				sendMessage(session, chatMessage);
			}
			
		}
		if (chatMessage.getType().equals(ChatMessage.TYPE_TALK)) {
			//	현재 시스템 날짜 시각정보 받아와서 저장
			chatMessage.setSend_time(getDateTimeNow());
			//	채팅 메세지 DB 저장 요청
			chatService.insertChatMessage(chatMessage);
			
			System.out.println("TALK 일 떄 저장 후 : " + chatMessage);
			
			if (userList.get(receiver_id) != null) { //	접속중일 경우
				WebSocketSession receiver_session = userSessionList.get(userList.get(receiver_id));
				sendMessage(receiver_session, chatMessage);
			}
			
			sendMessage(session, chatMessage);
			
		}
		if (chatMessage.getType().equals(ChatMessage.TYPE_REQUEST_PAY)) {
			//	현재 시스템 날짜 시각정보 받아와서 저장
			chatMessage.setSend_time(getDateTimeNow());
			//	채팅 메세지 DB 저장 요청
			chatService.insertChatMessage(chatMessage);
			
			if (userList.get(receiver_id) != null) { //	접속중일 경우
				WebSocketSession receiver_session = userSessionList.get(userList.get(receiver_id));
				sendMessage(receiver_session, chatMessage);
			}
			
			sendMessage(session, chatMessage);
			
		}
		if (chatMessage.getType().equals(ChatMessage.TYPE_RESPONSE_PAY)) {
			//	현재 시스템 날짜 시각정보 받아와서 저장
			chatMessage.setSend_time(getDateTimeNow());
			//	채팅 메세지 DB 저장 요청
			chatService.insertChatMessage(chatMessage);
			
			if (userList.get(receiver_id) != null) { //	접속중일 경우
				WebSocketSession receiver_session = userSessionList.get(userList.get(receiver_id));
				sendMessage(receiver_session, chatMessage);
			}
			
			sendMessage(session, chatMessage);
			
		}
		if (chatMessage.getType().equals(ChatMessage.TYPE_FILE_UPLOAD_COMPLETE)) {
			//	현재 시스템 날짜 시각정보 받아와서 저장
			chatMessage.setType(ChatMessage.TYPE_FILE);
			chatMessage.setSend_time(getDateTimeNow());
			//	채팅 메세지 DB 저장 요청
			chatService.insertChatMessage(chatMessage);
			
			if (userList.get(receiver_id) != null) { //	접속중일 경우
				WebSocketSession receiver_session = userSessionList.get(userList.get(receiver_id));
				sendMessage(receiver_session, chatMessage);
			}
			
			sendMessage(session, chatMessage);
		}
		
		if(chatMessage.getType().equals(ChatMessage.TYPE_READ)) {
			chatService.updateMessageRead(chatMessage);
		}
		
		if(chatMessage.getType().equals(ChatMessage.TYPE_RESERVATION)) {
			//	현재 시스템 날짜 시각정보 받아와서 저장
			chatMessage.setSend_time(getDateTimeNow());
			//	채팅 메세지 DB 저장 요청
			chatService.insertChatMessage(chatMessage);
			
			if (userList.get(receiver_id) != null) { //	접속중일 경우
				WebSocketSession receiver_session = userSessionList.get(userList.get(receiver_id));
				sendMessage(receiver_session, chatMessage);
			}
			
			sendMessage(session, chatMessage);
		}
		
		if(chatMessage.getType().equals(ChatMessage.TYPE_ACCEPT_RESERVATION)) {
			//	현재 시스템 날짜 시각정보 받아와서 저장
			chatMessage.setSend_time(getDateTimeNow());
			//	채팅 메세지 DB 저장 요청
			chatService.insertChatMessage(chatMessage);
			
			if (userList.get(receiver_id) != null) { //	접속중일 경우
				WebSocketSession receiver_session = userSessionList.get(userList.get(receiver_id));
				sendMessage(receiver_session, chatMessage);
			}
			
			sendMessage(session, chatMessage);
		}
		
		if(chatMessage.getType().equals(ChatMessage.TYPE_CANCEL_RESERVATION)) {
			//	현재 시스템 날짜 시각정보 받아와서 저장
			chatMessage.setSend_time(getDateTimeNow());
			//	채팅 메세지 DB 저장 요청
			chatService.insertChatMessage(chatMessage);
			
			if (userList.get(receiver_id) != null) { //	접속중일 경우
				WebSocketSession receiver_session = userSessionList.get(userList.get(receiver_id));
				sendMessage(receiver_session, chatMessage);
			}
			
			sendMessage(session, chatMessage);
		}
		
	}
	
	// 3. afterConnectionClosed - 웹소켓 연결 해제 시 자동으로 호출되는 메서드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("웹소켓 연결 해제됨!(afterConnectionClosed)");
		userSessionList.remove(session.getId());
		
		userList.remove(getHttpSessionId(session));
	}
	
	// 4. handleTransportError - 웹소켓 통신 과정에서 오류 발생 시 자동으로 호출되는 메서드
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println("웹소켓 오류 발생!(handleTransportError)");
		
	}
	
	//	========================================================================
	//	========================================================================
	//	========================================================================
	//	========================================================================
	//	========================================================================
	//	========================================================================
	//	각 웹소켓 세션들에게 메세지 전송 메서드
	public void sendMessage(WebSocketSession session, ChatMessage chatMessage) {
		//	=========================================================
		//	1:1 채팅이 아닌 공통 채팅방
		String sender_id = getHttpSessionId(session);
		System.out.println("발신자 아이디 : " + sender_id);
		try {
			session.sendMessage(new TextMessage(toJson(chatMessage)));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//	ChatMessage 객체 정보를 JSON 문자열로 변환 메서드
	private String toJson(ChatMessage chatMessage) {
		return gson.toJson(chatMessage);
	}
	
	//	HttpSession 객체에 저장된 세션 닉네임 리턴 메서드
	private String getHttpSessionId(WebSocketSession session) {
		return session.getAttributes().get("sId").toString();
	}
	//	WebSocketSession 객체의 아이디 리턴 메서드
	private String getWebSocketSessionId(WebSocketSession session) {
		return session.getId();
	}
	//	채팅방 번호값 생성 메서드
	private String generateRoomID() {
		return UUID.randomUUID().toString();
	}
	//	현재 시스템의 날짜 및 시각 정보 리턴
	private String getDateTimeNow() {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		return LocalDateTime.now().format(dtf);
	}
	
	
}








































