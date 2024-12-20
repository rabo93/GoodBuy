package com.itwillbs.goodbuy.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.goodbuy.aop.LoginCheck;
import com.itwillbs.goodbuy.aop.LoginCheck.MemberRole;
import com.itwillbs.goodbuy.service.PayService;
import com.itwillbs.goodbuy.vo.PayToken;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class PayController {

	@Autowired
	PayService service;
	
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("GoodPay")
	public String goodPay() {
		
		return "pay/pay_list";
	}
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("MyAccount")
	public String myAccount(HttpSession session, Model model) {
		// 엑세스토큰 관련 정보가 저장된 BankToken 객체(token)를 세션에서 꺼내기
		PayToken token = (PayToken)session.getAttribute("token");
		System.out.println("토큰 정보 : " + token);
		
		if(token == null || token.getAccess_token() == null) {
			model.addAttribute("msg", "계좌 인증 필수!");
			model.addAttribute("targetURL", "BankMain");
			return "result/fail";
		}
		
		// BankService - getBankUserInfo() 메서드 호출하여 핀테크 사용자 정보 조회
		Map<String, Object> bankUserInfo = service.getPayUserInfo(token);
		log.info(">>>>> 핀테크 사용자 정보 : " + bankUserInfo);
		
		// API 응답코드(rsp_code)가 "A0000" 이 아닐 경우 요청 처리 실패
		if(!bankUserInfo.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", bankUserInfo.get("rsp_message"));
			return "result/fail";
		}

		model.addAttribute("bankUserInfo", bankUserInfo);
		return "pay/my_account";
	}
	
	// 사용자 인증 요청에 대한 콜백 처리
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("Callback")
	public String callback(@RequestParam Map<String, String> authResponse, HttpSession session, Model model) {
		// System.out.println("callback 잘되나? " + authResponse); 
		
		// 임시) 메인페이지에서 엑세스토큰 요청을 별도로 수행하기 위해 세션에 인증코드 저장		
		session.setAttribute("code", authResponse.get("code"));
		
		// 토큰발급 API - 사용자 토큰발급 API (3-legged) 요청
		PayToken token = service.getAccessToken(authResponse);
		log.info(">>>>>> 엑세스토큰 정보 : " + token);
		
		// 요청 결과 판별
		if(token == null || token.getAccess_token() == null) {
			model.addAttribute("msg", "토큰 발급 실패! 재인증 필요!");
			// 인증 화면이 새 창에 표시되어 있으며, 해당 창 닫기 위해 "isClose" 속성값에 true 저장
			model.addAttribute("isClose", true);
			return "result/fail";
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", session.getAttribute("sId"));
		map.put("token", token);
		service.registAccessToken(map);
		
		// 세션에 엑세스토큰 관리 객체(BankToken) 객체 저장
		session.setAttribute("token", token);
		model.addAttribute("msg", "계좌 연결 완료!");
//				model.addAttribute("targetURL", "BankMain");
		model.addAttribute("isClose", true);
		return "result/success";
	}
	
	// 2.2. 사용자/서비스 관리 - 2.2.1. 사용자정보조회 API (GET)
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("BankUserInfo")
	public String bankUserInfo(HttpSession session, Model model) {
		// 엑세스토큰 관련 정보가 저장된 BankToken 객체(token)를 세션에서 꺼내기
		PayToken token = (PayToken)session.getAttribute("token");
		System.out.println("토큰 정보 : " + token);
		
		if(token == null || token.getAccess_token() == null) {
			model.addAttribute("msg", "계좌 인증 필수!");
			model.addAttribute("targetURL", "BankMain");
			return "result/fail";
		}
		
		// BankService - getBankUserInfo() 메서드 호출하여 핀테크 사용자 정보 조회
		Map<String, Object> bankUserInfo = service.getPayUserInfo(token);
		log.info(">>>>> 핀테크 사용자 정보 : " + bankUserInfo);
		
		// API 응답코드(rsp_code)가 "A0000" 이 아닐 경우 요청 처리 실패
		if(!bankUserInfo.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", bankUserInfo.get("rsp_message"));
			return "result/fail";
		}

		model.addAttribute("bankUserInfo", bankUserInfo);
		return "pay/my_account";
	}
	
	@LoginCheck(memberRole = MemberRole.USER)
	@PostMapping("PayAccountDetail")
	public String payAccountDetail(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		// 2.3. 계좌조회 서비스(사용자) - 2.3.1. 잔액조회 API 서비스 요청 (POST)
//		log.info(">>>>>>>>>>>>>>>계좌 잔액조회 요청 파라미터 : " + map);
		// AOP로 어노테이션 써서 계좌 체크하기!
		return "pay/pay_account_detail";		
	}
}
