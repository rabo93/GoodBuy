package com.itwillbs.goodbuy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.goodbuy.vo.ProductVO;

@Mapper
public interface ProductMapper {

	int insertProduct(@Param("vo")ProductVO product, @Param("id")String id);


	int salesListCount(String id);
	
	// 구매내역 조회
	List<ProductVO> selectProductList(String id);
	
	List<ProductVO> selectOrderList(String id);
	// 구매내역 갯수 조회
	int selectOrderCount(String id);
	
	// 카테고리별 상품목록 조회
	List<Map<String, Object>> searchProductList(String product_category);
	
	// 필터별 상품목록 조회
	List<Map<String, Object>> searchFliterList(
			@Param("price_start")int price_start, 
			@Param("price_end")int price_end, 
			@Param("product_status")int product_status, 
			@Param("product_trade_adr1")String product_trade_adr1,
			@Param("cate")String product_category);

	ProductVO productSearch(int product_id);
}
