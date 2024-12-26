package com.itwillbs.goodbuy.handler;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.client.HttpStatusCodeException;

//=> 핸들러 클래스 정의 시 @ControllerAdvice 어노테이션 지정
@ControllerAdvice
public class MyExceptionHandler {
	// =========================================================================================
	// 예외 처리를 수행하기 위한 메서드 정의 시 메서드 상단에 @ExceptionHandler 어노테이션 지정
	@ExceptionHandler(Exception.class)
	public String textExceptionHandler(Exception e) {
		System.out.println("textExceptionHandler() 메서드에서 예외 처리!");
		e.printStackTrace();
		
		return "redirect:/error";
	}
	// =========================================================================================
	// AOP 를 활용한 id 값 null 체크 시 발생시킨 HttpStatusCodeException 예외 처리
	// => @ControllerAdvice 어노테이션이 적용된 예외 처리 클래스는
	//    DispatcherServlet 에 의해 관리되므로 컨트롤러와 동일하게 자동 주입 가능(Model, HttpSession 등)
	@ExceptionHandler(HttpStatusCodeException.class)
	public String httpStatusCodeExceptionHandler(HttpStatusCodeException e, Model model) {
		System.out.println("httpStatusCodeExceptionHandler() 메서드에서 예외 처리!");
		e.printStackTrace();
		
		// HTTP 상태코드를 판별하여 특정 코드에 따른 서로 다른 작업 수행
		// => 파라미터로 전달받은 Exception 객체의 getStatusCode() 메서드를 통해 상태코드 리턴 가능
		String msg = "";
		String targetURL = "";
		String viewName = "";

		switch (e.getStatusCode()) { // enum 값 전달
			case UNAUTHORIZED:
				// 예외 발생 시 상태메세지로 "메세지/이동할주소" 형식으로 전달했으므로
				// "/" 기준으로 문자열 분리 후 첫번째 배열 값은 msg, 두번째 배열값은 targetURL 로 사용
				msg = e.getStatusText().split("/")[0];
				
				// 상태메세지 뒤에 "/요청주소" 항목이 있을 경우 체크하여 문자열 분리
				if(e.getStatusText().split("/").length > 1) {
					targetURL = e.getStatusText().split("/")[1];
				}
				
				viewName = "result/fail";
				break;
		}
		
		// 출력할 메세지와 이동할 페이지 저장(switch 문 내에서 저장된 값 활용)
		model.addAttribute("msg", msg);
		model.addAttribute("targetURL", targetURL);
		
		// 오류 처리 뷰페이지로 포워딩(switch 문 내에서 저장된 값 활용)
		return viewName;
	}
}
