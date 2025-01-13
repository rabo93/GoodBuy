package com.itwillbs.goodbuy.controller;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.goodbuy.service.ProductService;

import lombok.extern.log4j.Log4j2;
@Log4j2
@Controller
public class MainController {
	@Autowired ProductService productService;
	
	@GetMapping("/")
	public String main(Model model) {
		List<Map<String, Object>> recommendedItem = productService.getRecommendedItem();
		model.addAttribute("recommeded", recommendedItem);
		return "index";
	}
}
