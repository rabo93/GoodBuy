package com.itwillbs.goodbuy.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.mapper.ProductMapper;

@Service
public class ProductService {
	@Autowired
	private ProductMapper mapper;

	public int registProduct() {
		return mapper.registProduct();
	}

}
