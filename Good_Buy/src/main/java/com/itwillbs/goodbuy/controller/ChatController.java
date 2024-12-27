package com.itwillbs.goodbuy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.goodbuy.aop.LoginCheck;
import com.itwillbs.goodbuy.aop.LoginCheck.MemberRole;

@Controller
public class ChatController {
	
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("ChatMain")
	public String chatMain() {
		
		return "chat/chat_list";
	}
}
