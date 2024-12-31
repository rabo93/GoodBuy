package com.itwillbs.goodbuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.goodbuy.vo.ChatRoom;

@Mapper
public interface ChatMapper {
	//	기존 자신의 채팅방 목록 조회요청
	List<ChatRoom> selectChatRoomList(String sender_id);

	//	새 채팅방 정보 저장 요청
	void insertChatRoom(List<ChatRoom> chatRoomList);

}
