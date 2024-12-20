package com.itwillbs.goodbuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.goodbuy.vo.WishlistVO;

@Mapper
public interface MypageMapper {
	
	//위시리스트
	List<WishlistVO> selectWishlist(String id);

}
