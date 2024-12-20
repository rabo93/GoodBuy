package com.itwillbs.goodbuy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.mapper.MypageMapper;
import com.itwillbs.goodbuy.vo.WishlistVO;

@Service
public class MyPageService {
	@Autowired
	private MypageMapper mapper;
	
	
	//위시리스트 가져오기
	public List<WishlistVO> getWishlist(String id) {
		return mapper.selectWishlist(id);
	}
	
}
