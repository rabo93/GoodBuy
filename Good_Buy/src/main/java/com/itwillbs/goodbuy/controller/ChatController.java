package com.itwillbs.goodbuy.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.itwillbs.goodbuy.aop.LoginCheck;
import com.itwillbs.goodbuy.aop.LoginCheck.MemberRole;
import com.itwillbs.goodbuy.handler.FileHandler;
import com.itwillbs.goodbuy.service.ChatService;
import com.itwillbs.goodbuy.vo.ChatMessage;
import com.itwillbs.goodbuy.vo.ChatRoom;

@Controller
public class ChatController {
	@Autowired
	private ChatService chatService;
	@Autowired
	private FileHandler fileHandler;
	
	//	채팅 메인페이지 이동(팝업창)
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("ChatMain")
	public String chatMain(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		//	대화중인 채팅방 조회
		List<ChatRoom> chatRoom = chatService.selectChatRoomList(sId);
		//	최근 채팅메세지를 저장하기위한 List 객체 생성
		List<ChatMessage> chatMessage = new ArrayList<ChatMessage>();
		List<Integer> chatMessageCnt = new ArrayList<Integer>();
		for (ChatRoom chatRoomList : chatRoom) {
			//	최근 메세지 List 객체에 저장
			chatMessage.add(chatService.selectLastMessage(chatRoomList.getRoom_id()));
			chatMessageCnt.add(chatService.selectCountMessage(chatRoomList.getRoom_id(), sId));
		}
		model.addAttribute("chatRoomList", chatRoom);
		model.addAttribute("chatMessageList", chatMessage);
		model.addAttribute("chatMessageCnt", chatMessageCnt);
		
		return "chat/chat_list";
	}
	
	//	기존 채팅방 존재여부 판단
	@ResponseBody
	@PostMapping("ChatRoomAjax")
	public String chatRoomAjax(@RequestParam Map<String, String> map) {
		System.out.println(map);
		String sender_id = map.get("sender_id");
		String receiver_id = map.get("receiver_id");
		int product_id = Integer.parseInt(map.get("product_id"));
		ChatRoom chatRoom = chatService.selectChatRoom(sender_id, receiver_id, product_id);

		System.out.println("PayController에서 보낸 거 잘받나? : " + new Gson().toJson(chatRoom));
		
		return new Gson().toJson(chatRoom);
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
	
	//	채팅방에서 회원 신고 작업
	@ResponseBody
	@PostMapping("ChatReport")
	public String chatReport(@RequestParam Map<String, String> map) {
		System.out.println("넘어오는 map 확인 : " + map);
		String msg = "";
		//	전달받은 map을 통해 변수 저장 작업
		String reason = map.get("reason");
		String reporter_id = map.get("reporter_id");
		String reported_id = map.get("reported_id");
		int product_id = Integer.parseInt(map.get("product_id"));
		//	변수를 통해 room_id 가져오기
		String room_id = chatService.selectChatRoom(reporter_id, reported_id, product_id).getRoom_id();
		System.out.println(room_id);
		//	신고 접수 요청
		int result = chatService.insertChatReport(reporter_id, reported_id, reason, room_id);
		
		if(result > 0) {
			msg = "신고가 접수되었습니다.";
		} else {
			msg = "신고 접수에 실패했습니다.\n다시 시도해 주세요.";
		}
		
		return new Gson().toJson(msg);
	}
	
	@ResponseBody
	@PostMapping("ChatFileUpload")
	public String chatFileUpload(MultipartFile file, HttpSession session) {
		System.out.println("채팅 파일업로드 확인");
		System.out.println(file);
		Map<String, String> uploadResult = new HashMap<String, String>();
		
		if(!file.getContentType().startsWith("image/")) {
			uploadResult.put("result", "fail");
			uploadResult.put("msg", "이미지 파일만 업로드 가능합니다.");
		} else {
			String realPath = fileHandler.getRealPath(session, "/resources/upload/chat");
			System.out.println("realPath : " + realPath);
			
			String fileName = fileHandler.processDuplicateFileName(file.getOriginalFilename());
			System.out.println("fileName : " + fileName);
			
			String uploadFileName = fileHandler.completeUpload(file, realPath, fileName);
			System.out.println("uploadFileName : " + uploadFileName);
			
			if(!uploadFileName.equals("")) {
				String thumbnailFileName = fileHandler.createThumbnailImage(realPath, uploadFileName);
				System.out.println("thumbnailFileName : " + thumbnailFileName);
				
				uploadResult.put("fileName", uploadFileName);
				uploadResult.put("thumbnailFileName", thumbnailFileName);
			}
			
		}
		
		return new Gson().toJson(uploadResult);
	}

	
}






















