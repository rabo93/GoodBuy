package com.itwillbs.goodbuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.goodbuy.vo.FaqVO;

@Mapper
public interface FaqMapper {
	//	FAQ 목록 가져오기
	List<FaqVO> getFaqList();
	
	//	FAQ 글쓰기
	void insertFaq(FaqVO faq);


}
