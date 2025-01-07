package com.itwillbs.goodbuy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.goodbuy.vo.ProductOrderVO;
import com.itwillbs.goodbuy.vo.ProductVO;
import com.itwillbs.goodbuy.vo.WishlistVO;

@Mapper
public interface ProductMapper {

	int insertProduct(@Param("vo")ProductVO product, @Param("id")String id);


	int salesListCount(String id);
	
	// 구매내역 조회
	List<ProductVO> selectProductList(String id);
	
	List<ProductOrderVO> selectOrderList(String id);
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
	
	// 상품 상세페이지 조회
	ProductVO productSearch(int product_id);
	
	// 상품 신고
	int itemReporting(
			@Param("product_id")int product_id,
			@Param("reason")String reason,
			@Param("reporter_id")String reporter_id);

	List<ProductVO> selectLimitProductList(String id);
	
// 상품 조회수 증가
	void plusViewCount(int product_id);
	
	// 상품 찜여부 조회
	WishlistVO checkWishlist(@Param("product_id")int product_id, @Param("sId")String id);
	
	// 상품 상세페이지 같은 판매자 상품 조회
	List<Map<String, Object>> searchSellerProduct(@Param("mem_id")String mem_id, @Param("product_id")int product_id);

	// 상품 상세페이지 비슷한 상품 조회
	List<Map<String, Object>> searchSameCategoryProduct(@Param("product_category")String product_category, @Param("product_id")int product_id);

	// 상점페이지 조회
	List<Map<String, Object>> searchSellerList(String mem_id);
}
