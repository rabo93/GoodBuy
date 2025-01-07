package com.itwillbs.goodbuy.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ProductOrderVO {
	
	private int order_id;         // 주문 ID
    private int product_id;       // 상품 ID
//    private String buyer_id;      // 구매자 ID
    private Date order_date; 	// 주문 날짜
    //===========================
//    private String product_category;      
    private String product_status;      
//    private String product_price;      
//    private String product_title;      
    private String mem_nick;      
    private String product_trade_adr1;
    private int review_cnt;
    
    //===========================
    // 관리자 거래내역에 필요한 VO 작성 할게요! (중복되는거 나중에 합쳐요)
    private int pay_id;					// 거래ID
    private String seller_id;			// 판매자ID
//    private String product_id;			// 상품ID - FK TO PRODUCT
    private String product_category;	// 상품유형
    private String product_title;		// 상품명 - FK TO PRODUCT
    private int product_price;			// 상품가격 - FK TO PRODUCT
    private String buyer_id;			// 구매자ID
    private int pay_price;				// 구매가격
    private Date pay_date;				// 구매일시
    private String pay_address;			// 거래장소 - FK TO PRODUCT
    private int pay_status;				// 거래상태(0: 판매중 /1: 거래중 / 2 : 예약중 / 3: 거래완료 / 4: 신고처리)
    									// - FK TO PRODUCT
    
}
