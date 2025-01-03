package com.itwillbs.goodbuy.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.goodbuy.aop.LoginCheck;
import com.itwillbs.goodbuy.aop.LoginCheck.MemberRole;
import com.itwillbs.goodbuy.service.ProductService;
import com.itwillbs.goodbuy.vo.ProductVO;

import retrofit2.http.GET;

@Controller
public class ProductController {
	@Autowired ProductService productService;
	
	// 이클립스 상의 가상의 업로드 경로명 저장(프로젝트 상에서 보이는 경로)
	private String uploadPath = "/resources/upload";
	
	// 상품목록 조회
	@GetMapping("ProductList")
	public String productList() {
		return "product/product_list";
	}
	
	// 검색필터 AJAX
	@ResponseBody
	@GetMapping("SearchPriceFilter")
	public List<Map<String, Object>> searchPriceFilter(@RequestParam(defaultValue = "99", required=false) int PRODUCT_STATUS,
													   @RequestParam(required=false) String PRODUCT_PRICE,
													   @RequestParam(required=false) String PRODUCT_TRADE_ADR1,
													   @RequestParam String PRODUCT_CATEGORY) {
		List<Map<String, Object>> listSearch = productService.searchFilterList(PRODUCT_STATUS, PRODUCT_PRICE, PRODUCT_TRADE_ADR1, PRODUCT_CATEGORY);
		return listSearch;
	}
	
	// 거래금지 품목 페이지 매핑
	@GetMapping("ProductBanedItem")
	public String productBanedItem() {
		return "product/product_baned_item";
	}
	
	// 상품 등록 페이지 매핑
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("ProductRegist")
	public String productRegist() {
		return "product/product_regi";
	}
	
	// 상품 등록 로직
	@PostMapping("ProductRegist")
	public String productRegistSubmit(ProductVO product, HttpSession session) {
		String id = (String) session.getAttribute("sId");
		
		String realPath = session.getServletContext().getRealPath(uploadPath);
		String subDir = id + "/" + UUID.randomUUID().toString().substring(0, 6);
		
		realPath += "/" + subDir;
		
		try {
			Path path = Paths.get(realPath);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile mFile1 = product.getPic1();
		MultipartFile mFile2 = product.getPic2();
		MultipartFile mFile3 = product.getPic3();
		
		product.setProduct_pic1("");
		product.setProduct_pic2("");
		product.setProduct_pic3("");
		
		String fileName1 = "";
		String fileName2 = "";
		String fileName3 = "";
		
		if(!mFile1.getOriginalFilename().equals("")) {
			fileName1 = UUID.randomUUID().toString().substring(0, 8) + "_" + mFile1.getOriginalFilename();
			product.setProduct_pic1(subDir + "/" + fileName1);;
		}
		if(!mFile2.getOriginalFilename().equals("")) {
			fileName2 = UUID.randomUUID().toString().substring(0, 8) + "_" + mFile2.getOriginalFilename();
			product.setProduct_pic2(subDir + "/" + fileName2);;
		}
		if(!mFile3.getOriginalFilename().equals("")) {
			fileName3 = UUID.randomUUID().toString().substring(0, 8) + "_" + mFile3.getOriginalFilename();
			product.setProduct_pic3(subDir + "/" + fileName3);;
		}
		
		int insertCount = productService.registProduct(product, id);
		
		if(insertCount > 0) {
			try {
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(realPath, fileName1));
				}
				
				if(!mFile2.getOriginalFilename().equals("")) {
					mFile2.transferTo(new File(realPath, fileName2));
				}
				
				if(!mFile3.getOriginalFilename().equals("")) {
					mFile3.transferTo(new File(realPath, fileName3));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return "MySales";
	}
	
	// 상품 상세 페이지
	@GetMapping("ProductDetail")
	public String prodcutDetail(@RequestParam int PRODUCT_ID, Model model, HttpSession session) {
		ProductVO productSearch = productService.productSearch(PRODUCT_ID);
		productService.plusviewcount(PRODUCT_ID);
		model.addAttribute("productSearch", productSearch);
		
		return "product/product_detail";
	}
	
	// 상품 찜하기
	@ResponseBody
	@GetMapping("AddWishlist")
	public String addWishlist() {
		
		return null;
	}
	
	// 상품 신고
	@ResponseBody
	@GetMapping("ItemReporting")
	public String itemReporting(@RequestParam int PRODUCT_ID, @RequestParam String REASON, @RequestParam(required = true) String REPORTER_ID) {
		int result = productService.itemReporting(PRODUCT_ID, REASON, REPORTER_ID);
		
		String msg = "";
		
		if (result > 0) {
			msg = "신고 처리가 접수되었습니다.";
		} else {
			msg = "신고 처리가 실패하였습니다.";
		}
		
		try {
			msg = URLEncoder.encode(msg, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return msg;
	}
	
	@GetMapping("ProductShop")
	public String productShop() {
		return "product/product_shop";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
