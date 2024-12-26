package com.itwillbs.goodbuy.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.goodbuy.service.AdminService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class AdminController {
	
	@Autowired
	private AdminService service;
	
	// 관리자 메인
	@GetMapping("AdmMain")
	public String admMain() {
		return "admin/index";
	}
	// ======================================================
	// 공통코드 관리 - 등록 폼 요청
	@GetMapping("AdmCommoncodeRegistForm")
	public String admCommoncodeRegistForm() {
		return "admin/code_regist";
	}
	
	// 공통코드 관리 - 등록
	@ResponseBody
	@PostMapping("AdmCommoncodeRegist")
	public String admCommoncodeRegist(@RequestBody Map<String, Object> dataMap, Model model, HttpSession session) {
		log.info(">>>>>>>> formData : " + dataMap); 
		
		int insertCommonCode = service.registCommonCode(dataMap);
		
		if(insertCommonCode > 0) {
			model.addAttribute("msg", "공통코드가 등록되었습니다.");
			model.addAttribute("targetURL", "AdmCommoncodeRegistForm");
			return "result/success";
		} else {
			model.addAttribute("msg", "공통코드 등록을 실패하였습니다.");
			return "result/fail";
		}
	}
	
	// 공통코드 관리 - 목록
	@GetMapping("AdmCommoncodeList")
	public String admCommoncodeList() {
		
		return "admin/code_list";
	}
	
	@ResponseBody
	@PostMapping("AdmCommoncodeListForm")
	public String admCommoncodeListForm(
			@RequestParam("draw") int draw,
			@RequestParam("start") int start,
			@RequestParam("length") int length,
			@RequestParam(value = "search[value]", defaultValue = "") String searchValue) {
		System.out.println("draw : " + draw); // 서버사이드 페이징 - 테이블이 순차적으로 그려지는 것을 보장하기 위해 사용
		System.out.println("start : " + start); // 서버사이드 페이징 첫번째 레코드 번호
		System.out.println("length : " + length); // 현재 페이지에 그려질 레코드 수
		System.out.println("searchValue : " + searchValue); // 검색어
		
		// 
		List<Map<String, Object>> commonCodes = service.getCommonCodes(start, length, searchValue);
		
		
//		Map<String, Object> paging = new HashMap<String, Object>();
//		paging.put("draw", draw);
//		paging.put("recordsTotal", commonCodes.size());
//		paging.put("recordsFiltered", commonCodes.size());
//		commonCodes.add(paging);
		
		JSONArray jArr = new JSONArray(commonCodes);
		log.info(">>> 공통코드 목록(JSON) : " + jArr);
		
		return jArr.toString();
//		return "";
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
