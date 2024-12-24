package com.itwillbs.goodbuy.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	@PostMapping("AdmCommoncodeRegist")
	public String admCommoncodeRegist(
			@RequestParam("CODETYPE_ID") String codeTypeId,
            @RequestParam("CODETYPE_NAME") String codeTypeName,
            @RequestParam("DESCRIPTION") String description,
            @RequestParam("CODE_ID") List<String> codeIds,
            @RequestParam("CODE_NAME") List<String> codeNames,
            @RequestParam("CODE_DESCRIPTION") List<String> codeDescriptions,
            @RequestParam("CODE_STATUS") List<String> codeStatus,
            @RequestParam("CODE_SEQ") List<String> codeSeq,
            Model model, HttpSession session) {
		
//		log.info(">>>>>>>> codeStatus : " + codeStatus);
		
		List<Map<String, Object>> subCodes = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < codeIds.size(); i++) {
			Map<String, Object> subCode = new HashMap<String, Object>();
			subCode.put("CODE_ID", codeIds.get(i));
			subCode.put("CODE_NAME", codeNames.get(i));
			subCode.put("CODE_DESCRIPTION", codeDescriptions.get(i));
			subCode.put("CODE_STATUS", codeStatus.get(i).equals("on") ? 1 : 2);
			subCode.put("CODE_SEQ", codeSeq.get(i));
			subCode.put("CODETYPE_ID", codeTypeId);
			subCodes.add(subCode);
		}
		
		Map<String, String> mainCode = new HashMap<String, String>();
		mainCode.put("CODETYPE_ID", codeTypeId);
		mainCode.put("CODETYPE_NAME", codeTypeName);
		mainCode.put("DESCRIPTION", description);
		
		int insertCommonCode = service.registCommonCode(mainCode, subCodes);

		if(insertCommonCode > 0) {
			model.addAttribute("msg", "공통코드가 등록되었습니다.");
			model.addAttribute("targetURL", "AdmCommoncodeRegistForm");
			return "result/success";
		} else {
			model.addAttribute("msg", "공통코드 등록을 실패하였습니다.");
			return "result/fail";
		}
	}
	
	// 공통코드 관리 - 수정
	@GetMapping("AdmCommoncodeModify")
	public String admCommoncodeModify() {
		
		
		return "admin/code_modify";
	}
	
	// 공통코드 관리 - 목록
	@GetMapping("AdmCommoncodeList")
	public String admCommoncodeList() {
		return "admin/code_list";
	}
	
	
	// ======================================================
	// 회원 관리
	
	// 결제 관리
	
	// 신고 관리
	
	// 고객지원 관리
	
	// 광고 관리
	
	// 통계
	
}
