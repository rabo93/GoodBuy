package com.itwillbs.goodbuy.controller;

import java.text.DecimalFormat;
import java.util.Random;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.goodbuy.service.MemberService;
import com.itwillbs.goodbuy.vo.SmsAuthInfoVO;

import lombok.extern.log4j.Log4j2;
import net.nurigo.sdk.NurigoApp;
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
	
	//======================================================================================================
	// 단일 문자 발송
	@PostMapping("/send-one")
	@ResponseBody
	public ResponseEntity<?> sendOne(@RequestParam("userPhone") String userPhone) {
		log.info(">>>>>>>>> 입력한 휴대폰 번호 : " + userPhone);
		// 해당 휴대폰 번호로 가입한 회원이 있는지 판별
		String memId = memberService.getMemberInfo(userPhone);
		// * 이미 존재할 경우 *
		if (memId != null) {
			return ResponseEntity.badRequest()
					.header("Content-Type", "text/plain; charset=UTF-8")
					.body("이미 가입된 휴대폰번호입니다.");
		}
		// * 존재하지 않을 경우 *
        // 1) 랜덤 인증번호 생성 **아래에 랜덤 코드 생성 메서드 호출
	    String smsCode = RandomNumber();
        log.info(">>>>>>>>>> 인증번호 : "+ smsCode);
        
        // 2) 인증 메세지 생성
        Message message = new Message();
        message.setFrom(fromPhoneNumber);	//계정에서 등록한 발신번호
        message.setTo(userPhone);			//수신번호
        message.setText("[GoodBuy] 인증번호 [" + smsCode + "] 를 입력하세요.");
        
        // 3) coolSMS API 사용하여 사용자 핸드폰에 전송
    	SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
//    	log.info(">>>>>>>>>> coolSMS API 요청 응답 : " + response);
    	
    	// 4) 인증 정보 SmsAuthInfoVO 객체에 담아서 DB에 저장
    	SmsAuthInfoVO smsAuthInfoVO = new SmsAuthInfoVO();
    	smsAuthInfoVO.setMem_phone(userPhone);
    	smsAuthInfoVO.setAuth_code(smsCode);
//    	smsAuthInfoVO.setMem_id(null); // 새 가입이므로 memId는 null
    	memberService.registSmsAuthInfo(smsAuthInfoVO); 
    	
    	// 5) AJAX에 성공 응답 반환
    	return ResponseEntity.ok(response);
	}
	//-----------------------------------------------------------------------------
	// * 랜덤 코드 생성 (6자리) *
    public static String RandomNumber() {
    	Random random = new Random();
        int randomNum = random.nextInt(1000000); // 1000000 미만인 숫자
        DecimalFormat format = new DecimalFormat("000000"); // 숫자 포맷 지정
        return format.format(randomNum);
    }
    //-----------------------------------------------------------------------------
    
    //======================================================================================================
    // sms로 받은 인증번호와 입력한 인증번호 검증 로직
    @PostMapping("/verify-code")
    @ResponseBody
    public ResponseEntity<?> verifyCode(@RequestParam("authCode") String authCode, @RequestParam("userPhone") String userPhone) {
//    	log.info(">>>>>>>>>> 입력된 인증번호 번호 : " + authCode);
//    	log.info(">>>>>>>>>> 휴대폰번호 : " + memPhone);
    	
    	// 1) DB에서 입력된 인증번호의 인증 정보 조회
    	SmsAuthInfoVO smsAuthInfoVO = memberService.getSmsAuthInfo(authCode);
//        log.info(">>>>>>>>>> db에서 가져온 인증 정보 : " + smsAuthInfoVO);
        
        if (smsAuthInfoVO == null) {
            return ResponseEntity.badRequest()
            		.header("Content-Type", "text/plain; charset=UTF-8")
            		.body("인증번호 요청 기록이 존재하지 않습니다.");
        }
        
        // 2) 인증번호 유효시간 확인 (5분)
        long validDuration = 1 * 60 * 1000; // 5분
        long currentTime = System.currentTimeMillis();
        long authDateTime = smsAuthInfoVO.getAuth_date().getTime(); // DB에서 가져온 인증시간
        log.info(">>>>>>>>>> 현재 시간: " + currentTime);
        log.info(">>>>>>>>>> 인증 요청 시간: " + authDateTime);

        if (currentTime - authDateTime > validDuration) {
            return ResponseEntity.badRequest()
                    .header("Content-Type", "text/plain; charset=UTF-8")
                    .body("인증번호가 만료되었습니다.");
        }
        
        // 3) 인증번호에 대한 휴대폰 번호 비교
        if (!userPhone.equals(smsAuthInfoVO.getMem_phone())) {
            return ResponseEntity.badRequest()
                    .header("Content-Type", "text/plain; charset=UTF-8")
                    .body("인증번호가 일치하지 않습니다.");
        }
        
        // 4) 인증 성공 시 인증상태(1:인증완료) 업데이트
        memberService.updateAuthStatus(authCode);
        
        return ResponseEntity.ok()
                .header("Content-Type", "text/plain; charset=UTF-8")
                .body("인증에 성공했습니다.");
    }
    
    
    
    
    
    
    
    
}
	
