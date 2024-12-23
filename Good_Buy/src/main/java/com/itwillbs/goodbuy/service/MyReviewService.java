package com.itwillbs.goodbuy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.mapper.MyReviewMapper;
import com.itwillbs.goodbuy.vo.MyReviewVO;

@Service
public class MyReviewService {
	@Autowired MyReviewMapper mapper;

	public List<MyReviewVO> getReview(String id) {
		return mapper.selectReview(id);
	}
	
	
	
}
