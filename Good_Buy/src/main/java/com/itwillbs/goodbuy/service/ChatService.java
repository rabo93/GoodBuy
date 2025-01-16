package com.itwillbs.goodbuy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.mapper.ChatMapper;
import com.itwillbs.goodbuy.mapper.ProductMapper;
import com.itwillbs.goodbuy.vo.ChatMessage;
import com.itwillbs.goodbuy.vo.ChatRoom;
import com.itwillbs.goodbuy.vo.MemberVO;
import com.itwillbs.goodbuy.vo.ProductVO;

@Service
public class ChatService {
	@Autowired
	private ChatMapper mapper;
	@Autowired
	private ProductMapper proMapper;
	
	//	기존 자신의 채팅방 목록 조회 요청
	public List<ChatRoom> selectChatRoomList(String sender_id) {
		return mapper.selectChatRoomList(sender_id);
	}
	
	//	해당 채팅방 제일 마지막 대화 조회
	public ChatMessage selectLastMessage(String room_id) {
		ChatMessage chatMessage = mapper.selectLastMessage(room_id);
		
		switch (chatMessage.getType()) {
		case "FILE": chatMessage.setMessage("사진을 보냈습니다"); break;
		case "REQUEST_PAY": chatMessage.setMessage(chatMessage.getMessage() + "원을 요청했어요"); break;
		case "RESPONSE_PAY": chatMessage.setMessage(chatMessage.getMessage() + "원을 송금했어요"); break;
		case "RESERVATION": chatMessage.setMessage("상품 예약 " + chatMessage.getMessage() + "을 요청했어요"); break;
		case "ACCEPT_RESERVATION": chatMessage.setMessage("상품 예약을 " + chatMessage.getMessage() + "했어요"); break;
		}
		
		return chatMessage;
	}
	
	//	읽지 않은 메세지 갯수 조회
	public int selectCountMessage(String room_id, String receiver_id) {
		return mapper.selectCountMessage(room_id, receiver_id);
	}
	
	//	기존의 상대방과의 채팅방 조회 요청
	public ChatRoom selectChatRoom(String sender_id, String receiver_id, int product_id) {
		ChatRoom chatRoom = mapper.selectChatRoom(sender_id, receiver_id, product_id);
		return chatRoom;
	}
	
	//	새 채팅방 정보 저장 요청
	public void insertChatRoom(List<ChatRoom> chatRoomList) {
		mapper.insertChatRoom(chatRoomList);
	}
	
	//	채팅 메세지 DB 저장 요청
	public void insertChatMessage(ChatMessage chatMessage) {
		int state;
		mapper.insertChatMessage(chatMessage);
		
		switch (chatMessage.getType()) {
		case "ACCEPT_RESERVATION": state = 2;proMapper.updateChatProductStatus(chatMessage.getProduct_id(), state);break;
		case "CANCEL_RESERVATION": state = 0;proMapper.updateChatProductStatus(chatMessage.getProduct_id(), state);break;
		case "RESPONSE_PAY": state = 1;proMapper.updateChatProductStatus(chatMessage.getProduct_id(), state);break;
		case "LEAVE" : mapper.updateChatRoomState(chatMessage.getRoom_id(), chatMessage.getSender_id());
		}
		
	}
	
	//	기존 채팅 내역 조회
	public List<ChatMessage> selectChatMessage(ChatMessage chatMessage) {
		List<ChatMessage> chatMessageList = mapper.selectChatMessage(chatMessage);
		
		//	채팅 내역이 존재할 때 모든 메세지 읽음 처리
		if(chatMessageList != null && chatMessageList.size() > 0) {
			mapper.updateAllMessageRead(chatMessage);
		}
		
		return chatMessageList;
	}

	//	채팅방 회원 신고
	public int insertChatReport(String reporter_id, String reported_id, String reason, String room_id) {
		return mapper.insertChatReport(reporter_id, reported_id, reason, room_id);
	}
	
	//	상품 가격 알아오기
	public int selectProductPrice(int product_id) {
		return mapper.selectProductPrice(product_id);
	}
	
	//	멤버 정보 가져오기
	public MemberVO selectMemberNick(String receiver_id) {
		return mapper.selectMemberNick(receiver_id);
	}

	//	메세지 읽음 처리
	public void updateMessageRead(ChatMessage chatMessage) {
		mapper.updateMessageRead(chatMessage);
	}

	//	상품 사진 가져오기
	public ProductVO selectProductImg(String room_id) {
		int product_id = mapper.selectProductInfo(room_id);
		ProductVO product = proMapper.getProductPic(product_id);
		return product;
	}
	
	

	

	

}
