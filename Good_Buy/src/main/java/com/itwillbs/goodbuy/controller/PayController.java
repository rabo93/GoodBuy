package com.itwillbs.goodbuy.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.goodbuy.aop.LoginCheck;
import com.itwillbs.goodbuy.aop.LoginCheck.MemberRole;
import com.itwillbs.goodbuy.aop.PayTokenCheck;
import com.itwillbs.goodbuy.service.PayService;
import com.itwillbs.goodbuy.service.ProductService;
import com.itwillbs.goodbuy.vo.PayToken;
import com.itwillbs.goodbuy.vo.ProductVO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class PayController {

	@Autowired
	PayService service;
	
	@Autowired
	ProductService  productService;
	
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("GoodPay")
	public String goodPay(HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		// token이 등록된 id인지 조회
		String haveToken = service.getMemIdFromToken(id);
		if(haveToken == null) {
			return "pay/pay_empty_list";
		}
		
		
		return "redirect:/GoodPayAuth"; 
		
	}
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("GoodPayAuth")
	public String goodPayAuth(HttpSession session, Model model) {
		
		PayToken token = (PayToken)session.getAttribute("token");
		Map<String, Object> bankUserInfo = service.getPayUserInfo(token);
		String fintech_use_num = service.getRepresentAccountNum(token.getUser_seq_no());
		
		// 충전금액 조회(송금, 충전 본인) : 내역이 없을 수도 있으므로 Integer로 리턴함.
		Integer pay_amount = service.getPayAmount(token.getUser_seq_no());
		
		// 거래내역조회
		List<Map<String, String>> transactionInfo = service.getTransactionDetail(token.getUser_seq_no());
		
		// 거래내역에서 송금일 경우 : 송금받는 사람(RECEIVER_FINTECH_USE_NUM)도 내역 표시. 
		// 자기자신의 FINTECH_USE_NUM으로 RECEIVER_FINTECH_USE_NUM이 있는지 거래내역 조회 
		List<Map<String, String>> recieverTransactionInfo = service.getReceiverTransactionDetail(fintech_use_num);
		// 충전금액 조회(송금, 충전 본인) : 내역이 없을 수도 있으므로 Integer로 리턴함.
		Integer pay_amount_receive = service.getReceiverPayAmount(fintech_use_num);
		
		
		model.addAttribute("recieverTransactionInfo", recieverTransactionInfo);
		model.addAttribute("transactionInfo", transactionInfo);
		model.addAttribute("pay_amount", pay_amount);
		model.addAttribute("pay_amount_receive", pay_amount_receive);
		model.addAttribute("bankUserInfo", bankUserInfo);
		model.addAttribute("fintech_use_num", fintech_use_num);
		
		return "pay/pay_list";
	}
	
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("MyAccount")
	public String myAccount(HttpSession session, Model model) {
		// 엑세스토큰 관련 정보가 저장된 BankToken 객체(token)를 세션에서 꺼내기
		PayToken token = (PayToken)session.getAttribute("token");
		
		/*
		if(token == null || token.getAccess_token() == null) {
			model.addAttribute("msg", "계좌 인증 필수!");
			model.addAttribute("targetURL", "MyAccount");
			return "result/fail";
		}
		*/
		// PayService - getBankUserInfo() 메서드 호출하여 핀테크 사용자 정보 조회
		Map<String, Object> bankUserInfo = service.getPayUserInfo(token);
		log.info(">>>>> 핀테크 사용자 정보 : " + bankUserInfo);
		
		Object resListObj = bankUserInfo.get("res_list");
		List<Map<String, Object>> resList = (List<Map<String, Object>>) resListObj;
		List<String> fintech_use_nums = resList.stream()
                							 .map(map -> (String) map.get("fintech_use_num"))
                							 .collect(Collectors.toList());

		String fintech_use_num = service.getRepresentAccountNum(token.getUser_seq_no());
		
		// API 응답코드(rsp_code)가 "A0000" 이 아닐 경우 요청 처리 실패
		if(!bankUserInfo.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", bankUserInfo.get("rsp_message"));
			return "result/fail";
		}
		
		model.addAttribute("fintech_use_num", fintech_use_num);
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
		log.info(authResponse + ">>>>>> 엑세스토큰 정보 : " + token);
		
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
	
	// 2.3. 계좌조회 서비스(사용자) - 2.3.1. 잔액조회 API 서비스 요청 (POST)
	@LoginCheck(memberRole = MemberRole.USER)
	@PayTokenCheck // 엑세스토큰 존재 여부 체크하는 사용자 어노테이션
	@PostMapping("PayAccountDetail")
	public String payAccountDetail(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		log.info(">>>>>>>>>>>>>>>계좌 잔액조회 요청 파라미터 : " + map);
		
		
		// 엑세스토큰 정보가 저장된 BankToken 객체를 세션에서 꺼내기
		PayToken token = (PayToken)session.getAttribute("token");
		// => @PayTokenCheck 어노테이션으로 사전 검사 완료됐기 때문에 별도의 체크 불필요
		// ------------------------------------------------------------------------------
		map.put("token", token); // Map<String, Object> 필요
			
		// PayService - getAccountDetail() 메서드 호출하여 핀테크 계좌 잔액조회 요청
		Map<String, String> accountDetail = service.getAccountDetail(map);
//		System.out.println("getAccountDetail 잔액조회 뭐뭐 나오나? " + accountDetail);
			
		// ----------------------------------------------------------------------
		// API 응답코드(rsp_code)가 "A0000" 이 아닐 경우 요청 처리 실패이므로
		// (단, 이체과정에서는 "A0001"(이체처리중) 이 응답으로 전송될 수 있음)
		// API 응답메세지(rsp_message) 를 Model 객체에 저장 후 fail.jsp 포워딩
		if(!accountDetail.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", accountDetail.get("rsp_message"));
			return "result/fail";
		}
		// ----------------------------------------------------------------------
		// Model 객체에 응답데이터가 저장된 Map 객체(accountDetail)와
		// 요청 파라미터로 전달받은(Map 객체 - map) 예금주명, 계좌번호(마스킹) 파라미터로 저장
		model.addAttribute("accountDetail", accountDetail);
		model.addAttribute("account_holder_name", map.get("account_holder_name"));
		model.addAttribute("account_num_masked", map.get("account_num_masked"));
		
		
		return "pay/pay_account_detail";
	}
	
	// 사용자 조회 화면에서 계좌 목록 중 대표계좌로설정 버튼 클릭 시 해당 정보를 DB 에 등록 요청
	@LoginCheck(memberRole = MemberRole.USER)
	@PayTokenCheck
	@PostMapping("PayRegistRepresentAccount")
	public String payRegistRepresentAccount(@RequestParam Map<String, Object> map, Model model, HttpSession session) {
		// 세션 "token" 속성에서 PayToken 객체에 저장된사용자번호 (user_seq_no) 꺼낸 후
		// Map 객체에 추가
		PayToken token = (PayToken)session.getAttribute("token");
		map.put("token", token); // Map<String, Object> 필요
		
		log.info(">>>>>>>>>> 대표계좌정보 : " + map);
		
		// BankService - registRepresentAccount() 메서드 호출하여 대표계좌정보 DB 등록요청
		// => 파라미터 : Map 객체  , 리턴타입 : int(count)
		int count = service.registRepresentAccount(map);
		
		
		if(count > 0) {
//			System.out.println("대표계좌  조회 되나? " + map);
			return "redirect:/MyAccount";
		} else {
			model.addAttribute("msg","대표계좌 등록실패\\n관리자에게 문의하시오");
			return "result/fail";
		}
	}
	@LoginCheck(memberRole = MemberRole.USER)
	@PayTokenCheck
	@PostMapping("PayWithdraw")
	public String payWithdraw(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		// 엑세스토큰 정보가 저장된 BankToken 객체를 세션에서 꺼내기
		PayToken token = (PayToken)session.getAttribute("token");

		map.put("token", token); // Map<String, Object> 필요
		map.put("id", session.getAttribute("sId"));
		log.info(">>>>>>>> 출금 이체 요청 파라미터 정보 : " + map);
			
		// BankService - requestWithdraw() 메서드 호출하여 출금이체 요청
		Map<String, String> withdrawResult = service.requestWithdraw(map);
		log.info(">>>>>>>>>>>>>출금 이체 요청 결과 : " + withdrawResult);
			
		if(!withdrawResult.get("rsp_code").equals("A0000") || !withdrawResult.get("bank_rsp_code").equals("000")) { // 출금실패
			model.addAttribute("msg", "출금실패 : " + withdrawResult.get("rsp_message"));
			return "result/fail";
		}
		
		// 사용자 번호를 출금이체 결과 객체에 추가 
		withdrawResult.put("user_seq_no", token.getUser_seq_no());
		
//		// 임시) withdrawResult 객체의 api_tran_dtm 속성값(문자열) 뒷자리 3자리 (밀리초)제거
		withdrawResult.put("api_tran_dtm", withdrawResult.get("api_tran_dtm").substring(0, withdrawResult.get("api_tran_dtm").length() - 3));
		
		// 출금이체 성공 시 결과를 DB에 저장
		 service.registWithdrawResult(withdrawResult);
		 
//		// 출금이체 결과 정보 Map 객체 중 api_tran_id 값을 Model에 저장
		model.addAttribute("bank_tran_id", withdrawResult.get("bank_tran_id"));
		
		return "redirect:/PayWithdrawResult";
	}
	
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("PayWithdrawResult")
	public String payWithdrawResult(String bank_tran_id, Model model) {
		Map<String, String> withdrawResult = service.getWithdarwResult(bank_tran_id);
		model.addAttribute("withdrawResult", withdrawResult);

		return "pay/pay_withdraw_result";
	}
	
	
	// 입금이체(= 기관출금)
	@LoginCheck(memberRole = MemberRole.USER)
	@PayTokenCheck
	@PostMapping("PayDeposit")
	public String PayDeposit(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		PayToken token = (PayToken)session.getAttribute("token");

		map.put("id", session.getAttribute("sId"));
		log.info(">>>>>>>> 입금 이체 요청 파라미터 정보 : " + map);
		
		// PayService - requestDeposit() 메서드 호출하여 입금이체 요청
		Map<String, Object> depositResult = service.requestDeposit(map);
		
		log.info(">>>>>>>> 입금이체 요청 결과 : " + depositResult);
		
		List<Map<String, String>> res_list = (List<Map<String, String>>) depositResult.get("res_list");
		
		if(!depositResult.get("rsp_code").equals("A0000") || !res_list.get(0).get("bank_rsp_code").equals("000")) {
			model.addAttribute("msg", "입금 실패! - " + depositResult.get("rsp_message"));
			return "result/fail";
		}
				
		// 사용자번호를 입금이체 결과 객체에 추가
		depositResult.put("user_seq_no", token.getUser_seq_no());
				
		// 출금이체 성공 시 결과를 DB 에 저장
		service.registDepositResult(depositResult);
				
		// 출금이체 결과 정보 Map 객체 중 bank_tran_id 값을 Model 에 저장
		model.addAttribute("bank_tran_id", res_list.get(0).get("bank_tran_id"));
		
		return "redirect:/PayDepositResult";
	}
	
	// 입금이체 결과
	@LoginCheck(memberRole = MemberRole.USER)
	@PayTokenCheck
	@GetMapping("PayDepositResult")
	public String payDepositResult(String bank_tran_id, Model model) {
		
		Map<String, String> depositResult = service.getDepositResult(bank_tran_id);
		model.addAttribute("depositResult", depositResult);
		
		return "pay/pay_deposit_result";
	}
	
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("PayTransferRequest")
	public String payTransferRequest(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		int product_id = Integer.parseInt((String) map.get("product_id"));
		PayToken token = (PayToken)session.getAttribute("token");
		
		
		Map<String, Object> bankUserInfo = service.getPayUserInfo(token);
		String fintech_use_num = service.getRepresentAccountNum(token.getUser_seq_no());
		
		// 충전금액 조회
		int pay_amount = service.getPayAmount(token.getUser_seq_no());
		
		// 상품 조회
		ProductVO productSearch = productService.productSearch(product_id);
		
		model.addAttribute("pay_amount", pay_amount);
		model.addAttribute("productSearch", productSearch);
		model.addAttribute("bankUserInfo", bankUserInfo);
		model.addAttribute("fintech_use_num", fintech_use_num);
		
		return "pay/pay_remit";
	}
	
	// 사용자간(P2P) 계좌이체(송금) = 출금이체 -> 입금이체 연속으로 요청
	@LoginCheck(memberRole = MemberRole.USER)
	@PayTokenCheck
	@PostMapping("PayTransfer")
	public String payTransfer(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		PayToken senderToken = (PayToken)session.getAttribute("token");
		
		// 이체에 필요한 사용자 계좌(입금받는 상대방) 관련 정보(토큰) 조회
		PayToken receiverToken = service.getPayTokenInfo((String)map.get("receiver_id"));
		log.info(">>>>>>>> 상대방(입금받는사람) 토큰 정보 : " + receiverToken);
		log.info(">>>>>>>> 자신(송금하는사람) 토큰 정보 : " + senderToken);
		
		String id = (String)session.getAttribute("sId");
		String receiver_id = (String)map.get("receiver_id");
		// 상품 조회
		int product_id = Integer.parseInt((String) map.get("product_id"));
		ProductVO productSearch = productService.productSearch(product_id);
		map.put("pay_id", 0);
		map.put("buyer_id", id);
		map.put("product_price", productSearch.getProduct_price());
		map.put("product_trade_adr1", productSearch.getProduct_trade_adr1());
		System.out.println("판매자 주소 알아보기 : " + productSearch);

		// 수신자(상대방)의 토큰이 존재하지 않을 경우(= 계좌 등록이 되어있지 않음 등)
		if(receiverToken == null || receiverToken.getAccess_token() == null) {
			model.addAttribute("msg", "상대방 계좌 정보가 존재하지 않습니다!");
			return "result/fail";
		}
		
		map.put("receiverToken", receiverToken);
		map.put("senderToken", senderToken);

		// 송금인과 수신인의 계좌 정보 조회
		// => 리턴타입 : Map<String, String>
		Map<String, String> senderAccount = service.getPayAccountInfo(senderToken.getUser_seq_no());
		Map<String, String> receiverAccount = service.getPayAccountInfo(receiverToken.getUser_seq_no());
		
		// 각 계좌정보도 Map 객체(map)에 추가
		map.put("senderAccount", senderAccount);
		map.put("receiverAccount", receiverAccount);
		
		log.info(">>>>>>>> 송금 요청 정보 : " + map);

		// PayService - transfer() 메서드 호출하여 송금 작업 요청
		Map<String, Object> transferResult = service.transfer(map);
		
		// 송금 요청 결과에 따른 처리
		// 1) 출금이체결과 또는 입금이체결과 객체가 null 일 경우
		// 2) 출금이체결과의 "rsp_code" 값이 "A0000" 이 아닐 경우
		// 3) 입금이체결과의 "rsp_code" 값이 "A0000" 이 아닐 경우
		Map<String, String> withdrawResult = (Map<String, String>)transferResult.get("withdrawResult");
		Map<String, Object> depositResult = (Map<String, Object>)transferResult.get("depositResult");
		
		if(withdrawResult == null || depositResult == null) {
			model.addAttribute("msg", "송금 과정에서 시스템 오류 발생!\\n관리자에게 문의바랍니다.");
			return "result/fail";
		} else if(!withdrawResult.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", withdrawResult.get("rsp_message") + "(" + withdrawResult.get("bank_rsp_message") + ")");
			return "result/fail";
		} else if(!depositResult.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", depositResult.get("rsp_message") + "(" + depositResult.get("bank_rsp_message") + ")");
			return "result/fail";
		}
		
		log.info(">>>>> 이체결과 : " + transferResult);
		// 송금결과 DB 저장
		
		// 사용자번호를 입금이체 결과 객체에 추가
		transferResult.put("user_seq_no", senderToken.getUser_seq_no());
						
		// 송금이체 성공 시 결과를 DB (TRANSACTIONINFO) 에 저장
		service.registTransferResult(transferResult);
		
		// DB에 거래내역 저장
		int payInfo = service.registPayInfo(map);
		
		session.setAttribute("transferResult", transferResult);
		
		return "redirect:/PayTransferResult";
	}
	
	// P2P 송금(이체) 결과 뷰페이지 처리
	@LoginCheck(memberRole = MemberRole.USER)
	@PayTokenCheck
	@GetMapping("PayTransferResult")
	public String payTransferResult(HttpSession session, Model model) {
		// 세션에 저장된 이체결과객체 (transferResult) 꺼내기
		Map<String, Object> transferResult =(Map<String, Object>)session.getAttribute("transferResult");
		
		// 세션에서 객체 꺼낸 후 세션내의 객체는 제거
		session.removeAttribute("ransferResult"); // 마치 세션을 리퀘스트 처럼 사용함.
		// 포워딩은 리퀘스트처럼하는데 라디이렉트는 다음페이지에 유지가 안됨. 그래서 디비에서 갖고오거나 세션에담되 없애면 됨.
		
		// 이체 결과 객체를 모델 객체에 저장
		model.addAttribute("transferResult", transferResult);
		
		return "pay/pay_transfer_result";
		
	}
	
	@GetMapping("AllPayList")
	public String allPayList() {
		System.out.println("AllPayList");
		return "pay/pay_use_list";
	}
    
	
	
}
