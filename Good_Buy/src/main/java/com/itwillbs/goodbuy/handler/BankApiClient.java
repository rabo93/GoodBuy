package com.itwillbs.goodbuy.handler;

import java.net.URI;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

import com.itwillbs.goodbuy.vo.PayToken;

import lombok.extern.log4j.Log4j2;

//금융결제원 오픈뱅킹 API 요청에 사용할 클래스 정의
@Log4j2
@Component
public class BankApiClient {

	// 오픈뱅킹 API 요청에 사용할 값들을 properties 파일로부터 읽어서 변수에 자동 저장
	@Value("${bank.base_url}")
	private String base_url;
	
	@Value("${bank.redirect_uri}")
	private String redirect_uri;
	
	@Value("${bank.client_id}")
	private String client_id;
	
	@Value("${bank.client_secret}")
	private String client_secret;
	
	@Value("${bank.client_use_code}")
	private String client_use_code;
	
	// appdata.properties 
	// 이용기관 등록계좌번호
	@Value("${bank.cntr_account_num}")
	private String cntr_account_num;
	
	// 이용기관 등록계좌 개설기관 표준코드
	@Value("${bank.cntr_account_bank_code}")
	private String cntr_account_bank_code;
	
	// 이용기관 등록계좌 예금주명
	@Value("${bank.cntr_account_holder_name}")
	private String cntr_account_holder_name;
	
	/*
	bank.cntr_account_num=23062003999
	# 이용기관 등록계좌 예금주명
	bank.cntr_account_holder_name=이연태
	*/
	private String grant_type = "authorization_code";

	public PayToken requestAccessToken(Map<String, Object> authResponse) {
		// 금융결제원 오픈API 토큰 발급 API 요청 작업 수행 및 결과 처리

		// 1. POST 방식 요청을 수행할 URL 정보를 URI 타입 객체 또는 문자열로 생성
		URI uri = UriComponentsBuilder
					.fromUriString(base_url + "/oauth/2.0/token") // 요청 주소 생성
					.encode() // 주소 인코딩
					.build() // UriComponents 타입 객체 생성
					.toUri(); // URI 타입 객체로 변환
		//System.out.println("요청 주소 : " + uri.toString());
		
		return null;
		
	}
	
	
}
