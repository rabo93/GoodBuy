package com.itwillbs.goodbuy.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.goodbuy.service.AdminService;
import com.itwillbs.goodbuy.vo.CommonCodeVO;
import com.itwillbs.goodbuy.vo.MemberVO;

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
	public Map<String, Object> admCommoncodeRegist(@RequestBody CommonCodeVO commonCodes, Model model, HttpSession session) {
		Map<String, Object> mainCode = commonCodes.getMainCode();
		List<Map<String, Object>> subCodes = commonCodes.getSubCodes();
		
		log.info(">>> mainCode : " + mainCode);
		log.info(">>> subCodes : " + subCodes);
		
		int insertCommonCode = service.registCommonCode(mainCode, subCodes);
		
		Map<String, Object> response = new HashMap<String, Object>();
		if(insertCommonCode > 0) {
			response.put("status", "success");
			response.put("message", "공통코드가 등록되었습니다.");
			response.put("redirectURL", "/AdmCommoncodeRegistForm");
		} else {
			response.put("status", "fail");
			response.put("message", "공통코드 등록에 실패했습니다. 입력값을 확인하세요.");
		}
		return response;
	}
	
	// 공통코드 관리 - 목록
	@GetMapping("AdmCommoncodeList")
	public String admCommoncodeList() {
		return "admin/code_list";
	}
	
	@ResponseBody
	@PostMapping("AdmCommoncodeListForm")
	public String admCommoncodeListForm(@RequestParam Map<String, String> param) {	
//		log.info(">>>> param: " + param);
		int draw = Integer.parseInt(param.get("draw")); // 요청받은 draw 값
		int start = Integer.parseInt(param.get("start")); // 페이징 시작 번호
		int length = Integer.parseInt(param.get("length")); // 한 페이지의 컬럼 개수
		String searchValue = param.get("search[value]"); // 검색어
//		log.info("searchValue: " + searchValue);
		
		// 공통코드 전체 목록 조회
		List<Map<String, Object>> commonCodes = service.getCommonCodes(start, length, searchValue);
		// 공통코드 전체 컬럼 수 조회
		int recordsTotal = service.getCommonCodesTotal();
		// 공통코드 검색 필터링 후 컬럼 수 조회
		int recordsFiltered = service.getCommonCodesFiltered(searchValue);
		
		// 데이터를 map 객체에 담아서 JSON 객체로 변환하여 전달
		Map<String, Object> response = new HashMap<String, Object>();
		
		// draw, recordsTotal, recordsFiltered 값을 돌려주어야 서버사이드 페이징 작동함
		response.put("draw", draw); // 받은 draw 값 그대로 다시 전달(보안)
		response.put("recordsTotal", recordsTotal); // 전체 컬럼 수
		response.put("recordsFiltered", recordsFiltered); // 검색 필터링 후 컬럼 수
		response.put("commonCodes", commonCodes); // 컬럼 데이터
		
		JSONObject jo = new JSONObject(response);
		
		return jo.toString();
	}
	
	// 공통코드 관리 - 수정
	@PostMapping("AdmCommoncodeModify")
	public String admCommoncodeModify(@RequestParam Map<String, Object> param, Model model) {
		log.info(">>> param : " + param);
		
		int updateResult = service.modifyCommonCode(param);
		if(updateResult > 0) {
			model.addAttribute("msg", "선택한 공통코드가 수정되었습니다.");
			return "redirect:/AdmCommoncodeList";
		} else {
			model.addAttribute("msg", "공통코드 수정에 실패했습니다. 입력값을 확인하세요.");
			return "result/fail";
		}
		
	}
	
	// 공통코드 관리 - 삭제
	@ResponseBody
	@PostMapping("AdmDeleteCommonCode")
	public Map<String, Object> admCommoncodeDelete(@RequestParam Map<String, Object> param) {
//		log.info(">>> param : " + param);
		
		int deleteResult = service.removeCommonCode(param);
		
		Map<String, Object> response = new HashMap<String, Object>();
		
		if(deleteResult > 0) {
			response.put("status", "success");
			response.put("message", "선택한 공통코드가 삭제되었습니다.");
			response.put("redirectURL", "/AdmCommoncodeList");
		} else {
			response.put("status", "fail");
			response.put("message", "공통코드 삭제에 실패했습니다. 삭제할 데이터를 확인하세요.");
		}
		
		return response;
	}
	
	
	
	// ======================================================
	// 회원 관리
	@GetMapping("AdmMemberList")
	public String admMemberList() {
		return "admin/member_list";
	}
	
	@ResponseBody
	@PostMapping("AdmMemberListForm")
	public String admMemberListForm(@RequestParam Map<String, Object> param) {
//		log.info(">>> param : " + param);
//		int draw = Integer.parseInt(param.get("draw")); // 요청받은 draw 값
//		int start = Integer.parseInt(param.get("start")); // 페이징 시작 번호
//		int length = Integer.parseInt(param.get("length")); // 한 페이지의 컬럼 개수
//		String searchValue = param.get("search[value]"); // 검색어
		
		List<MemberVO> memberList = service.getMemberList();
		System.out.println(memberList);
		
		JSONArray ja = new JSONArray(memberList);
		
		return ja.toString();
	}
	
	@GetMapping("AdmMemberModify")
	public String admMemberModify(@RequestParam String mem_id, Model model) {
		log.info(">>> 수정할 회원 Id: " + mem_id);
		
		MemberVO dbMember = service.getMember(mem_id);
		
		model.addAttribute("dbMember", dbMember);
		
		return "admin/member_modify";
	}
	
	// 결제 관리
	
	// 신고 관리
	
	// 고객지원 관리
	
	// 광고 관리
	
	// 통계
	
}
