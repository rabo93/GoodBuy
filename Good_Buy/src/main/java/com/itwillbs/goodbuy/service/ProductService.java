package com.itwillbs.goodbuy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.mapper.ProductMapper;

import com.itwillbs.goodbuy.vo.ProductVO;

@Service
public class ProductService {
	@Autowired
	private ProductMapper mapper;

	public int registProduct(ProductVO product, String id) {
		return mapper.registProduct(product, id);
	}
		
	//판매 상품목록 조회
	public List<ProductVO> getProductList(String id) {
		return mapper.selectProductList(id);
	}
	
	//판매 목록 갯수 조회
	public int salesCount(String id) {
		return mapper.salesListCount(id);
	}

	public List<ProductVO> getOrderList(String id) {
		return mapper.selectOrderList(id);
	}

}
