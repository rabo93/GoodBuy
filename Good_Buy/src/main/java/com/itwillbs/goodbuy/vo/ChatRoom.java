package com.itwillbs.goodbuy.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatRoom {
	private String room_id;
	private String sender_id;
	private String receiver_id;
}
