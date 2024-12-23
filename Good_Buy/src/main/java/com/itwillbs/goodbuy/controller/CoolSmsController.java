package com.itwillbs.goodbuy.controller;

import java.text.DecimalFormat;
import java.util.Random;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.goodbuy.service.MemberService;
import com.itwillbs.goodbuy.vo.MailAuthInfo;
import com.itwillbs.goodbuy.vo.SmsAuthInfoVO;

import lombok.extern.log4j.Log4j2;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Log4j2
@Controller
public class CoolSmsController {
	@Autowired
	private MemberService memberService;
	
	@Value("${coolsms.api.key}")
	private String apiKey;

	@Value("${coolsms.api.secret}")
	private String apiSecretKey;

	@Value("${coolsms.from.phone}")
	private String fromPhoneNumber;
	
	
	private DefaultMessageService messageService;
	@PostConstruct
	public void initMessageService() {
		this.messageService = NurigoApp.INSTANCE.initialize(apiKey, apiSecretKey, "https://api.coolsms.co.kr");
	}
	
	// 단일 문자 발송
	@PostMapping("/send-one")
	@ResponseBody
	public ResponseEntity<?> sendOne(@RequestParam("userPhone") String userPhone, HttpSession session) {
		System.out.println("회원 휴대폰 번호 : " + userPhone);
		// 해당 휴대폰 번호로 가입한 회원이 있는지 판별
		String memId = memberService.getMemberInfo(userPhone);
		
		// 이미 존재할 경우
//		if (memId != null) {
//			return ResponseEntity.badRequest()
//					.header("Content-Type", "text/plain; charset=UTF-8")
//					.body("이미 존재하는 휴대폰번호입니다.");
//		}
		
		
		// 존재하지 않을 경우
        // 1) 랜덤 인증번호 생성
	    String smsCode = RandomNumber();
        System.out.println("인증번호 : "+ smsCode);
        session.setAttribute("smsCode", smsCode);
        session.setAttribute("smsCodeTime", System.currentTimeMillis());
        
        // 2) 인증 메세지 생성
        Message message = new Message();
        message.setFrom(fromPhoneNumber);	//계정에서 등록한 발신번호
        message.setTo(userPhone);			//수신번호
        message.setText("[GoodBuy] 인증번호 [" + smsCode + "] 를 입력하세요.");
        
        // 3) coolSMS API 사용하여 사용자 핸드폰에 전송
    	SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
    	log.info(">>>>>>>>>>coolSMS API 요청 응답 : " + response);
    	
    	// 4) DB에 인증정보 저장
    	SmsAuthInfoVO smsAuthInfoVO = new SmsAuthInfoVO();
    	smsAuthInfoVO.setMem_phone(userPhone);
    	smsAuthInfoVO.setAuth_code(smsCode);
    	smsAuthInfoVO.setMem_id(memId);
    	memberService.registSmsAuthInfo(smsAuthInfoVO);
    	
    	//AJAX에 성공 응답 반환
    	return ResponseEntity.ok(response);
	}
	
	//랜덤 코드 생성
    public static String RandomNumber() {
    	Random random = new Random();
        int randomNum = random.nextInt(1000000); // 1000000 미만인 숫자
        DecimalFormat format = new DecimalFormat("000000"); // 숫자 포맷 지정
        return format.format(randomNum);
    }
    
    
    
    
    
    
    
    
    
    
}
	
