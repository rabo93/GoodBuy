package com.itwillbs.goodbuy.vo;

import lombok.Data;

@Data
public class SupportVO {
	private int support_id;                 // 문의 글 번호
    private String support_date;            // 작성 일자 (DATETIME)
    private int support_category;           // 문의 카테고리
    private String mem_id;                  // 작성자 ID
    private String support_subject;         // 문의 글 제목
    private String support_content;         // 문의 글 내용
    private String support_answer_date;     // 답변 일자 (DATE)
    private String support_answer_subject;  // 답변 글 제목
    private String support_answer_content;  // 답변 글 내용
    private String support_file;            // 첨부파일

}
