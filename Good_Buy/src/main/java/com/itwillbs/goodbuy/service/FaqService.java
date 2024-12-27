package com.itwillbs.goodbuy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.mapper.FaqMapper;
import com.itwillbs.goodbuy.vo.FaqVO;

@Service
public class FaqService {
	@Autowired
	private FaqMapper mapper;
	
	//	FAQ 목록 가져오기
	public List<FaqVO> getFaqList() {
		return mapper.getFaqList();
	}
	
	//	FAQ 글 쓰기
	public void insertFaq(FaqVO faq) {
		mapper.insertFaq(faq);
	}




}
