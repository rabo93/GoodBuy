package com.itwillbs.goodbuy.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
		String user_seq_no = mapper.selectRepresentAccount(map);
		
		// 대표 계좌 존재여부 판별
		if(user_seq_no == null) { // 대표계좌 정보가 없을 경우
			return mapper.insertRepresentAccount(map);
		} else { // 대표계좌 정보가 없을 경우
			return mapper.updateRepresentAccount(map);
		}
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
		// PayMapper - insertTransactionResult() 로 생성
	    // => 파라미터 : 출금이체 결과, 거래타입 ("WI": 출금이체)
//		mapper.insertTransactionResult(withdrawResult, "WI");
		mapper.insertTransactionResult(new HashMap<>(withdrawResult), "WI"); 
		// Map<String, String>을 Map<String, Object>로 변환
	}
	
	// DB - 입금이체 결과 저장 요청
	public void registDepositResult(Map<String, Object> depositResult) {
		mapper.insertTransactionResult(depositResult, "DE");
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

	// DB - 입금이체 결과 조회 요청
	public Map<String, String> getDepositResult(String bank_tran_id) {
		return mapper.selectTransactionResult(bank_tran_id);
	}

	public String getMemIdFromToken(String id) {
		return mapper.selectMemIdFromToken(id);
	}

	// =====================================================================
	@Value("${bank.client_use_code}")
	private String client_use_code;
	
	public Map<String, Object> transfer(Map<String, Object> map) {
		// 출금과 입금을 하나의 요청으로 취급하기 위해 bank_tran_id 값 생성
		// ---------------------------------------------------------------
		// BankApiClient - requestWithdrawForTransfer() 메서드 호출하여 출금이체 요청
		Map<String, String> withdrawResult = payApiClient.requestWithdrawForTransfer(map);
		log.info(">>>>>>>>>>>  송금(출금)결과" + withdrawResult);
		
		Map<String, Object> transferResult = new HashMap<String, Object>();
		transferResult.put("withdrawResult", withdrawResult);
		
		// 출금이체 성공시에만 입금이체 작업 수행
		if(withdrawResult.get("rsp_code").equals("A0000")) {
			PayToken adminToken = mapper.selectPayTokenInfo("admin");
			map.put("adminToken", adminToken);
			
			// PayApiClient - requestDepositForTransfer() 메서드 호출하여 입금이체 요청
			Map<String, Object> depositResult =  payApiClient.requestDepositForTransfer(map);
			log.info(">>>>>>>>>>>  송금(입금)결과" + depositResult);
			
			// 출금이체 성공/실패 상관없이 결과를 Map 객체에 저장
			transferResult.put("depositResult", depositResult);
			
			// 입금이체 실패 시
			if(!depositResult.get("rsp_code").equals("A0000")) {
				// 출금이체를 되돌려야하므로 아이티윌(이용기관) -> 출금이체계좌로 다시 입금이체 필요(생략)
			}
		}
		
		return transferResult;
	}
	// DB - 사용자 계좌정보 조회
	public Map<String, String> getPayAccountInfo(String user_seq_no) {
		return mapper.selectPayAccountInfo(user_seq_no);
	}
	// DB - 입금이체 결과 저장 요청
	public void registTransferResult(Map<String, Object> transferResult) {
		mapper.insertTransactionResult(transferResult, "TR");
		
	}

	
	

	public int registPayInfo(Map<String, Object> map) {
		return mapper.insertPayInfo(map);
	}

	// 거래내역 조회 
	public List<Map<String, String>> getTransactionDetail(String fintech_use_num) {
		return mapper.selectTransactionDetail(fintech_use_num, "fintech");
	}

	public List<Map<String, String>> getReceiverTransactionDetail(String receiver_fintech_use_num) {
		return mapper.selectTransactionDetail(receiver_fintech_use_num, "reciever_fintech");
	}

	// 충전금액조회(송금하는 사람)
	public int getPayAmount(String user_seq_no) {
	    Integer amount = mapper.selectPayAmount(user_seq_no);
	    return amount != null ? amount : 0; 
	}
	// 충전금액조회(송금받는 사람)
	public Integer getReceiverPayAmount(String fintech_use_num) {
		Integer amount = mapper.selectReceiverPayAmount(fintech_use_num);
		return amount != null ? amount : 0; 
	}

	public Map<String, String> getPayInfo(String id) {
		return mapper.selectPayInfo(id);
	}





	


}
