package com.itwillbs.goodbuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.goodbuy.vo.ChatMessage;
import com.itwillbs.goodbuy.vo.ChatRoom;
import com.itwillbs.goodbuy.vo.MemberVO;

@Mapper
public interface ChatMapper {
	//	기존 자신의 채팅방 목록 조회요청
	List<ChatRoom> selectChatRoomList(String sender_id);
	
	//	해당 채팅방 제일 마지막 대화 조회
	ChatMessage selectLastMessage(String room_id);
	
	//	기존의 상대방과의 채팅방 조회 요청
	ChatRoom selectChatRoom(@Param("sender_id") String sender_id,
							@Param("receiver_id") String receiver_id,
							@Param("product_id") int product_id);
	
	//	읽지않은 메세지 갯수 조회
	int selectCountMessage(@Param("room_id") String room_id,
						   @Param("receiver_id") String receiver_id);
	
	
	//	새 채팅방 정보 저장 요청
	void insertChatRoom(List<ChatRoom> chatRoomList);
	
	//	채팅 메세지 DB 저장 요청
	void insertChatMessage(ChatMessage chatMessage);
	
	//	기존 채팅 내역 조회
	List<ChatMessage> selectChatMessage(ChatMessage chatMessage);

	//	채팅방 회원 신고
	int insertChatReport(@Param("reporter_id") String reporter_id,
						 @Param("reported_id") String reported_id,
						 @Param("reason") String reason,
						 @Param("room_id") String room_id);
	
	//	product_id로 가격 알아오기
	int selectProductPrice(int product_id);

	//	mem_id로 mem_nick 가져오기
	MemberVO selectMemberNick(String receiver_id);

	//	메세지 읽음 처리
	void updateAllMessageRead(ChatMessage chatMessage);
	
	//	메세지 읽음 처리
	void updateMessageRead(ChatMessage chatMessage);
	
	//	상품 번호 가져오기
	int selectProductInfo(String room_id);
	
	//	채팅방 나갔을 때 채팅방 상태 변경
	void updateChatRoomState(@Param("room_id") String room_id,
							 @Param("sender_id") String sender_id);


	

	


}
