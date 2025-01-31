package com.itwillbs.goodbuy.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.itwillbs.goodbuy.service.MemberService;
import com.itwillbs.goodbuy.service.MyPageService;
import com.itwillbs.goodbuy.service.MyReviewService;
import com.itwillbs.goodbuy.service.ProductService;
import com.itwillbs.goodbuy.service.SupportService;
import com.itwillbs.goodbuy.vo.MemberVO;
import com.itwillbs.goodbuy.vo.MyReviewVO;
import com.itwillbs.goodbuy.vo.PageInfo;
import com.itwillbs.goodbuy.vo.ProductOrderVO;
import com.itwillbs.goodbuy.vo.ProductVO;
import com.itwillbs.goodbuy.vo.SupportVO;
import com.itwillbs.goodbuy.vo.WishlistVO;

import kotlinx.serialization.descriptors.StructureKind.MAP;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class MypageController {
	@Autowired MemberService memberService;
	@Autowired MyPageService myPageService;
	@Autowired ProductService productService;
	@Autowired MyReviewService reviewService;
	@Autowired SupportService supportService;

	// 첨부파일 가상경로
	private String uploadPath = "/resources/upload";
	
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
		List<ProductVO> productlist =(List<ProductVO>) productService.getProductListLimit(id);
		
		System.out.println("productlist 잘 나오나 보자.  :  " + productlist);
		
//		List<ProductVO> productlist =(List<ProductVO>) productService.getProductList(id);
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
		
		//나의 별점조회
		List<Map<String, String>> scoreCount = reviewService.getScoreCount(id);
		model.addAttribute("scoreCount",scoreCount);
		System.out.println(">>>>"+scoreCount);
		
//		boolean is왕관Visible = false;
//		for (Map<String, String> map : scoreCount) {
//			if (Integer.parseInt(map.get("REVIEW_SCORE")) == 2 && map. >= 3) {
//				is왕관Visible = true;
//				break;
//			}
//		}
		// goodStoreCnt
		
		
		//별점 3개 이상인 상점 조회
		Map<String, String> goodStore = reviewService.goodStore(id);
		model.addAttribute("goodStore", goodStore);
		
		
		//기존 상점소개문구
		 MemberVO storeIntro = memberService.getStoreIntro(member);
		 model.addAttribute("storeIntro",storeIntro);
		    
		return "mypage/mypage_store";
		
	}
	
	@ResponseBody
	@PostMapping("MyStoreIntro")
		public String myStoreIntro(@RequestParam String mem_intro,Model model, HttpSession session, MemberVO member,HttpServletRequest request) {
		
		String msg = "";
		savePreviousUrl(request, session);
		String id = (String) session.getAttribute("sId");
		
		member.setMem_id(id);  // 사용자 ID 설정
//		member.setMem_intro(map.get("mem_intro"));
		member.setMem_intro(mem_intro);
//		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>"+mem_intro);
		int storeIntroCount = memberService.registStoreIntro(member);  // MemberVO 전달
		
		if (storeIntroCount > 0) { // 저장 성공
			msg = "상점소개가 수정되었습니다!";
		} else { // 저장 실패
			msg = "상점소개 변경에 오류가 발생했습니다.\n다시 시도해주세요";
		}
		return new Gson().toJson(msg);
	}
	//[나의 구매내역]
	@GetMapping("MyOrder")
	public String myOrder(HttpSession session,Model model) {
		String id = getSessionUserId(session);

		//구매내역 조회
		List<Map<String, String>> orderList = productService.getOrderList(id);
		
		model.addAttribute("order", orderList);
		
		//구매내역 갯수조회
		int orderCount = productService.orderListCount(id);
		model.addAttribute("orderCount",orderCount);
		
		//상품목록 조회
//		List<ProductVO> productlist =(List<ProductVO>) productService.getProductList(id);
//		model.addAttribute("product", productlist);
		return "mypage/mypage_product_orders";
	}
	
	//[관심목록 삭제] 완
	@PostMapping("MyWishDel")
	public String myWishDel(@RequestParam("wishlist_id") int wishlist_id,HttpServletRequest request,HttpSession session,Model model){
		System.out.println("위시리스트 아이디 : "+wishlist_id);
		
		int deleteCount = myPageService.cancleMyWish(wishlist_id);
		String prevURL = (String) session.getAttribute("prevURL");
		String red = "redirect:";
		
		if(deleteCount <= 0) {
			model.addAttribute("msg", "삭제 실패!");
			return red;
		}
		
		 red += (prevURL == null) ? "/" : prevURL;
		    return red;
				
//		if(deleteCount > 0) {
//			if(prevURL == null) {
//				return "redirect:/";
//			} else {
//				return "redirect:" + prevURL;
//			}
//		} else {
//			model.addAttribute("msg", "삭제 실패!");
//			return "result/fail";
//		}
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
		List<MyReviewVO> review = reviewService.getReviewAll(id);
		model.addAttribute("review", review);
		
		//나의 리뷰 갯수조회
		int reviewCount = reviewService.myReviewCount(id);
		model.addAttribute("reviewCount", reviewCount);
		
		return "mypage/mypage_review";
	}
	@ResponseBody
	@PostMapping("MyReviewText")
	public String myReviewText(@RequestBody Map<String, String>reviewData,HttpSession session) {
		String id = getSessionUserId(session);
		reviewData.put("mem_id", id);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>review_data"+reviewData);
		
//		int result = reviewService.saveReviewData(id,review,productTitle,productId,score,reviewOptions);
		int result = reviewService.saveReviewData(reviewData);
		if(result > 0) {
//			int reviewScore = reviewService.addReviewCount(reviewData);
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
	@ResponseBody
	@GetMapping("MyWishAdd")
	public String myWishAdd(@RequestParam String MEM_ID,
							@RequestParam int PRODUCT_ID,
							@RequestParam String PRODUCT_TITLE,
							WishlistVO wishlist, Model model) {
		
		wishlist.setMem_id(MEM_ID);
		wishlist.setProduct_id(PRODUCT_ID);
		wishlist.setProduct_title(PRODUCT_TITLE);
		
		int insertCount = myPageService.addWishlist(wishlist);
			
		String msg = "";
		
		if (insertCount > 0) {
			msg = "찜목록에 추가되었습니다!";
		} else {
			msg = "찜하기가 실패하였습니다.\n나중에 다시 시도해주세요.";
		}
		
		try {
			msg = URLEncoder.encode(msg, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return msg;
	}
	
	//내가 쓴 후기 조회
	@GetMapping("MyReviewHistory")
	public String myReviewHistory(
			@RequestParam(defaultValue = "1") int pageNum
			,@RequestParam(defaultValue = "") String searchKeyword
			,Model model,HttpSession session,MemberVO member) {
			String id = getSessionUserId(session);
			
		member.setMem_id(id);
		
		// 페이징 설정
		int listLimit = 3; // 한 페이지당 게시물 수
		int startRow = (pageNum - 1) * listLimit;
		int listCount = reviewService.getReviewHistoryCount(id);

		int pageListLimit = 5; // 페이징 개수 
		int maxPage = (listCount / listLimit) + (listCount % listLimit > 0 ? 1 : 0);

		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		System.out.println("maxPage = " + maxPage);
		int endPage = startPage + pageListLimit - 1;

		if(endPage > maxPage) {
			endPage = maxPage;
		}

		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
			model.addAttribute("targetURL", "MyReviewHistory?pageNum=1");
			return "result/fail";
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);

		// Model 객체에 페이징 정보 저장
		model.addAttribute("pageInfo", pageInfo);

		// 게시물 목록 조회
		List<MyReviewVO> reviewHistory = reviewService.getReviewHistory(startRow, listLimit,id,searchKeyword);
		model.addAttribute("review",reviewHistory);

		
		return "mypage/mypage_review_history";
	}
	

	
	//내가쓴 후기 수정
		@ResponseBody
		@PostMapping("MyReviewEdit")
		public String myReviewEdit(SupportVO support,Model model,@RequestBody Map<String, String>reviewData,HttpSession session) {
			
			model.addAttribute("support", support);
			
			addFileToModel(support, model);
			String reviewContent = reviewData.get("review"); //모달창에서 입력한 review_content
			String productId = reviewData.get("product_id");
			String id = getSessionUserId(session);

			int result = reviewService.reviewEdit(reviewContent,productId);
			if(result > 0) {
				return "result/success";
			}
			return"result/fail";
		}

		//내가쓴 후기 삭제
		@ResponseBody
		@PostMapping("DeleteReview")
		public String deleteReview(int reviewId, HttpSession session) {
			int result = reviewService.removeReview(reviewId);
			if(result > 0) {
				return "result/success";
			}
			return"result/fail";
		}


		// 문의내역 목록
			@GetMapping("MySupport")
			public String mySupportList(
					@RequestParam(defaultValue = "1") int pageNum
					,@RequestParam(defaultValue = "") String searchKeyword
					, HttpServletRequest request
					, HttpSession session, Model model) {
				
				System.out.println("페이지번호: " + pageNum);
				// 세션아이디 체크
				String id = (String)session.getAttribute("sId");
				if(id == null) {
					model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
					model.addAttribute("targetURL", "MemberLogin");
					savePreviousUrl(request, session);

					return "result/fail";
				}

				// 페이징 설정
				int listLimit = 10; // 한 페이지당 게시물 수
				int startRow = (pageNum - 1) * listLimit;
				int listCount = supportService.getSupportListCount(id);

				int pageListLimit = 5; // 페이징 개수 
				int maxPage = (listCount / listLimit) + (listCount % listLimit > 0 ? 1 : 0);

				if(maxPage == 0) {
					maxPage = 1;
				}
				int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
				System.out.println("maxPage = " + maxPage);
				int endPage = startPage + pageListLimit - 1;

				if(endPage > maxPage) {
					endPage = maxPage;
				}

				if(pageNum < 1 || pageNum > maxPage) {
					model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
					model.addAttribute("targetURL", "MySupport?pageNum=1");
					return "result/fail";
				}
				PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);

				// Model 객체에 페이징 정보 저장
				model.addAttribute("pageInfo", pageInfo);

				// 게시물 목록 조회
				List<SupportVO> supportList = supportService.getSupporList(startRow, listLimit, id,searchKeyword);

				model.addAttribute("supportList", supportList);

				return "mypage/mypage_inquiry_list";
			}

		//문의사항 자세히 보기
		@GetMapping("MySupportDetail")
		public String mySupportDetail(int support_id, Model model) {
			SupportVO support = supportService.getSupportDetail(support_id);

			if(support == null) {
				model.addAttribute("msg", "존재하지 않는 게시물입니다");
				return "result/fail";
			}

			addFileToModel(support, model); //첨부파일
			model.addAttribute("support", support);

			return "mypage/mypage_inquiry_detail";
		}
		
		//문의내역 글쓰기 폼
		@GetMapping("MySupportWrite")
		public String mySupportWriteFrom(HttpSession session,Model model) {
			String id = getSessionUserId(session);

			return "mypage/mypage_inquiry_wirte";
		}
		//문의내역 글쓰기
		@PostMapping("MySupportWrite")
		public String mySupportWrite(HttpSession session,Model model,SupportVO support) {
			String id = getSessionUserId(session);
			support.setMem_id(id);
			// 파일 첨부 업로드 경로 처리
			String realPath = getRealPath(session);
			System.out.println(">>>>>>>>>>>>>>>>>"+realPath);
			// 디렉토리 생성
			String subDir = createDirectories(realPath);

			realPath += "/" + subDir;

			// 실제 파일 처리
			MultipartFile mFile1 = support.getFile1();
			System.out.println("원본파일명: " + mFile1);
			support.setSupport_file1("");

			String fileName = processDuplicateFileName(support, subDir);

			System.out.println("------- DB 저장파일" + support.getSupport_file1());
			System.out.println("-------- 1:1문의 글 작성 최종내용: " + support);

			// 글쓰기 서비스 요청
			int insertCount = supportService.registSupport(support);

			if (insertCount > 0) {
				completeUpload(support, realPath, fileName);
				System.out.println();

				return "redirect:/MySupport";
			} else {
				model.addAttribute("msg", "글쓰기 실패!");
				return "result/fail";
			}

		}

		//문의사항 삭제
		@ResponseBody
		@PostMapping("ConfirmDelete")
		public String confirmDelete(HttpSession session,Model model,int support_id) {
			String id = getSessionUserId(session);

			int result = supportService.removeSupport(support_id);
			if(result > 0) {
				return "result/success";
			}
			return "result/fail";
		}

		//문의사항 수정
		@GetMapping("RequestModify")
		public String requestModify(HttpSession session,int support_id,Model model) {

			String id = getSessionUserId(session);
			SupportVO support = supportService.getSupportDetail(support_id);
			model.addAttribute("support",support);
			addFileToModel(support, model);
			return "mypage/mypage_inquiry_update";
		}

		//문의사항 수정폼
		@PostMapping("RequestModifyForm")
		public String requestModifyForm(HttpSession session,Model model,SupportVO support) {
			String id = getSessionUserId(session);

			String realPath = getRealPath(session);
			String subDir = createDirectories(realPath);
			realPath += "/" + subDir;
			
			String fileName = processDuplicateFileName(support, subDir);

			int result = supportService.EditSupport(support);
			if(result > 0 ) {
				return "redirect:/MySupportDetail?support_id="+support.getSupport_id();
			}
			return "result/fail";
		}
		
		// 문의내역 수정 시 첨부파일 삭제
		@ResponseBody
		@PostMapping("MySupportDeleteFile")
		public String mySupportDeleteFile(@RequestParam Map<String, String> map, HttpSession session) {
			
			int deleteCount = supportService.removeSupportFile(map);
			
			if(deleteCount > 0) {
				String realPath = session.getServletContext().getRealPath(uploadPath);
				System.out.println(realPath);
				
				if(!map.get("file").equals("")) {
					Path path = Paths.get(realPath, map.get("file"));
					try {
						Files.deleteIfExists(path);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			return "true";
		}
		
		
		//[구매확정 버튼]
		@ResponseBody
		@PostMapping("SuccessOrder")
		public String successOrder(@RequestParam Map<String, String>map,HttpSession session) {
			String product_id = map.get("product_id");
			String product_seller = map.get("product_seller");
			System.out.println(">>id"+product_id+">>status"+product_seller);
			int status = productService.successOrder(product_id,product_seller);
			if(status > 0) {
				return "success";
			}
			return "fail";
		}

	// ===========================================================================================
	// ===========================================================================================
	// 이전 페이지 이동 저장
	private void savePreviousUrl(HttpServletRequest request, HttpSession session) {
		String prevURL = request.getServletPath();
		String queryString = request.getQueryString();
		
		if (queryString != null) {
			prevURL += "?" + queryString;
		}
		
		session.setAttribute("prevURL", prevURL);
	}
		
	// ===========================================================================================
	// 첨부파일 - 파일 목록 처리 (첨부파일 단일)
	private void addFileToModel(SupportVO support, Model model) {
		String fileName = support.getSupport_file1();
		String originalFileName = "";

		if(fileName != null) {
			originalFileName = fileName.substring(fileName.indexOf("_") + 1);
		} else {
			originalFileName = fileName;
		}

		model.addAttribute("originalFileName", originalFileName);
		model.addAttribute("fileName", fileName);
	}

	// 첨부파일 - 실제 경로 리턴 처리
	private String getRealPath(HttpSession session) {
		String realPath = session.getServletContext().getRealPath(uploadPath);
		return realPath;
	}

	// 첨부파일 - 서브디렉토리 생성 처리
	private String createDirectories(String realPath) {
		String subDir = "";

		// 서브디렉토리명 만들기
		LocalDate today = LocalDate.now(); // 날짜로 폴더명 생성하기
//			System.out.println("작성날짜: " + today);
		String datePattern = "yyyy/MM/dd";
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);

		subDir = today.format(dtf);
		realPath += "/" + subDir;
		System.out.println("실제 파일 업로드 경로: " + realPath);

		try {
			Path path = Paths.get(realPath);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return subDir;
	}

	// 첨부파일 -  첨부파일명 중복 대책 처리
	private String processDuplicateFileName(SupportVO support, String subDir) {
		MultipartFile mFile1 = support.getFile1();
		System.out.println("원본파일명: " + mFile1);
		support.setSupport_file1("");

		String fileName = "";

		if(!mFile1.getOriginalFilename().equals("")) {
			fileName = UUID.randomUUID().toString().substring(0, 8) + "_" + mFile1.getOriginalFilename();
			support.setSupport_file1(subDir + "/" + fileName);
		}

		return fileName;
	}

	// 첨부파일 - 실제 파일 업로드 처리(임시경로 -> 실제경로)
	private void completeUpload(SupportVO support, String realPath, String fileName) {
		MultipartFile mFile1 = support.getFile1();

		try {
			if(!mFile1.getOriginalFilename().equals("")) {
				mFile1.transferTo(new File(realPath, fileName));
				System.out.println("----------- 업로드 실제 처리: " + mFile1);
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}