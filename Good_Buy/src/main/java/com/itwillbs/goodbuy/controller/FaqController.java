package com.itwillbs.goodbuy.controller;

import java.util.ArrayList;
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
		List<FaqVO> faqList1 = new ArrayList<FaqVO>();
		List<FaqVO> faqList2 = new ArrayList<FaqVO>();
		List<FaqVO> faqList3 = new ArrayList<FaqVO>();
		List<FaqVO> faqList4 = new ArrayList<FaqVO>();
		List<FaqVO> faqList5 = new ArrayList<FaqVO>();
		
		for(FaqVO faq : faqList) {
			switch (faq.getFaq_cate()) {
			case 1: faqList1.add(faq); break;
			case 2: faqList2.add(faq); break;
			case 3: faqList3.add(faq); break;
			case 4: faqList4.add(faq); break;
			case 5: faqList5.add(faq); break;
			}
		}
		
		model.addAttribute("faqList1", faqList1);
		model.addAttribute("faqList2", faqList2);
		model.addAttribute("faqList3", faqList3);
		model.addAttribute("faqList4", faqList4);
		model.addAttribute("faqList5", faqList5);
		
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
		service.insertFaq(faq);
		
		return "redirect:/FaqMain";
	}
	
}
