package com.itwillbs.goodbuy.handler;

import java.net.URI;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.google.gson.JsonObject;
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

	// ===================================================================
	// 2.3. 계좌조회 서비스(사용자) - 2.3.1. 잔액조회 API (GET)
	// => 주의! 잔액조회 테스트 데이터가 등록되어 있을 경우에만 정상적인 응답 처리됨
	public Map<String, String> requestAccountDetail(Map<String, Object> map) {
		PayToken token = (PayToken)map.get("token");
		// -----------------------------------------------------------
		// 거래고유번호(참가기관) 자동 생성을 위한 메서드
		String bank_tran_id = PayValueGenerator.getBankTranId(client_use_code);
		
		// BankValueGenerator - getTranDTime() 메서드 호출하여 거래일시 리턴받기
		String tran_dtime = PayValueGenerator.getTranDTime();
		
		
		System.out.println("access token : " + token.getAccess_token());
		System.out.println("----------------");
		System.out.println("거래고유번호 : " + bank_tran_id);
		System.out.println("fintech_use_num : " + map.get("fintech_use_num"));
		System.out.println("거래일시 : " + tran_dtime);
		
		
		// -----------------------------------------------------------
		// 1. POST 방식 요청을 수행할 URL 정보를 URI 타입 객체 또는 문자열로 생성
		URI uri = UriComponentsBuilder
					.fromUriString(base_url) // 기본 요청 주소 생성
					.path("/v2.0/account/balance/fin_num") // 상세 요청 주소(세부 경로) 생성
					.queryParam("fintech_use_num", map.get("fintech_use_num")) // GET 방식 요청 파라미터
					.queryParam("bank_tran_id", bank_tran_id) // GET 방식 요청 파라미터
					.queryParam("tran_dtime", tran_dtime) // GET 방식 요청 파라미터
					.encode() // 주소 인코딩
					.build() // UriComponents 타입 객체 생성
					.toUri(); // URI 타입 객체로 변환
		System.out.println("요청 주소 : " + uri.toString());
		
		// 2. 사용자 정보 조회 API 요청에 사용될 헤더정보를 관리할 HttpHeaders 객체 생성
		HttpHeaders headers = new HttpHeaders();
		headers.setBearerAuth(token.getAccess_token());
		
		// 3. 요청 정보로 사용할 헤더와 바디(지금은 불필요) 정보를 관리하는 HttpEntity 객체 생성
		//    => 모든 헤더 정보가 문자열로 관리되므로 제네릭타입으로 String 타입 지정
		HttpEntity<String> httpEntity = new HttpEntity<String>(headers);
		System.out.println("요청 정보 : " + httpEntity);
		
		// 4. REST API(RESTful API) 요청에 사용할 RestTemplate 객체 활용
		RestTemplate restTemplate = new RestTemplate();
		ParameterizedTypeReference<Map<String, String>> responseType = 
				new ParameterizedTypeReference<Map<String, String>>() {};
		// => 응답데이터 중 "객체" 가 존재하지 않으므로 제네릭타입을 <String, String> 사용 가능
		
		// exchange() 메서드 마지막 파라미터로 파싱 클래스 지정 시
		// ParameterizedTypeReference 객체를 지정하고
		// 리턴값을 지정하는 ResponseEntity 의 제네릭타입은 실제 파싱될 제네릭타입을 그대로 기술
		ResponseEntity<Map<String, String>> responseEntity = restTemplate.exchange(
				uri, // 요청 URL 관리하는 URI 타입 객체(또는 문자열로 된 URL 도 전달 가능) 
				HttpMethod.GET,  // 요청 메서드(HttpMethod.XXX 상수 활용)
				httpEntity, // 요청 정보를 관리하는 HttpEntity 객체
				responseType); // 응답 데이터를 파싱하여 관리할 클래스
		// -------------------------------------------------------------------------------------

		log.info("응답 코드 전체 : " + responseEntity);
		log.info("응답 코드 : " + responseEntity.getStatusCode());
		log.info("응답 헤더 : " + responseEntity.getHeaders());
		log.info("응답 본문 : " + responseEntity.getBody());
		
		// 5. 응답데이터가 저장된 ResponseEntity 객체의 getBody() 메서드 호출하여
		//    응답 데이터 중 본문만 추출하여 지정된 제네릭타입 객체로 리턴
		return responseEntity.getBody();
	}

	// =======================================================================
	// 2.6. 계좌이체 서비스 - 2.6.1. 출금이체 API 서비스(POST)
	// https://testapi.openbanking.or.kr/v2.0/transfer/withdraw/fin_num
	public Map<String, String> requestWithdraw(Map<String, Object> map) {
		PayToken token = (PayToken)map.get("token");
		// ------------------------------------------------------------------------
		// 세션 아이디 가져오기 : 통장표시내역에 넣을 예정이다.
		String id = (String)map.get("id"); // 여기서는 map.get은 object로 고정이라서 변환을 꼭 해줘야함. 
		// ------------------------------------------------------------------------
		String bank_tran_id = PayValueGenerator.getBankTranId(client_use_code);
		String tran_dtime = PayValueGenerator.getTranDTime();
		
		System.out.println("거래고유번호 : " + bank_tran_id);
		System.out.println("거래일시 : " + tran_dtime);
		// -------------------------------------------------------------------------------------
		// 1. HTTP 요청에 필요한 uri 정보를 관리할 uri 객체 생성
		URI uri = UriComponentsBuilder
					.fromUriString(base_url) // 기본 요청 주소 생성
					.path("/v2.0/transfer/withdraw/fin_num") // 상세 요청 주소(세부 경로) 생성
					.encode() // 주소 인코딩
					.build() // UriComponents 타입 객체 생성
					.toUri(); // URI 타입 객체로 변환
		System.out.println("요청 주소 : " + uri.toString());
		
		// 2. 사용자 정보 조회 API 요청에 사용될 헤더정보를 관리할 HttpHeaders 객체 생성
		HttpHeaders headers = new HttpHeaders();
		headers.setBearerAuth(token.getAccess_token());
		// 단, 요청 파라미터 타입이 "application/json; charset=UTF-8" 타입을 요구하므로
		// 헤더 정보를 관리하는 HttpHeaders 객체의 setContentType() 메서드 호출하여
		// 헤더 정보에 컨텐츠 타입을 JSOn 타입으로 설정
		// => 메서드 파라미터로 JSON 타입 지정을 위해 MediaType.APPLICATION_JSON 상수 활용
		//	  (주의! APPLICATION_JSON_UTF8 상수는 Deprecated이므로 사용하지 말자)
		headers.setContentType(MediaType.APPLICATION_JSON);
		// -------------------------------------------------------------------------------------
		// 3. API 요청 파라미터를 JSON 형식으로 생성
		// => org.json.JSONObject 클래스 또는 com.google.code.gson.JsonObject 클래스 활용(이름 헷갈리지말기)
		// 3-1) JSONObject 클래스 활용 = > put() 메서드로 데이터 추가(자동으로 json 형식으로 변환) 
//			JSONObject jsonObject = new JSONObject(); // 기본 생성자로 객ㅊ생성(또는 파라미터 사용 가능) 
//			// PDF 문서에 140쪽에 있는거 몇개 가져와
//			jsonObject.put("bank_tran_id", bank_tran_id); // 거래고유번호(참가기관)
//			jsonObject.put("cntr_account_type", "N"); // 약정 계좌/계정 구분("N" : 계좌)
//			jsonObject.put("cntr_account_num", cntr_account_num); // 약정 계좌/계정 번호(서비스 이용기관 - 아이티윌 계좌)
		//- 여기까지는 해봤으니까 3-2의 Gson이용해보자.
		// -------------------------------------------------------------------------------------
		// 3-2)Gson 라이브러리의 JsonObvject 클래스 활용(클래스명주의, JSONObject와 다르다!!
		// 	  => addProperty() 메서드로 데이터 추가(자동으로 JSON 형식으로 변환)
	
		JsonObject jsonObject = new JsonObject(); // 기본 생성자로 객체생성
		// ---------- 핀테크 이용기관(아이티윌) 정보 -------------------
		jsonObject.addProperty("bank_tran_id", bank_tran_id); // 거래고유번호(참가기관)
		jsonObject.addProperty("cntr_account_type", "N"); // 약정 계좌/계정 구분("N" : 계좌)
		jsonObject.addProperty("cntr_account_num", cntr_account_num); // 약정 계좌/계정 번호(서비스 이용기관 - 아이티윌 계좌)
		jsonObject.addProperty("dps_print_content", id); // 입금계좌인자내역(= 입금되는 계좌에 출력할 메세지)
		// => 임의로 현재 사용자의 세션 아이디를 내역으로 활용(사용자가 정하지 않음)
		
		// ------------- 요청 고객(출금계좌) 정보 ------------
		jsonObject.addProperty("fintech_use_num", (String)map.get("withdraw_fintech_use_num")); // 출금계좌핀테크 이용번호  
		jsonObject.addProperty("wd_print_content", "아이티윌"); // 출금계좌 인자내역(기본값 : 받는 사람 이름 - 사용자 통장에 표시할 내용
		jsonObject.addProperty("tran_amt", (String)map.get("tran_amt")); //거래금액 
		jsonObject.addProperty("tran_dtime", tran_dtime); // 거래요청일시
		jsonObject.addProperty("req_client_name", (String)map.get("withdraw_client_name")); // 요청고객성명(출금계좌에 대한 고객성명)
		jsonObject.addProperty("req_client_fintech_use_num", (String)map.get("withdraw_client_fintech_use_num")); //요청고객 핀테크이용번호(출금계좌)
		// => 요청고객 계좌번호와 개설기관 표준코드 미사용시 핀테크 이용번호 설정 필수!
		// 	  (단, 동시에 두가지 모두 설정시 오류 발생!)
		jsonObject.addProperty("req_client_num", id.toUpperCase()); // 요청고객회원번호(아이디처럼 사용)
		// => 별도의 회원번호가 없으므로 세션 아이디 활용 (영문자 알파벳 대문자 필수!
		jsonObject.addProperty("transfer_purpose", "ST"); // 이체용도(송금: TR, 결제: ST 등등) => PDF 문서 참고
		// => rhror rP고객 계좌에서 출금을 하지만 다른 고객에게 송금하지 않고 이용기관계좌에 전달되므로 
		// "결제" 형태의 거래가됨.
		
		// ---------- 수취고객(실제 최종입금대상) 정보
		// 치최종적으로 이금액을 수신하는 계좌에 대한 정보
		//=> 이정보(3가지)는 피싱등의 사고 발생시 지급 정지등을 위한 정보로 실제 검ㅅ증수행X
		// => 현재 거래는 사용자 -> 이용기관(아이티윌) 계좌로 입금되므로 이용기관 계좌정보를 세팅함.
		jsonObject.addProperty("recv_client_name", cntr_account_holder_name); // 최종수취고객성명주(입금대상-아이티윌)
		jsonObject.addProperty("recv_client_bank_code", cntr_account_bank_code);
		jsonObject.addProperty("recv_client_account_num", cntr_account_num);
		
		
		/*
		 * [ 테스트 데이터 등록 방법 - 출금이체 ]
		 * - 사용자 일련번호, 핀테크 이용번호 : 출금 계좌 고객 정보 선택(셀렉트박스)
		 *   => 출금기관 대표코드, 출금 계좌번호(출력용 포함) 자동으로 입력됨
		 * - 송금인 실명 : 출금계좌 예금주명(고객 성명)
		 * - 거래금액 : tran_amt 값 입력
		 * - 입금계좌 인자내역 : dps_print_content 값 입력(현재는 사용자의 아이디 입력되어 있음)
		 *   => 주의! 실제 사용 가능한 길이보다 짧게 입력받음(10글자만 입력 가능)
		 * - 수취인 성명 : 핀테크 이용기관 계좌 예금주명 입력(최종 수취인 아님!!)
		 * ---------------------------------------
		 * [ 주의사항 ]
		 * 출금 기능에서는 실제 잔액 계산 기능이 제공되지 않음(원래는 금융기관에서 제공하는 정보)
		 * 따라서, 출금이 성공하더라도 잔액 확인이 불가능하므로 
		 * DB 에 잔액 저장해두고 수동으로 처리 필요
		 */
		
		
		// ------------------
		// 4. 헤더와 바디를 묶어서 과니하는 HttpEntity 객체 생성
		// => 생성자에 바디 정보와 헤더 정보(HttpHeaders)를 모두 전달가능 - multivaluemap? 없어도 된다함
		HttpEntity<String> httpEntity = new HttpEntity<String>(jsonObject.toString(), headers);
        
		// 5. REST API(RESTful API) 요청에 사용할 RestTemplate 객체 활용
		RestTemplate restTemplate = new RestTemplate();
		ParameterizedTypeReference<Map<String, String>> responseType = 
				new ParameterizedTypeReference<Map<String, String>>() {};
		// => 응답데이터 중 "객체" 가 존재하지 않으므로 제네릭타입을 <String, String> 사용 가능
		
		// exchange() 메서드 마지막 파라미터로 파싱 클래스 지정 시
		// ParameterizedTypeReference 객체를 지정하고
		// 리턴값을 지정하는 ResponseEntity 의 제네릭타입은 실제 파싱될 제네릭타입을 그대로 기술
		ResponseEntity<Map<String, String>> responseEntity = restTemplate.exchange(
				uri, // 요청 URL 관리하는 URI 타입 객체(또는 문자열로 된 URL 도 전달 가능) 
				HttpMethod.GET,  // 요청 메서드(HttpMethod.XXX 상수 활용)
				httpEntity, // 요청 정보를 관리하는 HttpEntity 객체
				responseType); // 응답 데이터를 파싱하여 관리할 클래스

		// 6. 응답데이터를 관리하는 RsponseEntity 객ㄹ체의 getBody() 메서드 호출하여 응답데이터 본문 리턴
		
		return responseEntity.getBody();
	}

	
	
}
