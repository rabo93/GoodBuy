package com.itwillbs.goodbuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.goodbuy.vo.ChatMessage;
import com.itwillbs.goodbuy.vo.ChatRoom;

@Mapper
public interface ChatMapper {
	//	기존 자신의 채팅방 목록 조회요청
	List<ChatRoom> selectChatRoomList(String sender_id);

	//	기존의 상대방과의 채팅방 조회 요청
	ChatRoom selectChatRoom(@Param("sender_id") String sender_id,
							@Param("receiver_id") String receiver_id,
							@Param("product_id") int product_id);
	
	//	새 채팅방 정보 저장 요청
	void insertChatRoom(List<ChatRoom> chatRoomList);
	
	//	채팅 메세지 DB 저장 요청
	void insertChatMessage(ChatMessage chatMessage);
	
	//	기존 채팅 내역 조회
	List<ChatMessage> selectChatMessage(ChatMessage chatMessage);


}
