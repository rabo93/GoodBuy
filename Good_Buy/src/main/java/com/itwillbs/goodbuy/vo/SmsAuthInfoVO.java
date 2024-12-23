package com.itwillbs.goodbuy.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class SmsAuthInfoVO {
	private int sms_idx;
	private String mem_phone;
	private String auth_code;	// 인증번호
	private String mem_id;
	private Date auth_date;
	private int status;			// 0: 인증 대기 / 1: 인증완료 / 2: 재인증
}
