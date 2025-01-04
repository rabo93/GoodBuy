package com.itwillbs.goodbuy.vo;

import lombok.Data;

@Data
public class SupportVO {
	private int support_id;                 // 문의 글 번호
	private int support_category;           // 문의 카테고리
    private String support_date;            // 작성 일자 (DATETIME)
    private String mem_id;                  // 작성자 ID
    private String support_subject;         // 문의 글 제목
    private String support_content;         // 문의 글 내용
    private String support_file;            // 첨부파일
    private String reply_date;     			// 답변 일자 (DATETIME)
    private String reply_content;  			// 답변 글 내용
    private String statsus;					// 처리상태(ENUM) '접수','처리완료','기각'
}


//CREATE TABLE SUPPORT (
//    SUPPORT_ID INT AUTO_INCREMENT PRIMARY KEY,  	-- 문의 글 번호 (기본 키)
//    SUPPORT_CATEGORY INT ,             			-- 문의 카테고리
//    SUPPORT_DATE DATETIME DEFAULT CURRENT_TIMESTAMP, -- 작성 일자
//    MEM_ID VARCHAR(50) ,               			-- 작성자 ID
//    SUPPORT_SUBJECT VARCHAR(100) ,     			-- 문의 글 제목
//    SUPPORT_CONTENT VARCHAR(3000),    			-- 문의 글 내용
//    SUPPORT_FILE VARCHAR(1000),                	-- 첨부파일 (파일 첨부는 1개만 가능)
//    REPLY_DATE DATETIME, 							-- 답변 일자
//    REPLY_CONTENT VARCHAR(3000),               	-- 답변 글 내용
//    STATUS ENUM('접수', '처리완료', '기각')  DEFAULT '접수'   -- 처리 상태
//);