package com.itwillbs.goodbuy.aop;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.itwillbs.goodbuy.service.AdminService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Aspect
@Component
//@Order(value = Ordered.LOWEST_PRECEDENCE) // AOP 빈들간의 우선순위 설정(값이 낮을수록 우선순위 높음. 기본값 : Ordered.LOWEST_PRECEDENCE)
public class AdminLogAspect {
	
	@Autowired
	private AdminService service;
	
	@AfterReturning("@annotation(com.itwillbs.goodbuy.aop.AdminLog)")
	public void logSuccess(JoinPoint joinPoint) throws Exception {
		log.info(">>>>>>>>> after returning");
		Map<String, Object> map = getLogData(joinPoint, "success");
		
		if(map != null) {
			int registResult = service.registLog(map);
			System.out.println("성공로그 : " + registResult);
		}
	}
	
	@AfterThrowing("@annotation(com.itwillbs.goodbuy.aop.AdminLog)")
	public void logFail(JoinPoint joinPoint) {
		log.info(">>>>>>>>> after Throwing");
		Map<String, Object> map = getLogData(joinPoint, "fail");
		
		if(map != null) {
			int registResult = service.registLog(map);
			System.out.println("실패로그 : " + registResult);
		}
	}

	// ---------------------------------------------------------------------------------------
	// 저장할 로그 정보 만들기
	private Map<String, Object> getLogData(JoinPoint joinPoint, String resultMessage) {
		// 아이디 가져오기
		RequestAttributes attrs = RequestContextHolder.getRequestAttributes();
		if(attrs == null) {
			return null;
		}
		HttpServletRequest request = ((ServletRequestAttributes)attrs).getRequest();
		HttpServletResponse response = ((ServletRequestAttributes)attrs).getResponse();
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("sId");
		
		if(id == null) { // 세션아이디 없을 시
			String prevURL = request.getServletPath();
			String queryString = request.getQueryString();
			
			if(queryString != null) {
				prevURL += "?" + queryString;
			}
			session.setAttribute("prevURL", prevURL);
			throw new HttpStatusCodeException(HttpStatus.UNAUTHORIZED, "관리자만 이용 가능합니다!\\n로그인 페이지로 이동합니다./SNSLogin") {};
		}
		
		// JoinPoint : 어플리케이션 실행 흐름에서의 특정 포인트(AOP를 적용할 수 있는 지점)
		//             어드바이스가 적용될 수 있는 위치, 메소드 실행, 생성자 호출, 필드 값 접근, 
		//             static 메서드 접근 같은 프로그램 실행 중 지점을 나타냄
		// => joinPoint.getSignature() : 조언되는 메서드에 대한 설명(Signature 객체)을 반환
		//              ㄴ signature.getName() : 호출한 메서드 이름 반환
		String method_name = joinPoint.getSignature().getName().toString();
//		log.info(">>>>> 메서드명 : " + method_name);
		
		String ipAddress = request.getRemoteAddr();
		if(ipAddress.equals("0:0:0:0:0:0:0:1")) {
			ipAddress = "127.0.0.1";
		}
		log.info(">>>>> IP : " + ipAddress);
		
		// Map에 담아 DB에 저장하기
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("ADMIN_ID", id);
		result.put("MAPPER_ID", method_name);
		result.put("PROCESS_TIME", getDateTimeForNow());
		result.put("PROCESS_RESULT", resultMessage);
		result.put("IP_ADDRESS", ipAddress);
		
		log.info(">>>> log 저장 정보 : " + result);
		
		return result;
	}
	
	// 현재 시스템의 날짜 및 시각 정보 리턴하는 메서드 => 표현 형식 : yyyy-MM-dd HH:mm:ss
	private String getDateTimeForNow() {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		return LocalDateTime.now().format(dtf);
	}
	
}















