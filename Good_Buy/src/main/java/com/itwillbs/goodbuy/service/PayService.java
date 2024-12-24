package com.itwillbs.goodbuy.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.handler.PayApiClient;
import com.itwillbs.goodbuy.mapper.PayMapper;
import com.itwillbs.goodbuy.vo.PayToken;

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


}
