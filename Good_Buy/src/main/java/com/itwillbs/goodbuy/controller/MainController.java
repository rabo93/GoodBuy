package com.itwillbs.goodbuy.controller;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.goodbuy.service.ChatService;
import com.itwillbs.goodbuy.service.ProductService;

import lombok.extern.log4j.Log4j2;
@Log4j2
@Controller
public class MainController {
	@Autowired ProductService productService;
	@Autowired ChatService chatService;
	
	@GetMapping("/")
	public String main(Model model, HttpSession session) {
		String sId = (String)session.getAttribute("sId");
		
		List<Map<String, Object>> recommendedItem = productService.getRecommendedItem();
		model.addAttribute("recommeded", recommendedItem);
		return "index";
	}
	
	@ResponseBody
	@GetMapping("MainProduct")
	public List<Map<String, Object>> mainProduct(Model model) {
		List<Map<String, Object>> recommendedItem = productService.getRecommendedItem();
		model.addAttribute("recommeded", recommendedItem);
		return recommendedItem;
	}
}
