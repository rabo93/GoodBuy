package com.itwillbs.goodbuy.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatRoom {
	private String room_id;		//	방 번호
	private int product_id;		//	상품 번호
	private String title;		//	상품타이틀
	private String sender_id;	//	송신자
	private String receiver_id;	//	수신자
	private int status;			//	방 상태
}
