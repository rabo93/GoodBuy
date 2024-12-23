package com.itwillbs.goodbuy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.goodbuy.service.ProductService;
import com.itwillbs.goodbuy.vo.ProductVO;

@Controller
public class ProductController {
	@Autowired ProductService productService;
	
	@GetMapping("ProductList")
	public String productList() {
		return "product/product_list";
	}
	
	@GetMapping("ProductBanedItem")
	public String productBanedItem() {
		return "product/product_baned_item";
	}
	
	@GetMapping("ProductRegist")
	public String productRegist() {
		return "product/product_regi";
	}
	
	@PostMapping("ProductRegist")
	public String productRegistSubmit() {
		int uploadItem = productService.registProduct();
		
		return "";
	}
	
	@GetMapping("ProductDetail")
	public String prodcutDetail() {
		return "product/product_detail";
	}
	
	@GetMapping("ProductShop")
	public String productShop() {
		return "product/product_shop";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
