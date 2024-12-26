package com.itwillbs.goodbuy.handler;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

//금융결제원 API 에서 사용할 다양한 값을 생성하는 용도의 클래스 정의
public class PayValueGenerator {
	// 거래고유번호(참가기관) 자동 생성을 위한 메서드
	// => 형식 : 이용기관코드(10자리) + 생성주체구분코드("U") + 이용기관 부여번호(9자리)
	public static String getBankTranId(String client_use_code) {
		String bank_tran_id = "";
		
		// 이용기관 부여번호(9자리) 생성 => 난수 활용
		// 미리 정의해 놓은 GenerateRandomCode - getRandomCode(int) 메서드 재사용
		//    AN = 알파벳 + 숫자 조합이라는 의미이며 반드시 알파벳은 대문자로 표기되어야 함
		bank_tran_id = client_use_code + "U" + GenerateRandomCode.getRandomCode(9).toUpperCase();
		
		return bank_tran_id;
	}

	// 작업요청일시(거래시간 등) 자동 생성을 위한 메서드
	// 현재 시스템 날짜 및 시각 기준 14자리 숫자로 된 문자열 생성(yyyyMMddHHmmss 형식 - 포맷팅 필요)
	// => java.time.LocalDateTime 클래스 활용 
	public static String getTranDTime() {
		LocalDateTime localDateTime = LocalDateTime.now();
		
		// LocalXXX 클래스에 대한 포맷팅(형식 지정) 전용 클래스인
		// java.time.DateTimeFormatter 의 static 메서드이 ofPattern() 메서드 호출
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		
		// LocalDateTime 객체의 format() 메서드 호출하여 포맷 문자열을 파라미터로 전달하여
		// 지정된 포맷으로 날짜 및 시각을 변환 후 변환된 문자열을 그대로 리턴
		return localDateTime.format(dateTimeFormatter);
	}
}
