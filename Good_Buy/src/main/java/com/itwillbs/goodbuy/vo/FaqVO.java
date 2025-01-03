package com.itwillbs.goodbuy.vo;

import lombok.Data;

@Data
public class FaqVO {
	private int faq_id;
	private String faq_subject;
	private String faq_content;
	private int faq_cate;
	private int list_status;
}
