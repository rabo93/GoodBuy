package com.itwillbs.goodbuy.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ProductVO {
	private int product_id;
	private String product_title;
	private String mem_id;
	private String product_intro; //상품소개
	private int product_shpping_fee;
	private int product_price;
	private int product_discount_status;
	private String product_category;
	private Date product_reg_date; //상품등록일
	private String product_pic1;
	private String product_pic2;
	private String product_pic3;
	private String product_trade_adr1;
	private int advertisement_status; //광고상태
	private int product_status; //상품상태

}
