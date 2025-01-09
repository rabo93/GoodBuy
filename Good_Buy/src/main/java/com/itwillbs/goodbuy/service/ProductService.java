package com.itwillbs.goodbuy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.goodbuy.mapper.ProductMapper;
import com.itwillbs.goodbuy.vo.ProductOrderVO;
import com.itwillbs.goodbuy.vo.ProductVO;
import com.itwillbs.goodbuy.vo.WishlistVO;

@Service
public class ProductService {
	@Autowired
	private ProductMapper mapper;

	public int registProduct(ProductVO product, String id) {
		return mapper.insertProduct(product, id);
	}
		
	//판매 상품목록 조회
	public List<ProductVO> getProductList(String id) {
		return mapper.selectProductList(id);
	}
	
	//판매 목록 갯수 조회
	public int salesCount(String id) {
		return mapper.salesListCount(id);
	}

	public List<Map<String, Object>> searchProductList(String product_category) {
		return mapper.searchProductList(product_category);
	}
		
	public List<Map<String, String>> getOrderList(String id) {
		return mapper.selectOrderList(id);
	}

	//구매 목록 갯수 조회
	public int orderListCount(String id) {
		return mapper.selectOrderCount(id);
	}
	
	// 검색 필터 AJAX
	public List<Map<String, Object>> searchFilterList(int product_status, 
													  String product_price,
													  String product_trade_adr1,
													  String product_category) {
	    int price_start = 0;
	    int price_end = 0;

	    if (product_price != null) {
	        price_start = Integer.parseInt(product_price.split("_")[0]);
	        price_end = Integer.parseInt(product_price.split("_")[1]);
	    }

	    return mapper.searchFliterList(price_start, price_end, product_status, product_trade_adr1, product_category);
	}
	
	// 상품 상세정보 조회
	public ProductVO productSearch(int product_id) {
		return mapper.productSearch(product_id);
	}
	
	// 상품 신고
	public int itemReporting(int product_id, String reason, String reporter_id) {
		return mapper.itemReporting(product_id, reason, reporter_id);
	}
	
	// 조회수 +1
	public void plusviewcount(int product_id) {
		mapper.plusViewCount(product_id);
	}
	
	// 상세페이지 조회시 찜여부 확인
	public WishlistVO checkWishlist(int product_id, String id) {
		return mapper.checkWishlist(product_id, id);
		
	}
	
	// 상세페이지 같은 판매자 상품목록
	public List<Map<String, Object>> searchSellerProduct(String mem_id, int product_id) {
		return mapper.searchSellerProduct(mem_id, product_id);
	}
	
	// 상세페이지 같은 상품 카테고리 목록
	public List<Map<String, Object>> searchSameCategoryProduct(String product_category, int product_id) {
		return mapper.searchSameCategoryProduct(product_category, product_id);
	}
		
	//판매상품 상위 4개 조회
	public List<ProductVO> getProductListLimit(String id) {
		return mapper.selectLimitProductList(id);
	}

	public Map<String, Object> searchSellerShop(String mem_nick) {
		return mapper.searchSellerShop(mem_nick);
	}

	public List<Map<String, Object>> searchSellerReview(String mem_id) {
		return mapper.searchSellerReview(mem_id);
	}

	public Map<String, Object> productContent(int product_ID) {
		return mapper.productContent(product_ID);
	}

	public int productUpdate(ProductVO product) {
		return mapper.productUpdate(product);
	}

	public ProductVO getProductPic(int product_ID) {
		return mapper.getProductPic(product_ID);
	}

}
