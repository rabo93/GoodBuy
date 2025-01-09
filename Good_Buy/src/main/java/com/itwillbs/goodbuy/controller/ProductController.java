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
import com.itwillbs.goodbuy.vo.WishlistVO;

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
		
		MultipartFile[] mFiles = {product.getPic1(), product.getPic2(), product.getPic3()};
		String[] fileNames = {"", "", ""};
		String[] productPics = {"", "", ""};

		product.setProduct_pic1("");
		product.setProduct_pic2("");
		product.setProduct_pic3("");

		for (int i = 0; i < mFiles.length; i++) {
		    if (!mFiles[i].getOriginalFilename().equals("")) {
		        fileNames[i] = UUID.randomUUID().toString().substring(0, 8) + "_" + mFiles[i].getOriginalFilename();
		        productPics[i] = subDir + "/" + fileNames[i];
		    }
		}

		product.setProduct_pic1(productPics[0]);
		product.setProduct_pic2(productPics[1]);
		product.setProduct_pic3(productPics[2]);
		
		int insertCount = productService.registProduct(product, id);
		
		if (insertCount > 0) {
		    try {
		        for (int i = 0; i < mFiles.length; i++) {
		            if (!mFiles[i].getOriginalFilename().equals("")) {
		                mFiles[i].transferTo(new File(realPath, fileNames[i]));
		            }
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
		String id = (String) session.getAttribute("sId");
		ProductVO productSearch = productService.productSearch(PRODUCT_ID);
		WishlistVO wishSearch = productService.checkWishlist(PRODUCT_ID, id);
		
		List<Map<String, Object>> searchSellerProduct = productService.searchSellerProduct(productSearch.getMem_id(), PRODUCT_ID);
		List<Map<String, Object>> searchSameCategoryProduct = productService.searchSameCategoryProduct(productSearch.getProduct_category(), PRODUCT_ID);
		
		productService.plusviewcount(PRODUCT_ID);
		model.addAttribute("productSearch", productSearch);
		model.addAttribute("wishSearch", wishSearch);
		model.addAttribute("searchSellerProduct", searchSellerProduct);
		model.addAttribute("searchSameCategoryProduct", searchSameCategoryProduct);
		
		return "product/product_detail";
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
	
	// 개인상점페이지 매핑
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("ProductShop")
	public String productShop(@RequestParam String MEM_NICK, Model model) {
		Map<String, Object> searchSeller = productService.searchSellerShop(MEM_NICK);
		List<ProductVO> searchSellerProduct = (List<ProductVO>) productService.getProductListLimit(searchSeller.get("MEM_ID").toString());
		List<Map<String, Object>> searchSellerReview = productService.searchSellerReview(searchSeller.get("MEM_ID").toString());
		model.addAttribute("searchSeller", searchSeller);
		model.addAttribute("searchSellerProduct", searchSellerProduct);
		model.addAttribute("searchSellerReview", searchSellerReview);
		return "product/product_shop";
	}
	
	// 상품수정 매핑
	@LoginCheck(memberRole = MemberRole.USER)
	@GetMapping("ProductEdit")
	public String ProductEdit(@RequestParam("Product_ID")int product_ID, HttpSession session, Model model) {
		Map<String, Object> productContent = productService.productContent(product_ID);
		String sId = (String) session.getAttribute("sId");
		
		if (sId.equals(productContent.get("MEM_ID").toString())) {
			model.addAttribute("productContent", productContent);
			return "product/product_edit";
		} else {
			model.addAttribute("msg", "접근권한이 없습니다!");
			return "result/fail";
		}
	}
	
	@PostMapping("ProductEditing")
	public String productEditing(HttpSession session, ProductVO product, Model model,
								 @RequestParam("pic1") MultipartFile pic1,
								 @RequestParam("pic2") MultipartFile pic2,
								 @RequestParam("pic3") MultipartFile pic3,
								 @RequestParam("Product_ID")int product_ID) {
		String id = (String) session.getAttribute("sId");
		String realPath = session.getServletContext().getRealPath(uploadPath);
		String subDir = id + "/" + UUID.randomUUID().toString().substring(0, 6);
		
		realPath += "/" + subDir;

	    try {
	        // 기존 파일 경로 가져오기
	    	ProductVO getProductPic = productService.getProductPic(product_ID);
	        String oldFileName1 = getProductPic.getProduct_pic1();
	        String oldFileName2 = getProductPic.getProduct_pic2();
	        String oldFileName3 = getProductPic.getProduct_pic3();
	        
	        if (!pic1.isEmpty()) {
	            // 기존 파일 삭제 로직
	            if (oldFileName1 != null && !oldFileName1.isEmpty()) {
	                File oldFile = new File(realPath, oldFileName1);
	                if (oldFile.exists()) {
	                    oldFile.delete();
	                }
	            }
	            if (oldFileName2 != null && !oldFileName2.isEmpty()) {
	            	File oldFile = new File(realPath, oldFileName2);
	            	if (oldFile.exists()) {
	            		oldFile.delete();
	            	}
	            }
	            if (oldFileName3 != null && !oldFileName3.isEmpty()) {
	            	File oldFile = new File(realPath, oldFileName3);
	            	if (oldFile.exists()) {
	            		oldFile.delete();
	            	}
	            }
	            
	            // 새 파일 저장 로직
	            String newFileName1 = UUID.randomUUID().toString().substring(0, 8) + "_" + pic1.getOriginalFilename();
	            String newFileName2 = UUID.randomUUID().toString().substring(0, 8) + "_" + pic2.getOriginalFilename();
	            String newFileName3 = UUID.randomUUID().toString().substring(0, 8) + "_" + pic3.getOriginalFilename();
	            
	            String newFilePath1 = subDir + "/" + newFileName1;
	            String newFilePath2 = subDir + "/" + newFileName2;
	            String newFilePath3 = subDir + "/" + newFileName3;
	            
	            pic1.transferTo(new File(realPath, newFilePath1));
	            pic2.transferTo(new File(realPath, newFilePath2));
	            pic3.transferTo(new File(realPath, newFilePath3));
	            
	            product.setProduct_pic1(newFilePath1);
	            product.setProduct_pic2(newFilePath2);
	            product.setProduct_pic3(newFilePath3);
	        } else {
	            // 새로운 파일이 없는 경우 기존 파일 경로 유지
	            product.setProduct_pic1(oldFileName1);
	            product.setProduct_pic1(oldFileName2);
	            product.setProduct_pic1(oldFileName3);
	        }
	    } catch (IllegalStateException | IOException e) {
	        e.printStackTrace();
	    }
	    
	    int updateStatus = productService.productUpdate(product);
	    
	    if (updateStatus < 0) {
			model.addAttribute("msg", "클래스 수정 실패!");
			return "admin/fail";
		}
		
		return "MySales";
	}

	
}

