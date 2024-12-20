package com.itwillbs.goodbuy.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeVO {
	private int notice_id;
	private String mem_id;
	private String notice_subject;
	private String notice_content;
	private Date notice_date;
	private MultipartFile file;
	private String notice_file;
	private int notice_read_count;
	
}
