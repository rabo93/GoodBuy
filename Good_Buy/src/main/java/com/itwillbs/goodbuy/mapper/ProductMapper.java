package com.itwillbs.goodbuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.goodbuy.vo.ProductVO;

@Mapper
public interface ProductMapper {

	int registProduct(@Param("product") ProductVO product, String id);

	List<ProductVO> selectProductList(String id);

	int salesListCount(String id);
	
}
