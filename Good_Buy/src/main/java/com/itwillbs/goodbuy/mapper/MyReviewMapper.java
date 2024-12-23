package com.itwillbs.goodbuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.goodbuy.vo.MyReviewVO;

@Mapper
public interface MyReviewMapper {
	//리뷰 리스트 조회 
	List<MyReviewVO> selectReview(String id);

}
