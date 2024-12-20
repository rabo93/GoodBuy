package com.itwillbs.goodbuy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;
@Log4j2
@Controller
public class MypageController {
	/*********회원정보 수정**********/
	
	@GetMapping("MyInfo")
	public String myInfo() {
		return "mypage/mypage_info";
		
		// 로그인 인증처리
		
	}
	
	@GetMapping("MyStore")
	public String myStore() {
		return "mypage/mypage_store";
	}

	@GetMapping("MyOrder")
	public String myOrder() {
		return "mypage/mypage_product_orders";
	}

	@GetMapping("MySales")
	public String mySale() {
		return "mypage/mypage_product_sales";
	}
	@GetMapping("MyReview")
	public String myReview() {
		return "mypage/mypage_review";
	}
	@GetMapping("MyWish")
	public String myWish() {
		return "mypage/mypage_wishlist";
	}
	@GetMapping("MemberWithdraw")
	public String memberWithdraw() {
		return "mypage/mypage_withdraw";
	}

}
