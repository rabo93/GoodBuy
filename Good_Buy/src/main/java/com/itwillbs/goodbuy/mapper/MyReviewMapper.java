package com.itwillbs.goodbuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.goodbuy.vo.MyReviewVO;

@Mapper
public interface MyReviewMapper {
	//리뷰 리스트 조회 
	List<MyReviewVO> selectReview(String id);
	//리뷰 갯수조회
	int selectReviewCount(String id);
	//리뷰저장
	int insertReview(@Param("mem_id") String id
			, @Param("review_content") String review
			, @Param("product_title") String productTitle
			, @Param("product_id") String productId);

}
