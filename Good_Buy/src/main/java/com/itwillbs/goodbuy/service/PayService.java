package com.itwillbs.goodbuy.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.handler.BankApiClient;
import com.itwillbs.goodbuy.mapper.PayMapper;
import com.itwillbs.goodbuy.vo.PayToken;

@Service
public class PayService {
	
	@Autowired
	private PayMapper mapper;
	
	@Autowired
	private BankApiClient bankApiClient;

	// 액세스 토큰 정보 DB 저장 요청
	public PayToken getAccessToken(Map<String, Object> authResponse) {
		// BankApiClient - requestAccessToken() 메서드 호출하여 엑세스토큰 발급 요청
		return bankApiClient.requestAccessToken(authResponse);	
	}

}
