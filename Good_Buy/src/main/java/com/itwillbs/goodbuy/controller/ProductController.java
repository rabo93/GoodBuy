package com.itwillbs.goodbuy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.goodbuy.service.ProductService;

@Controller
public class ProductController {
	@Autowired ProductService productService;
	
	@GetMapping("ProductList")
	public String productList() {
		return "product/product_list";
	}
	
	@GetMapping("ProductRegist")
	public String productRegist() {
		return "product/product_regi";
	}
	
	@GetMapping("ProductDetail")
	public String prodcutDetail() {
		return "product/product_detail";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
