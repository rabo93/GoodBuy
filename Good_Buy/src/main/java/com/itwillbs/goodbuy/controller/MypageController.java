package com.itwillbs.goodbuy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {
	
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
//	@GetMapping("MyInfo")
//	public String myInfo() {
//		return "mypage/mypage_info";
//	}
//	
//	@GetMapping("MyStore")
//	public String myStore() {
//		return "mypage/mypage_store";
//	}
//
//	@GetMapping("MyOrder")
//	public String myOrder() {
//		return "mypage/mypage_product_orders";
//	}
//
//	@GetMapping("MySales")
//	public String mySale() {
//		return "mypage/mypage_product_sales";
//	}
//	@GetMapping("MyReview")
//	public String myReview() {
//		return "mypage/mypage_review";
//	}
//	@GetMapping("MyWish")
//	public String myWish() {
//		return "mypage/mypage_wishlist";
//	}
	@GetMapping("MemberWithdraw")
	public String memberWithdraw() {
		return "mypage/mypage_withdraw";
	}

//	@GetMapping("MyInfo")
//	public String myInfo() {
//		return "mypage/mypage_info";
//	}
//	
//	@GetMapping("MyStore")
//	public String myStore() {
//		return "mypage/mypage_store";
//	}
//
//	@GetMapping("MyOrder")
//	public String myOrder() {
//		return "mypage/mypage_product_orders";
//	}
//
//	@GetMapping("MySales")
//	public String mySale() {
//		return "mypage/mypage_product_sales";
//	}
//	@GetMapping("MyReview")
//	public String myReview() {
//		return "mypage/mypage_review";
//	}
//	@GetMapping("MyWish")
//	public String myWish() {
//		return "mypage/mypage_wishlist";
//	}


}
