package com.itwillbs.goodbuy.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.goodbuy.aop.LoginCheck;
import com.itwillbs.goodbuy.aop.LoginCheck.MemberRole;
import com.itwillbs.goodbuy.service.ChatService;
import com.itwillbs.goodbuy.vo.ChatRoom;

@Controller
public class ChatController {
	@Autowired
	private ChatService chatService;
	
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("ChatMain")
	public String chatMain(HttpSession session,Model model) {
//		String sId = (String)session.getAttribute("sId");
//		System.out.println("sId : " + sId);
//		List<ChatRoom> chatRoom = chatService.selectChatRoomList(sId);
//		System.out.println(chatRoom);
//		model.addAttribute("chatRoomList", chatRoom);
		
		
		return "chat/chat_list";
	}
	
	@GetMapping("ChatStart")
	public String chatStart() {
		
		return "chat/chatting";
	}
	
	
}
