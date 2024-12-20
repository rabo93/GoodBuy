package com.itwillbs.goodbuy.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.goodbuy.service.PayService;
import com.itwillbs.goodbuy.vo.PayToken;

@Controller
public class PayController {

	@Autowired
	PayService service;
	
	
	@GetMapping("GoodPay")
	public String goodPay() {
		return "pay/pay_list";
	}
	
	@GetMapping("MyAccount")
	public String myAccount() {
		return "pay/my_account";
	}
	
	// 사용자 인증 요청에 대한 콜백 처리
	@GetMapping("Callback")
	public String callback(@RequestParam Map<String, Object> authResponse, HttpSession session, Model model) {
		// System.out.println("callback 잘되나? " + authResponse); 
		
		// 임시) 메인페이지에서 엑세스토큰 요청을 별도로 수행하기 위해 세션에 인증코드 저장		
		//session.setAttribute("code", authResponse.get("code"));
		
		// 토큰발급 API - 사용자 토큰발급 API (3-legged) 요청
		PayToken token = service.getAccessToken(authResponse);
		
		
		return "";
	}
}
