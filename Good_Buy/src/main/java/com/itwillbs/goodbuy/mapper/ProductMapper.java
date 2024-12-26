package com.itwillbs.goodbuy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.goodbuy.vo.ProductVO;

@Mapper
public interface ProductMapper {

	int insertProduct(@Param("vo")ProductVO product, @Param("id")String id);

	List<ProductVO> selectProductList(String id);

	int salesListCount(String id);

	List<Map<String, Object>> searchProductList(String pRODUCT_CATEGORY);
	
	List<ProductVO> selectOrderList(String id);
	
}
