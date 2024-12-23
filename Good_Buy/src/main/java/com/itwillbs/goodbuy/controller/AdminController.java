package com.itwillbs.goodbuy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class AdminController {
	
	// 관리자 메인
	@GetMapping("AdmMain")
	public String admMain() {
		return "admin/index";
	}
	// ======================================================
	// 공통코드 관리 - 목록
	@GetMapping("AdmCommoncodeList")
	public String admCommoncodeList() {
		return "admin/code_list";
	}
	
	// 공통코드 관리 - 등록
	@GetMapping("AdmCommoncodeRegist")
	public String admCommoncodeRegist() {
		return "admin/code_regist";
	}
	
	// 공통코드 관리 - 수정
	@GetMapping("AdmCommoncodeModify")
	public String admCommoncodeModify() {
		return "admin/code_modify";
	}
	// ======================================================
	// 회원 관리
	
	// 결제 관리
	
	// 신고 관리
	
	// 고객지원 관리
	
	// 광고 관리
	
	// 통계
	
}
