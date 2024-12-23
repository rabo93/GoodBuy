package com.itwillbs.goodbuy.handler;

import java.net.URI;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.itwillbs.goodbuy.vo.PayToken;

import lombok.extern.log4j.Log4j2;

//금융결제원 오픈뱅킹 API 요청에 사용할 클래스 정의
@Log4j2
@Component
public class PayApiClient {

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

	public PayToken requestAccessToken(Map<String, String> authResponse) {
		// 금융결제원 오픈API 토큰 발급 API 요청 작업 수행 및 결과 처리

		// 1. POST 방식 요청을 수행할 URL 정보를 URI 타입 객체 또는 문자열로 생성
		URI uri = UriComponentsBuilder
					.fromUriString(base_url + "/oauth/2.0/token") // 요청 주소 생성
					.encode() // 주소 인코딩
					.build() // UriComponents 타입 객체 생성
					.toUri(); // URI 타입 객체로 변환
		//System.out.println("요청 주소 : " + uri.toString());
		
		
		// 2. POST 방식 요청 수행 시 파라미터를 URL 에 결합할 수 없으므로 body 에 포함시켜야 함
		LinkedMultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		//parameters.add("code", authResponse.get("code"));
		parameters.add("code", authResponse.get("code"));
		parameters.add("client_id", client_id);
		parameters.add("client_secret", client_secret);
		parameters.add("redirect_uri", redirect_uri);
		parameters.add("grant_type", grant_type);
		
		// 3. 요청 정보로 사용할 헤더(지금은 불필요)와 바디 정보를 관리하는 HttpEntity 객체 생성
		//    => 제네릭타입으로 파라미터 관리 객체 타입(Map<String, String>) 지정 후
		//       생성자에 파라미터 관리 객체 전달
		HttpEntity<LinkedMultiValueMap<String, String>> httpEntity = 
				new HttpEntity<LinkedMultiValueMap<String,String>>(parameters);
		System.out.println("요청 정보 : " + httpEntity);
		
		
		// 4. REST API(RESTful API) 요청에 사용할 RestTemplate 객체 활용
		// 4-1) RestTemplate 객체 생성
		RestTemplate restTemplate = new RestTemplate();
		
		// 4-2). RestTemplate 객체의 XXX() 메서드를 호출하여 API 요청 수행(실제 요청이 발생하는 지점)
		//    => 이 때, 응답데이터타입으로 클래스 타입 지정 시 XXX.class 형태로 지정
		//       단, 응답되는 JSON 데이터를 자동으로 파싱하려면 ParameterizedTypeReference 타입 활용
		ResponseEntity<PayToken> responseEntity = restTemplate.exchange(
				uri, // 요청 URL 관리하는 URI 타입 객체(또는 문자열로 된 URL 도 전달 가능) 
				HttpMethod.POST,  // 요청 메서드(HttpMethod.XXX 상수 활용)
				httpEntity, // 요청 정보를 관리하는 HttpEntity 객체
				PayToken.class); // 응답 데이터를 파싱하여 관리할 클래스(.class 필수!)
		// 주의! 응답 데이터로 전달되는 JSON 타입 데이터를 String 타입이 아닌 
		// 특정 클래스 타입으로 자동 파싱하려면 Gson 또는 Jackson 라이브러리가 필요함
		// 이 라이브러리가 존재하지 않을 경우 자동 파싱이 불가능하여 실행 시 예외 발생함
		// org.springframework.web.client.UnknownContentTypeException: Could not extract response: no suitable HttpMessageConverter found for response type [class com.itwillbs.mvc_board.vo.BankToken] and content type [application/json;charset=UTF-8]
		
		// -------------------------------------------------------------------------------------
		// 요청 과정에서 오류 발생 시 오류 코드(rsp_code)와 오류 메세지(rsp_message)가 전달
		log.info("응답 코드 : " + responseEntity.getStatusCode());
		log.info("응답 헤더 : " + responseEntity.getHeaders());
		log.info("응답 본문 : " + responseEntity.getBody());
		
		// 5. 응답데이터가 저장된 ResponseEntity 객체의 getBody() 메서드 호출하여
		//    응답 데이터 중 본문만 추출하여 지정된 제네릭타입 객체로 리턴
		return responseEntity.getBody();
		
	}

