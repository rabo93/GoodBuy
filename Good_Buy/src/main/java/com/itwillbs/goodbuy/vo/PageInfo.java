package com.itwillbs.goodbuy.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PageInfo {
	private int listCount;		//	총 게시물 수
	private int pageListLimit;	//	페이지 당 표시할 페이지 번호 갯수
	private int maxPage;		//	전체 페이지 수(= 최대 페이지 번호)
	private int startPage;		// 	현재 페이지의 시작 페이지 번호
	private int endPage;		//	현재 페이지의 끝 페이지 번호
	private int pageNum;		//	현재 페이지 번호
}
