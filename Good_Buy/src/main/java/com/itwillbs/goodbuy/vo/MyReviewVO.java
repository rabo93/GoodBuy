package com.itwillbs.goodbuy.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class MyReviewVO {
	    private String review_id;         // 리뷰 ID
	    private String mem_id;            // 회원 ID
	    private String mem_nick;            // 회원 닉네임
	    private String review_content;    // 리뷰 내용
	    private String product_title;     // 상품 제목
	    private int product_id;    // (구매한)상품ID
	    private Date review_date;		// 리뷰 날짜
	    private String review_score;      // 리뷰 점수
	    private String buyerNick;      // 구매자 NICK
	    private String sellerNick;      // 판매자 NICK
	    private String review_options ;      // 추가 리뷰 옵션
}
