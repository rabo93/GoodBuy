package com.itwillbs.goodbuy.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ProductOrderVO {
	
	private int order_id;         // 주문 ID
    private int product_id;       // 상품 ID
    private String buyer_id;      // 구매자 ID
    private Date order_date; // 주문 날짜
    //===========================
    private String product_category;      
    private String product_status;      
    private String product_price;      
    private String product_title;      
    private String mem_nick;      
	

}
