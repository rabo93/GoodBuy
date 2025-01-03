package com.itwillbs.goodbuy.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.goodbuy.service.MemberService;
import com.itwillbs.goodbuy.service.MyPageService;
import com.itwillbs.goodbuy.service.MyReviewService;
import com.itwillbs.goodbuy.service.ProductService;
import com.itwillbs.goodbuy.vo.MemberVO;
import com.itwillbs.goodbuy.vo.MyReviewVO;
import com.itwillbs.goodbuy.vo.ProductOrderVO;
import com.itwillbs.goodbuy.vo.ProductVO;
import com.itwillbs.goodbuy.vo.WishlistVO;

import lombok.extern.log4j.Log4j2;
import retrofit2.http.POST;

@Log4j2
@Controller
public class MypageController {
	@Autowired MemberService memberService;
	@Autowired MyPageService myPageService;
	@Autowired ProductService productService;
	@Autowired MyReviewService reviewService;
	
	//세션에 사용자 ID 저장 
	private String getSessionUserId(HttpSession session) {
	    return (String) session.getAttribute("sId");
	}
	
	//[나의상점]
	@GetMapping("MyStore")
	public String myStore(MemberVO member,HttpSession session,Model model) {
		String id = getSessionUserId(session);
		member.setMem_id(id);  // 사용자 ID 설정
		
		//판매내역 조회
		List<ProductVO> productlist =(List<ProductVO>) productService.getProductList(id);
		model.addAttribute("product", productlist);
		System.out.println("상품목록 조회"+productlist);
		
		//판매내역 갯수조회
		int salesCount = productService.salesCount(id);
		model.addAttribute("salesCount", salesCount);
		 
		//나의 리뷰 조회
		List<MyReviewVO> review = reviewService.getReview(id);
		model.addAttribute("review", review);
		
		//나의 리뷰 갯수조회
		int reviewCount = reviewService.myReviewCount(id);
		model.addAttribute("reviewCount", reviewCount);
		
		//기존 상점소개문구
		 MemberVO storeIntro = memberService.getStoreIntro(member);
		 model.addAttribute("storeIntro",storeIntro);
		    
		return "mypage/mypage_store";
		
	}
	@PostMapping("MyStore")
	public String myStoreIntro(Model model, HttpSession session, MemberVO member,HttpServletRequest request) {
		savePreviousUrl(request, session);
		
		String id = (String) session.getAttribute("sId");
		member.setMem_id(id);  // 사용자 ID 설정
		
		int storeIntroCount = memberService.registStoreIntro(member);  // MemberVO 전달
		
		if (storeIntroCount > 0) {
			model.addAttribute("member", member);
			model.addAttribute("msg", "상점소개가 변경되었습니다.");
			System.out.println(member.getMem_intro());
			
			return "result/success";
		} else {
			model.addAttribute("msg", "상점소개 변경 실패!");
			return "result/fail";
		}
	}
	//[나의 구매내역]
	@GetMapping("MyOrder")
	public String myOrder(HttpSession session,Model model) {
		String id = getSessionUserId(session);

		//구매내역 조회
		List<ProductOrderVO> orderList = productService.getOrderList(id);
		model.addAttribute("order", orderList);
		System.out.println("구매내역 조회"+orderList);
		

		//구매내역 갯수조회
		int orderCount = productService.orderListCount(id);
		model.addAttribute("orderCount",orderCount);
		
		//상품목록 조회
//		List<ProductVO> productlist =(List<ProductVO>) productService.getProductList(id);
//		model.addAttribute("product", productlist);
		return "mypage/mypage_product_orders";
	}
	
	//[나의 판매내역] 완
	@GetMapping("MySales")
	public String mySale(Model model,HttpSession session) {
		//세션에 사용자 ID 저장 
		String id = getSessionUserId(session);
		
		//판매내역 조회
		List<ProductVO> productlist =(List<ProductVO>) productService.getProductList(id);
		model.addAttribute("product", productlist);
		System.out.println("상품목록 조회"+productlist);
		
		//판매내역 갯수조회
		int salesCount = productService.salesCount(id);
		model.addAttribute("salesCount", salesCount);
		
		return "mypage/mypage_product_sales";
		
	}
	
