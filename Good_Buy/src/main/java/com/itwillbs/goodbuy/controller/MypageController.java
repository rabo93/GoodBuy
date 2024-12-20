package com.itwillbs.goodbuy.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.goodbuy.aop.LoginCheck;
import com.itwillbs.goodbuy.aop.LoginCheck.MemberRole;
import com.itwillbs.goodbuy.service.MemberService;
import com.itwillbs.goodbuy.service.MyPageService;
import com.itwillbs.goodbuy.vo.MemberVO;
import com.itwillbs.goodbuy.vo.MyPageVO;
import com.itwillbs.goodbuy.vo.WishlistVO;

import lombok.extern.log4j.Log4j2;

//[회원정보 수정]
@Controller
public class MypageController {
	@Autowired MemberService memberService;
	@Autowired MyPageService myPageService;
	
	@GetMapping("MyInfo")
	public String myInfo() {
		return "mypage/mypage_info";
		
		// 로그인 인증처리
		
	}
	
	@PostMapping("MyInfo")
	public String myInfoForm(MemberVO member,HttpSession session , Model model) {
		System.out.println("member"+ member);
		MemberVO memInfo = memberService.getMember(member);
		System.out.println("?????"+memInfo);
		
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
	public String myWish(HttpSession session,Model model,HttpServletRequest request) {
		//로그인체크 필요
		String id = (String)session.getAttribute("sId");
		List<WishlistVO> wishlist = myPageService.getWishlist(id);
		
		System.out.println("위시리스트"+wishlist);
		
		return "mypage/mypage_wishlist";
	}

	@GetMapping("MemberWithdraw")
	public String memberWithdraw() {
		return "mypage/mypage_withdraw";
	}
	
	@PostMapping("MemberWithdraw")
	public String memberWithdrawForm (MemberVO  member,HttpSession session , Model model ,BCryptPasswordEncoder passwordEncoder,String memPasswd) {
		String id = (String)session.getAttribute("sId");
		String dbPasswd = memberService.getMemberPasswd(id);
		if(dbPasswd == null || !passwordEncoder.matches(memPasswd, dbPasswd)) {
			model.addAttribute("msg", "권한이 없습니다.//n비밀번호를 다시 확인해주세요.");
			return "result/fail";
		}
		
		
		return"";
	}

}
