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

	// 상품 등록시 새상품ID조회
	int newProductId();
	
	// 상품 등록
	int insertProduct(@Param("vo")ProductVO product, @Param("sId")String sId);

	int salesListCount(String id);
	
	// 구매내역 조회
	List<ProductVO> selectProductList(String id);
	
	List<Map<String, String>> selectOrderList(String id);
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
			@Param("search_keyword")String search_keyword,
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
	Map<String, Object> searchSellerShop(String mem_nick);
	
	// 셀러리뷰 목록 조회
	List<Map<String, Object>> searchSellerReview(String mem_id);

	// 상품수정페이지 상품정보 조회
	Map<String, Object> productContent(int product_ID);

	// 상품수정 로직
	Object productUpdate(@Param("vo")ProductVO product, @Param("product_id")int product_ID);

	// 상품수정시 원본 이미지 가져오기
	ProductVO getProductPic(int product_ID);
	
	// 상품삭제
	int productRemove(int product_ID);
	
	// 판매자 리뷰 갯수 조회
	Map<String, Object> searchSellerScore(String mem_id);
	
	// 헤더 카테고리 가져오기
	List<Map<String, String>> cateSearch();

	// 메인화면 추천상품 가져오기
	List<Map<String, Object>> getRecommendedItem();
	// 구매확정 버튼
	int updateProductStatus(
			@Param("product_id") String product_id,
			@Param("mem_id") String product_seller);
}
