package com.itwillbs.goodbuy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class AdminController {
	
	@GetMapping("AdminMain")
	public String adminMain() {
		return "admin/index";
	}
	
	// 공통코드 관리
	@GetMapping("AdminCommoncodeList")
	public String adminCommoncodeList() {
		return "admin/code_list";
	}
	
	@GetMapping("AdminCommoncodeRegist")
	public String adminCommoncodeRegist() {
		return "admin/code_regist";
	}
	
	@GetMapping("AdminCommoncodeModify")
	public String adminCommoncodeModify() {
		return "admin/code_modify";
	}
	
	// 회원 관리
	
	// 결제 관리
	
	// 신고 관리
	
	// 고객지원 관리
	
	// 광고 관리
	
	// 통계
	
}
