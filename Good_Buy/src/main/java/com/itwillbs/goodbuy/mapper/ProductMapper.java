package com.itwillbs.goodbuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.goodbuy.vo.ProductVO;

@Mapper
public interface ProductMapper {

	List<ProductVO> selectProductList(String id);

	int salesListCount(String id);
	
}
