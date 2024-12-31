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
	//리뷰 갯수 조회
	public int myReviewCount(String id) {
		return mapper.selectReviewCount(id);
	}
	
	//리뷰 등록 저장
	public int saveReviewData(String id, String review, String productTitle, String productId) {
		return mapper.insertReview(id,review,productTitle,productId);
	}
	
	
	
}
