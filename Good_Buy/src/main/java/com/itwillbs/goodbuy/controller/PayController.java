package com.itwillbs.goodbuy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PayController {

	@GetMapping("GoodPay")
	public String goodPay() {
		return "pay/pay_list";
	}
	
	@GetMapping("MyAccount")
	public String myAccount() {
		return "pay/my_account";
	}
	
	// 사용자 인증 요청에 대한 콜백 처리
	@GetMapping("CallBack")
	public String callBack() {
		return "";
	}
}
