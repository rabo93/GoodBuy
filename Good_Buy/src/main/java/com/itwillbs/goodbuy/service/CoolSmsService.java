package com.itwillbs.goodbuy.service;

import java.util.HashMap;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.vo.MemberVO;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service
public class CoolSmsService {
//	@Value("${coolsms.api.key}")
//	private String apiKey;
//
//	@Value("${coolsms.api.secret}")
//	private String apiSecret;
	
//	@Value("${coolsms.api.number}")
//	private String fromPhoneNumber;
	
//	public void certifiedPhoneNumber(String userPhone, int randomNumber) {
//		String apiKey = "NCSTPLYEEMP7WQM3";
//	    String apiSecret = "EGUI9PLOD43KRWMHV8KIJUOVD3NJJ2KQ";
//	    String fromPhoneNumber = "01074511274";
//	    
//		Message coolsms = new Message();
//		
//		HashMap<String, String> params = new HashMap<String, String>();
//	    params.put("to", userPhone);    // 수신전화번호
//	    params.put("from", fromPhoneNumber);    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
//	    params.put("type", "SMS");
//	    params.put("text", "[GoodBuy] 인증번호는" + "["+randomNumber+"]" + "입니다."); // 문자 내용 입력
//	    params.put("app_version", "test app 1.2"); // application name and version
//
//	    try {
//	        JSONObject obj = (JSONObject) coolsms.(params);
//	        System.out.println(obj.toString());
//	      } catch (CoolsmsException e) {
//	        System.out.println(e.getMessage());
//	        System.out.println(e.getCode());
//	      }
//		
//	}
    
    
}
