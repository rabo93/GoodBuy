package com.itwillbs.goodbuy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {
	
	@GetMapping("MyInfo")
	public String myInfo() {
		return "";
	}

}
