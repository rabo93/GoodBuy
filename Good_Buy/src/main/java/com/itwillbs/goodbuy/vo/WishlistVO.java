package com.itwillbs.goodbuy.vo;

import lombok.Data;

@Data
public class WishlistVO {

	 private int wishlist_id;      // 위시리스트 ID
	 private String product_title; // 상품 제목
	 private String product_id; 	// 상품 번호
	 private String mem_id;        // 회원 ID
	 private String product_price;
	 private String seller_nickname;
	 private String product_category;
	 private String product_trade_adr1;
	 
	 
	
}
