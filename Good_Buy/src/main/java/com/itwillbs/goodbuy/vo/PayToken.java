package com.itwillbs.goodbuy.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class PayToken implements Serializable {
	// -------------------------------------------------------
	// 사용자 아이디 정보s
	private String id;
	// -------------------------------------------------------
	// 엑세스토큰 관련 정보
	private String access_token;
	private String token_type;
	private int expires_in;
	private String refresh_token;
	private String scope;
	private String user_seq_no;
	// -------------------------------------------------------
	// 토큰 발급 요청 과정에서 오류 발생 시 응답 메세지의 오류 정보
	private String rsp_code;
	private String rsp_message;
	// -------------------------------------------------------
	// private String fintech_use_num;
	// -------------------------------------------------------
}
