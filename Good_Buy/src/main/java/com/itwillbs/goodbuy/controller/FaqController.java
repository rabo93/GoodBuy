package com.itwillbs.goodbuy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.goodbuy.aop.LoginCheck;
import com.itwillbs.goodbuy.aop.LoginCheck.MemberRole;
import com.itwillbs.goodbuy.service.FaqService;
import com.itwillbs.goodbuy.vo.FaqVO;

@Controller
public class FaqController {

	@Autowired
	private FaqService service;
	
	//	FAQ 메인페이지
	@GetMapping("FaqMain")
	public String faqMain(Model model) {
		
		List<FaqVO> faqList = service.getFaqList();
		model.addAttribute("faqList", faqList);
		
		return "faq/faq";
	}
	
	//	FAQ 글쓰기 폼 이동
	@LoginCheck(memberRole = MemberRole.ADMIN)
	@GetMapping("FaqWrite")
	public String faqWriteForm() {
		return "faq/faq_write";
	}
	
	//	FAQ 글쓰기 비즈니스 로직
	@PostMapping("FaqWrite")
	public String faqWrite(FaqVO faq, Model model) {
//		System.out.println(faq);
		service.insertFaq(faq);
		
		return "redirect:/FaqMain";
	}
	
	
	
}
