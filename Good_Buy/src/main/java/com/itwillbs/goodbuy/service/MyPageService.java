package com.itwillbs.goodbuy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.mapper.MypageMapper;
import com.itwillbs.goodbuy.vo.MemberVO;
import com.itwillbs.goodbuy.vo.WishlistVO;

@Service
public class MyPageService {
	@Autowired
	private MypageMapper mapper;
	
	
	//위시리스트 가져오기
	public List<WishlistVO> getWishlist(String id) {
		return mapper.selectWishlist(id);
	}

	//위시리스트 삭제
	public int cancleMyWish(int wishlist_id) {
		return mapper.deleteWish(wishlist_id);
	}

	public int addWishlist(WishlistVO wishlist) {
		return mapper.insertWishlist(wishlist);
	}

	//위시리스트 갯수 세기 
	public int wishlistCount(String id) {
		return mapper.selectWishlistCount(id);
	}

	
}
