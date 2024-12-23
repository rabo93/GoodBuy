package com.itwillbs.goodbuy.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import net.nurigo.sdk.message.model.Message;

@Service
public class CoolSmsService {
//	@Value("${coolsms.api.key}")
//    private String apiKey;
//
//    @Value("${coolsms.api.secret}")
//    private String apiSecret;
//
//    @Value("${coolsms.api.number}")
//    private String fromPhoneNumber;
//    
//    public String sendSms(String to){
//        try {
//            // 랜덤한 4자리 인증번호 생성
//            String numStr = generateRandomNumber();
//            
//            Message coolsms = new Message(apiKey, apiSecret); // 생성자를 통해 API 키와 API 시크릿 전달
//
//            HashMap<String, String> params = new HashMap<>();
//            params.put("to", to);    // 수신 전화번호
//            params.put("from", fromPhoneNumber);    // 발신 전화번호
//            params.put("type", "sms");
//            params.put("text", "인증번호는 [" + numStr + "] 입니다.");
//
//            // 메시지 전송
//            coolsms.send(params);
//
//            return numStr; // 생성된 인증번호 반환
//
//        } catch (Exception e) {
//            throw new CoolsmsException("Failed to send SMS", e);
//        }
//    }
//
//    // 랜덤한 4자리 숫자 생성 메서드
//    private String generateRandomNumber() {
//        Random rand = new Random();
//        StringBuilder numStr = new StringBuilder();
//        for (int i = 0; i < 4; i++) {
//            numStr.append(rand.nextInt(10));
//        }
//        return numStr.toString();
//    }
//출처: https://jay-cheol.tistory.com/entry/Spring-Boot-휴대폰-인증-기능-구현-coolsms [개발일기:티스토리]
    
    
}
