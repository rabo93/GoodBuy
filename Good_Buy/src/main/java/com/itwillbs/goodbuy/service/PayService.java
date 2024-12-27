package com.itwillbs.goodbuy.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.handler.PayApiClient;
import com.itwillbs.goodbuy.mapper.PayMapper;
import com.itwillbs.goodbuy.vo.PayToken;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class PayService {
	
	@Autowired
	private PayMapper mapper;
	
	@Autowired
	private PayApiClient payApiClient;

	// 액세스 토큰 정보 DB 저장 요청
	public PayToken getAccessToken(Map<String, String> authResponse) {
		// BankApiClient - requestAccessToken() 메서드 호출하여 엑세스토큰 발급 요청
		return payApiClient.requestAccessToken(authResponse);	
	}

	// DB - 엑세스토큰 정보 저장 요청
	public void registAccessToken(Map<String, Object> map) {
		// BankMapper - selectTokenInfo() 메서드 호출하여 사용자 일련번호에 해당하는 엑세스토큰 존재 여부 판별
		String access_token = mapper.selectTokenInfo(map);
		System.out.println("토큰 정보 : " + access_token);

		// 기존 토큰이 존재하지 않을 경우 새 엑세스 토큰 정보 추가(INSERT) - insertAccessToken()
		// 기존 토큰이 존재할 경우 새 엑세스 토큰 정보 갱신(UPDATE) - updateAccessToken()
		if(access_token == null) {
			mapper.insertAccessToken(map);
		} else {
			mapper.updateAccessToken(map);
		}
		
	}

	// DB - 엑세스토큰 정보 조회 요청
	public PayToken getPayTokenInfo(String mem_id) {
		return mapper.selectPayTokenInfo(mem_id);
	}

	// API - 핀테크 사용자 정보 조회
	public Map<String, Object> getPayUserInfo(PayToken token) {
		return payApiClient.requestPayUserInfo(token);
	}

	// API - 핀테크 계좌 잔액 조회
	public Map<String, String> getAccountDetail(Map<String, Object> map) {
		return payApiClient.requestAccountDetail(map);
	}

	// DB - 대표계좌 등록 요청 
	public int registRepresentAccount(Map<String, Object> map) {
		// 기존 사용자번호에 대한 대표 계좌가 설정되어 있는지 정보조회 
		// PayMapper - selectRepresentAccount() 메서드 호출하여 사용자 번호에 대한 대표계좌 조회
//		 System.out.println("map 나오나?????????????" + map); // ㅇㅇ 나옴.
		String user_seq_no = mapper.selectRepresentAccount(map);
//		System.out.println("PayService에서 user_seq_no : " + user_seq_no);
		
		// 대표 계좌 존재여부 판별
		if(user_seq_no == null) { // 대표계좌 정보가 없을 경우
			return mapper.insertRepresentAccount(map);
		} else { // 대표계좌 정보가 없을 경우
			return mapper.updateRepresentAccount(map);
		}
	}
	// DB - 대표계좌 조회
	public String getRepresentAccount(Map<String, Object> map) {
		return mapper.selectRepresentAccount(map);
	}
	// DB - 대표계좌 조회(핀테크 번호)
	public String getRepresentAccountNum(String token) {
		return mapper.selectRepresentAccountNum(token);
	}
	// =====================================================================
	// API - 출금이체 요청
	public Map<String, String> requestWithdraw(Map<String, Object> map) {
		// PayApiClient - requestWithdraw()
		return payApiClient.requestWithdraw(map);
	}

	public void registWithdrawResult(Map<String, String> withdrawResult) {
		// 입금이체 할때도 쓸거라서 
		// BankMapper - insertTransactionResult() 로 생성
	    // => 파라미터 : 출금이체 결과, 거래타입 ("WI": 출금이체)
//		mapper.insertTransactionResult(withdrawResult, "WI");
		mapper.insertTransactionResult(new HashMap<>(withdrawResult), "WI"); // Map<String, String>을 Map<String, Object>로 변환
	}

	// DB - 출금이체 결과 조회 요청
	public Map<String, String> getWithdarwResult(String bank_tran_id) {
		return mapper.selectTransactionResult(bank_tran_id);
	}

	// API - 입금이체 요청
	public Map<String, Object> requestDeposit(Map<String, Object> map) {
		// PayMapper - selectAdminAccessToken() 메서드 호출하여 이용기관 엑세스토큰 조회
		// => 기존 사용자의 엑세스 토큰 정보 조회 + 아이디값만 "admin" 으로 고정하여 메서드 재사용
		// -----------------------------------
		// BankMapper - selectPayTokenInfo() 메서드 호출하여 이용기관 엑세스토큰 조회
		// => 파라미터 : 관리자 아이디("admin")   리턴타입 : BankToken(adminToken)
		PayToken adminToken = mapper.selectPayTokenInfo("admin");
//		System.out.println("requestDeposit메서드에서 adminToken 잘 가져오나!!!??? " + adminToken); 
		
		// Map 객체에 "adminToken" 이라는 속성명으로 이용기관 토큰 정보 추가
		map.put("adminToken", adminToken);
		
		// payApiClient - requestDeposit()
		return payApiClient.requestDeposit(map);
	}

	// DB - 입금이체 결과 저장 요청
	public void registDepositResult(Map<String, Object> depositResult) {
		
		// System.out.println("depositResult?? 서비스에 이 결과값 잘 나오나?? " + depositResult);
		/*
		res_list=[{tran_no=1, bank_tran_id=M202113854UXRDWECLFT, bank_tran_date=20190101, bank_code_tran=097, bank_rsp_code=000, bank_rsp_message=, fintech_use_num=120211385488932422519787, account_alias=20240722강주미, bank_code_std=002, bank_code_sub=0000000, bank_name=KDB산업은행, account_num_masked=202407222***, print_content=아이티윌_입금, account_holder_name=강주미, tran_amt=33000, cms_num=, savings_bank_name=, withdraw_bank_tran_id=}], user_seq_no=1101061861}
		*/
		
		mapper.insertTransactionResult(depositResult, "DE");
	}


}