	//[나의 리뷰]
	@GetMapping("MyReview")
	public String myReview(HttpSession session,Model model) {
		String id = getSessionUserId(session);
		//나의 리뷰 조회
		List<MyReviewVO> review = reviewService.getReview(id);
		model.addAttribute("review", review);
		
		//나의 리뷰 갯수조회
		int reviewCount = reviewService.myReviewCount(id);
		model.addAttribute("reviewCount", reviewCount);
		
		return "mypage/mypage_review";
	}
	@ResponseBody
	@PostMapping("MyReviewText")
	public String myReviewText(@RequestBody Map<String, String>reviewData,HttpSession session) {
		String review = reviewData.get("review"); // JSON에서 'review' 키로 데이터 받기
		String productTitle = reviewData.get("product_title");
		String productId = reviewData.get("product_id");
//		String review_cnt = reviewData.get("review_cnt");
		String id = getSessionUserId(session);
		
		System.out.println("@@@@@@@@@@@"+review+productId + productTitle);
		int result = reviewService.saveReviewData(id,review,productTitle,productId);
		if(result > 0) {
			return "result/success";
		} else {
			return "result/fail";
			
		}
		
	}

	@GetMapping("MyWish")
	public String myWish(HttpSession session, Model model, HttpServletRequest request) {
	    savePreviousUrl(request, session);

	    // 세션에서 사용자 ID 가져오기
	    String id = getSessionUserId(session);
	    System.out.println("세션 ID: " + id);

	    // 위시리스트 조회
	    List<WishlistVO> wishlist = myPageService.getWishlist(id);
	    System.out.println("위시리스트: " + wishlist);
	    model.addAttribute("wishlist", wishlist);

	    // 위시리스트 개수 조회
	    int wishlistCount = myPageService.wishlistCount(id);
	    
	    model.addAttribute("wishlistCount", wishlistCount);
	    System.out.println("위시리스트 갯수: " + wishlistCount);

	    return "mypage/mypage_wishlist";
	}
	
	
	//[관심목록 추가]
	@GetMapping("MyWishAdd")
	public String myWishAdd(WishlistVO wishlist,HttpServletRequest request,HttpSession session ,Model model) {
		String id = getSessionUserId(session);
		wishlist.setMem_id(id);
		
		int insertCount = myPageService.addWishlist(wishlist);
		if(insertCount > 0) {
			
		}else {
			model.addAttribute("msg", "위시리스트 등록 실패!");
			return "result/fail";
		}
		
		return "";
	}
	
	//[관심목록 삭제] 완
	@PostMapping("MyWishDel")
	public String myWishDel(String wishlist_id,HttpServletRequest request,HttpSession session,Model model){
		System.out.println("위시리스트 아이디 : "+wishlist_id);
		
		int deleteCount = myPageService.cancleMyWish(wishlist_id);
		
		if(deleteCount > 0) {
			if(session.getAttribute("prevURL") == null) {
				return "redirect:/";
			} else {
				return "redirect:" + session.getAttribute("prevURL");
			}
		} else {
			model.addAttribute("msg", "삭제 실패!");
			return "result/fail";
		}
	}
	
	//내가 쓴 후기
	@GetMapping("MyReviewHistory")
	public String myReviewHistory(Model model,HttpSession session,MemberVO member) {
		String id = getSessionUserId(session);
		member.setMem_id(id);
		
		
		List<MyReviewVO> reviewHistory = reviewService.getReviewHistory(id);
		model.addAttribute("review",reviewHistory);
		
		
		return "mypage/mypage_review_history";
	}
	
	
	// ===========================================================================================
	// 이전 페이지 이동 저장
	private void savePreviousUrl(HttpServletRequest request, HttpSession session) {
		String prevURL = request.getServletPath();
		String queryString = request.getQueryString();
//			System.out.println("prevURL : " + prevURL);
//			System.out.println("queryString : " + queryString);
		
		if (queryString != null) {
			prevURL += "?" + queryString;
		}
		
		session.setAttribute("prevURL", prevURL);
	}

}