package com.itwillbs.goodbuy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChatController {
	
	@GetMapping("ChatMain")
	public String chatMain() {
		
		return "chat/chat_list";
	}
}
