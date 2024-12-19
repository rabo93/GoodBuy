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
}
