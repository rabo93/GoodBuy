package com.itwillbs.goodbuy.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.goodbuy.aop.LoginCheck;
import com.itwillbs.goodbuy.aop.LoginCheck.MemberRole;
import com.itwillbs.goodbuy.service.MemberService;
import com.itwillbs.goodbuy.vo.MemberVO;

//[회원정보 수정]
@Controller
public class MypageController {
	@Autowired MemberService memberService;
	
	@GetMapping("MyInfo")
	public String myInfo() {
		return "mypage/mypage_info";
		
		// 로그인 인증처리
		
	}
	
	@PostMapping("MyInfo")
	public String myInfoForm(MemberVO member,HttpSession session , Model model) {
		System.out.println("member"+member);
		MemberVO memInfo = memberService.getMember(member);
		System.out.println(memInfo);
		
		
		return "mypage/mypage_info";
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
