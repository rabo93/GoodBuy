package com.itwillbs.goodbuy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j2;
@Log4j2
@Controller
public class MainController {
	@GetMapping("/")
	public String main() {
		return "index";
	}

	@GetMapping("ProductList")
	public String productList() {
		return "product/product_list";
	}
	
	@GetMapping("ProductRegist")
	public String productRegist() {
		return "product/product_regi";
	}
	
	@GetMapping("AdmMain")
	public String admMain() {
		return "admin/adm_index";
	}
	
	@GetMapping("AdmCommonCode")
	public String admCommonCode() {
		return "admin/adm_commoncode";
	}
	
	
	
}