	// ===================================================================
	// 2.2. 사용자/서비스 관리 - 2.2.1. 사용자정보조회 API (GET)
	public Map<String, Object> requestPayUserInfo(PayToken token) {
		// 1. POST 방식 요청을 수행할 URL 정보를 URI 타입 객체 또는 문자열로 생성
		URI uri = UriComponentsBuilder
					.fromUriString(base_url) // 기본 요청 주소 생성
					.path("/v2.0/user/me") // 상세 요청 주소(세부 경로) 생성
					.queryParam("user_seq_no", token.getUser_seq_no()) // GET 방식 요청 파라미터
					.encode() // 주소 인코딩
					.build() // UriComponents 타입 객체 생성
					.toUri(); // URI 타입 객체로 변환
		//System.out.println("요청 주소 : " + uri.toString());
		
		// 2. 사용자 정보 조회 API 요청에 사용될 헤더정보를 관리할 HttpHeaders 객체 생성
		// 2-1) HttpHeaders 객체 생성
		HttpHeaders headers = new HttpHeaders();
		// 2-2) HttpHeaders 객체에 엑세스토큰 추가(속성명 : "Authorization", add() 메서드 활용)
//			headers.add("Authorization", token.getAccess_token());
		// 또는 인증용 Bearer 토큰 정보를 설정하는 setBearerAuth() 메서드 통해 토큰값 설정도 가능
		headers.setBearerAuth(token.getAccess_token());
		
		// 3. 요청 정보로 사용할 헤더와 바디(지금은 불필요) 정보를 관리하는 HttpEntity 객체 생성
		//    => 바디 정보 없이 헤더 정보만 전달(생성자에 HttpHeaders 객체 전달)
		//    => 모든 헤더 정보가 문자열로 관리되므로 제네릭타입으로 String 타입 지정
		HttpEntity<String> httpEntity = new HttpEntity<String>(headers);
		System.out.println("요청 정보 : " + httpEntity);
		
		// 4. REST API(RESTful API) 요청에 사용할 RestTemplate 객체 활용
		// 4-1) RestTemplate 객체 생성
		RestTemplate restTemplate = new RestTemplate();
		
		// 4-2). RestTemplate 객체의 exchange() 메서드를 HTTP(REST API) 요청 수행 - GET
		//       단, Map 타입 지정을 통해 응답되는 JSON 데이터를 자동으로 파싱하려면 
		//       ParameterizedTypeReference 객체를 통해 관리되어야 함
		// -------------------
		// Map 타입 지정 시 제네릭타입을 사용하기 위해 ResponseEntity<Map<K, V>> 를 지정하더라도
		// exchange() 메서드에서 Map.class 지정 시 Map<K, V>.class 형태로 지정 불가능하다!
		ParameterizedTypeReference<Map<String, Object>> responseType = new ParameterizedTypeReference<Map<String,Object>>() {};
		// => 응답데이터 중 res_list(계좌목록) 값이 리스트 형태의 "객체" 이므로
		//    제네릭타입을 <String, String> 대신 <String, Object> 타입으로 지정
		
		// exchange() 메서드 마지막 파라미터로 파싱 클래스 지정 시
		// ParameterizedTypeReference 객체를 지정하고
		// 리턴값을 지정하는 ResponseEntity 의 제네릭타입은 실제 파싱될 제네릭타입을 그대로 기술
		ResponseEntity<Map<String, Object>> responseEntity = restTemplate.exchange(
				uri, // 요청 URL 관리하는 URI 타입 객체(또는 문자열로 된 URL 도 전달 가능) 
				HttpMethod.GET,  // 요청 메서드(HttpMethod.XXX 상수 활용)
				httpEntity, // 요청 정보를 관리하는 HttpEntity 객체
				responseType); // 응답 데이터를 파싱하여 관리할 클래스
		// -------------------------------------------------------------------------------------

		log.info("응답 코드 : " + responseEntity.getStatusCode());
		log.info("응답 헤더 : " + responseEntity.getHeaders());
		log.info("응답 본문 : " + responseEntity.getBody());
		
		// 5. 응답데이터가 저장된 ResponseEntity 객체의 getBody() 메서드 호출하여
		//    응답 데이터 중 본문만 추출하여 지정된 제네릭타입 객체로 리턴
		return responseEntity.getBody();
	}
	
	
}
