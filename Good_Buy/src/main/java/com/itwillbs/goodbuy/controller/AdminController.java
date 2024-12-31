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
import com.itwillbs.goodbuy.vo.FaqVO;
import com.itwillbs.goodbuy.vo.MemberVO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class AdminController {
	
	@Autowired
	private AdminService service;
	
	// [ 관리자 메인 ]
	// 관리자 메인
	@GetMapping("AdmMain")
	public String admMain() {
		return "admin/index";
	}
	// ======================================================
	// [ 공통코드 관리 ]
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
	
	// 공통코드 관리 - 요청
	@ResponseBody
	@PostMapping("AdmCommoncodeListForm")
	public String admCommoncodeListForm(@RequestParam Map<String, String> param) {	
//		log.info(">>>> param: " + param);
		int draw = Integer.parseInt((String) param.get("draw")); // 요청받은 draw 값
		int start = Integer.parseInt((String) param.get("start")); // 페이징 시작 번호
		int length = Integer.parseInt((String) param.get("length")); // 한 페이지의 컬럼 개수
		String searchValue = param.get("search[value]"); // 검색어
//		log.info("searchValue: " + searchValue);
		
		// 공통코드 전체 컬럼 수 조회
		int recordsTotal = service.getCommonCodesTotal();
		
		// 공통코드 검색 필터링 후 컬럼 수 조회
		int recordsFiltered = service.getCommonCodesFiltered(searchValue);
		
		// 공통코드 전체 목록 조회
		List<Map<String, Object>> commonCodes = service.getCommonCodes(start, length, searchValue);
		
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
	// [ 회원관리 ]
	// 회원 목록 - 뷰페이지 포워딩
	@GetMapping("AdmMemberList")
	public String admMemberList() {
		return "admin/member_list";
	}
	
	// 회원 목록 - 조회
	@ResponseBody
	@PostMapping("AdmMemberListForm")
	public String admMemberListForm(@RequestParam Map<String, Object> param) {
//		log.info(">>> param : " + param);
		int draw = Integer.parseInt((String) param.get("draw")); // 요청받은 draw 값
		int start = Integer.parseInt((String) param.get("start")); // 페이징 시작 번호
		int length = Integer.parseInt((String) param.get("length")); // 한 페이지의 컬럼 개수
		int memStatus = Integer.parseInt((String) param.get("mem_status")); // 검색어
		String memGrade = param.get("mem_grade").toString(); // 검색어
		String searchValue = (String)param.get("search_keyword").toString(); // 검색어
		
		// 정렬 추가(orderable)
		// 넘겨받은 데이터 : columns[2][data]=mem_name, order[0][column]=2, order[0][dir]=desc
		// 컬럼명 추출하려면 columns[order[0][column]][data] 형태로 만들어줘야 함
		int orderColumnKey = Integer.parseInt((String)param.get("order[0][column]"));
		String orderColumn = param.get("columns[" + orderColumnKey + "][data]").toString();
		String orderDir = param.get("order[0][dir]").toString();
//		System.out.println("orderColumn : " + orderColumn);
//		System.out.println("orderDir : " + orderDir);
		
		// 회원 목록 전체 컬럼 수 조회
		int recordsTotal = service.getMemberListTotal();
		
		// 회원 검색 필터링 후 컬럼 수 조회
		int recordsFiltered = service.getMemberListFiltered(memStatus, memGrade, searchValue);
		
		// 필터링 된 회원 목록 가져오기
		List<MemberVO> memberList = service.getMemberList(start, length, searchValue, memStatus, memGrade, orderColumn, orderDir);
//		log.info(">>>>> 필터링 된 회원 : " + memberList);
		
		// 데이터를 map 객체에 담아서 JSON 객체로 변환하여 전달
		Map<String, Object> response = new HashMap<String, Object>();
		
		// draw, recordsTotal, recordsFiltered 값을 돌려주어야 서버사이드 페이징 작동함
		response.put("draw", draw); // 받은 draw 값 그대로 다시 전달(보안)
		response.put("recordsTotal", recordsTotal); // 전체 컬럼 수
		response.put("recordsFiltered", recordsFiltered); // 검색 필터링 후 컬럼 수
		response.put("memberList", memberList); // 컬럼 데이터
		
		JSONObject jo = new JSONObject(response);
		
		return jo.toString();
	}
	
	// 회원 상세 정보 - 조회
	@GetMapping("AdmMemberDetailForm")
	public String admMemberDetailForm(String mem_id, Model model) {
		log.info(">>> 상세 회원 정보 ID : " + mem_id);
		
		MemberVO dbMember = service.getMember(mem_id);
		String memStatus = memberStatusToString(dbMember.getMem_status());
		String snsStatus = snsStatusToString(dbMember.getSns_status());
		String authStatus = memberAuthToString(dbMember.getAuth_status());
		
		model.addAttribute("dbMember", dbMember);
		model.addAttribute("memStatus", memStatus);
		model.addAttribute("snsStatus", snsStatus);
		model.addAttribute("authStatus", authStatus);
		
		return "admin/member_modify";
	}
	
	// 회원상태 문자열로 변환
	public String memberStatusToString(int status) {
		switch(status) {
			case 1 : return "정상";
			case 2 : return "정지";
			case 3 : return "탈퇴";
			default: return "정상";
		}
	}
	
	// SNS 연동상태 문자열로 변환
	public String snsStatusToString(int status) {
		switch(status) {
			case 1 : return "연동완료";
			case 2 : return "-";
			default: return "-";
		}
	}
	
	// 회원인증상태 문자열로 변환
	public String memberAuthToString(int status) {
		switch(status) {
			case 1 : return "인증완료";
			case 2 : return "-";
			default: return "-";
		}
	}
	
	// 회원 상세 정보 - 수정
	@PostMapping("AdmMemberModify")
	public String admMemberModify(MemberVO member, Model model) {
		log.info(">>> 수정할 회원 정보: " + member);
		
		int updateResult = service.modifyMemberInfo(member);
		
		if(updateResult > 0) {
			model.addAttribute("msg", "회원 상태를 수정하였습니다.");
			model.addAttribute("targetURL", "AdmMemberList");
			return "result/success";
		} else {
			model.addAttribute("msg", "회원 상태 수정에 실패하였습니다.");
			return "result/fail";
		}
	}
	
	// 회원 삭제
	@ResponseBody
	@PostMapping("AdmMemberDelete")
	public Map<String, Object> admMemberDelete(MemberVO member, Model model) {
		System.out.println(">>>>>>>>>>> 삭제할 회원: " + member);
		
		int deleteResult = service.removeMember(member.getMem_id());
		
		
		Map<String, Object> response = new HashMap<String, Object>();
		if(deleteResult > 0) {
			response.put("status", "success");
			response.put("message", "선택한 회원이 삭제되었습니다.");
			response.put("redirectURL", "/AdmMemberList");
		} else {
			response.put("status", "fail");
			response.put("message", "회원 삭제에 실패했습니다. 다시 시도해주세요.");
		}
		
		return response;
	}
	
	// [ 결제 관리 ]
	
	// [ 신고 관리 ]
	
	// ======================================================
	// [ 고객지원 관리 ]
	// - FAQ 관리
	@GetMapping("AdmFaqList")
	public String admFaqList() {
		return "admin/faq_list";
	}

	@ResponseBody
	@PostMapping("AdmFaqListForm")
	public String admFaqListForm(@RequestParam Map<String, Object> param) {
		log.info(">>> AdmFaqListForm param : " + param);
//		int draw = Integer.parseInt(param.get("draw")); // 요청받은 draw 값
//		int start = Integer.parseInt(param.get("start")); // 페이징 시작 번호
//		int length = Integer.parseInt(param.get("length")); // 한 페이지의 컬럼 개수
//		String searchValue = param.get("search[value]"); // 검색어
		
		List<FaqVO> faqList = service.getFaqList();
		System.out.println("faqList:" + faqList);
		
		JSONArray ja = new JSONArray(faqList);
		
		return ja.toString();
	}
	// ======================================================
	// [ 광고 관리 ]
	
	// 통계
	
}
