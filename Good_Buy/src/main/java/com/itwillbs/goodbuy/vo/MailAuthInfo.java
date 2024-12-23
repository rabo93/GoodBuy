package com.itwillbs.goodbuy.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MailAuthInfo {
	private String mem_email;
	private String auth_code;
}
