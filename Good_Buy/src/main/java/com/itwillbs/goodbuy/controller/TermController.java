package com.itwillbs.goodbuy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.goodbuy.service.TermService;
import com.itwillbs.goodbuy.vo.TermVO;

@Controller
public class TermController {
	@Autowired
	private TermService service;
	
	@GetMapping("Term")
	public String term(Model model) {
		TermVO terms = service.getTerm("terms-of-service");
		model.addAttribute("content", terms.getContent());
		return "term/term";
	}
	
	@GetMapping("Policy")
	public String policy(Model model) {
		TermVO terms = service.getTerm("operation-policy");
		model.addAttribute("content", terms.getContent());
		return "term/policy";
	}
	
	@GetMapping("Privacy")
	public String privacy(Model model) {
		TermVO terms = service.getTerm("privacy-policy");
		model.addAttribute("content", terms.getContent());
		return "term/privacy";
	}
	
	
}
