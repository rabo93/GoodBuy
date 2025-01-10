package com.itwillbs.goodbuy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.mapper.MyReviewMapper;
import com.itwillbs.goodbuy.vo.MyReviewVO;
import com.itwillbs.goodbuy.vo.ProductVO;

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
//	public int saveReviewData(String id, String review, String productTitle, String productId,String score, String reviewOptions) {
//		return mapper.insertReview(id,review,productTitle,productId,score,reviewOptions );
//	}
	//리뷰 등록 저장
	public int saveReviewData(Map<String, String> reviewData) {
		return mapper.insertReview(reviewData);
	}
	//리뷰 갯수확인(후기버튼 비활성화)
	public int reviewCountCheck(int product_id) {
		return mapper.selectReviewCountCheck(product_id);
	}
	
	//내가 쓴 리뷰
	public List<MyReviewVO> getReviewHistory(int startRow, int listLimit, String id) {
		return mapper.selectReviewHistory(id,startRow,listLimit);
	}
	//내가쓴 리뷰 수정
	public int reviewEdit(String reviewContent,String productId) {
		return mapper.updateReview(reviewContent,productId);
	}
	public int removeReview(int reviewId) {
		return mapper.deleteReview(reviewId);
	}
	
	//나의 별점조회
	public List<Map<String, String>> getScoreCount(String id) {
		return mapper.selectScoreCount(id);
	}
	
	//내가 쓴 리뷰 갯수조회
	public int getReviewHistoryCount(String id) {
		// TODO Auto-generated method stub
		return mapper.selectReviewHistoryCount(id);
	}
	
	
	
}
