package com.itwillbs.goodbuy.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.goodbuy.aop.LoginCheck;
import com.itwillbs.goodbuy.aop.LoginCheck.MemberRole;
import com.itwillbs.goodbuy.service.ChatService;
import com.itwillbs.goodbuy.vo.ChatMessage;
import com.itwillbs.goodbuy.vo.ChatRoom;

@Controller
public class ChatController {
	@Autowired
	private ChatService chatService;
	
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("ChatMain")
	public String chatMain(HttpSession session,Model model) {
		String sId = (String)session.getAttribute("sId");
		System.out.println("sId : " + sId);
		List<ChatRoom> chatRoom = chatService.selectChatRoomList(sId);
		System.out.println(chatRoom);
		model.addAttribute("chatRoomList", chatRoom);
		
		
		return "chat/chat_list";
	}
	
	@GetMapping("ChatStart")
	public String chatStart() {
		
		return "chat/chatting";
	}
	
	@ResponseBody
	@PostMapping("ChatRoomAjax")
	public ChatRoom chatRoomAjax(@RequestParam Map<String, String> map) {
		
		String sender_id = map.get("sender_id");
		String receiver_id = map.get("receiver_id");
		int product_id = Integer.parseInt(map.get("product_id"));
		ChatRoom chatRoom = chatService.selectChatRoom(sender_id, receiver_id, product_id);
		
		return chatRoom;
	}
	
	@ResponseBody
	@PostMapping("ChatListAjax")
	public List<ChatMessage> chatListAjax(@RequestParam Map<String, String> map) {
		ChatMessage chatMessage = new ChatMessage();
		chatMessage.setRoom_id(map.get("room_id"));
		System.out.println(chatMessage);
		List<ChatMessage> chatMessageList = chatService.selectChatMessage(chatMessage);
		
		
		return chatMessageList;
	}
	
	
}






















