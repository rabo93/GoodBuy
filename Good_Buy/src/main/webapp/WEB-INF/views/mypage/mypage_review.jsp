<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/g_favicon.ico" type="image/x-icon">
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/g_favicon.ico" type="image/x-icon">

<title>굿바이 - 중고거래, 이웃과 함께 더 쉽게!</title>

<!-- default -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontawesome/all.min.css" />
<script src="${pageContext.request.contextPath}/resources/fontawesome/all.min.js"></script>

<!-- ******************* 아래 CSS와 JS는 페이지별로 알맞게 Import 해주세요 ****************** -->
<!-- CSS for Page -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">

<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
			<!-- 계정설정 -->
			<!-- 계정설정 -->
	<section class="wrapper">
			<div class="page-inner">
			
		<h2 class="page-ttl">마이페이지</h2>
		<section class="my-wrap">
		
			<aside class="my-menu">
				<h3>거래 정보</h3>
				<a href="MyStore">나의 상점</a>
				<a href="GoodPay">굿페이</a>
				<a href="MyOrder">구매내역</a>
				<a href="MySales">판매내역</a>
				<h3>나의 정보</h3>
				<a href="MyInfo">계정정보</a>
				<a href="MyWish">관심목록</a>
				<a href="MyReview"  class="active">나의 후기</a>
				<a href="MyReviewHistory">내가 쓴 후기</a>
				<a href="MySupport">1:1문의내역</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">나의 후기 <small>(총 <span>${reviewCount}</span>건)</small></div>
				<div class="contents">
					<!-- contents -->
					<section class="my-rev-wrap">
						<div class="my-rev-li">
						<c:choose>
								<c:when test="${empty review}">
									<div class="empty">작성된 후기가 없습니다.</div>
								</c:when>
								<c:otherwise>	
<!-- 									<div class="review-rating"> -->
<%-- 						                <span class="rating-score">${course[0].review_score}</span><br> --%>
<!-- 						                <span class="stars"><i class="fa-solid fa-star"></i></span> -->
<!-- 						            </div> -->
						            <c:forEach var="review" items="${review}" varStatus="status">
						            	<div class="review-box">
									        <div class="user-info">
									        	<div class="user-thumb">
										            <c:choose>
														<c:when test="${not empty sessionScope.sProfile}">
															<img src="${sessionScope.sProfile}?${System.currentTimeMillis()}" id="profile_preview"><br>
														</c:when>
														<c:otherwise>
															<!-- member.memProfile이 비어 있으면 기본 이미지 출력 -->
															<img src="${pageContext.request.contextPath}/resources/img/user_thumb.png" id="profile_preview"><br>
														</c:otherwise>
													</c:choose>
										        </div>
										        <div class="name">${review.buyerNick} <span class="date">${review.review_date}</span></div>
										    </div>
								            <div class="review-score">
								            	<c:if test="${review.review_score == '2'}"><span id="score" name="score">최고예요🥳</span></c:if>
									            <c:if test="${review.review_score == '1'}"><span id="score" name="score">좋아요💕</span></c:if>
									            <c:if test="${review.review_score == '0'}"><span id="score" name="score">별로예요👿</span></c:if>
								            </div>
										    <div class="review-text">${review.review_content}</div>
								            <div class="review-score-option">
								            	<%-- 리뷰 옵션 --%>
												<c:if test="${fn:contains(review.review_options, '1')}"><span id="score" name="score">배송이 빨라요🚚</span></c:if>
												<c:if test="${fn:contains(review.review_options, '2')}"><span id="score" name="score">친절해요💖</span></c:if>
												<c:if test="${fn:contains(review.review_options, '3')}"><span id="score" name="score">물건상태가 좋아요✨</span></c:if>
												<c:if test="${fn:contains(review.review_options, '4')}"><span id="score" name="score">또 거래하고 싶어요💰</span></c:if>
												<c:if test="${fn:contains(review.review_options, '5')}"><span id="score" name="score">배송이 느려요😵‍💫</span></c:if>
												<c:if test="${fn:contains(review.review_options, '6')}"><span id="score" name="score">채팅 답장이 느려요😫</span></c:if>
												<c:if test="${fn:contains(review.review_options, '7')}"><span id="score" name="score">물건 상태가 사진과 달라요💣</span></c:if>
								            </div>
								            <div class="product"><a href='ProductDetail?PRODUCT_ID=${review.product_id}'><b>거래상품</b> <span>${review.product_title}</span></a></div>
										</div>
						            </c:forEach>
								</c:otherwise>
							</c:choose>	
						</div>
					</section>
					<!-- // contents -->
				</div>
			</div>
		</section>
		</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
	<script>
	$(document).ready(function () {
	    // 필터 버튼 클릭 이벤트
	    $(".filter-btn").click(function () {
	    	$(".filter-btn").removeClass('active');
	    	$(this).addClass('active');
	        const status = $(this).data("status");  // 클릭된 버튼의 data-status 값

	        // 상품 카드 필터링
	        $(".product-card").each(function () {
	            const productStatus = $(this).data("status");  // 각 상품 카드에서 data-status 값 가져오기
	            
	            // 콘솔 디버깅 (확인용)
	            console.log("Button Status:", status);
	            console.log("Product Status:", productStatus);

	            // 상태가 일치하거나 '전체(all)'인 경우 보여주기
	            if (status == 'all' || status == productStatus) {
	                $(this).show();
// 	                $(this).fadeIn();
	            } else {
// 	                $(this).hide();
	                $(this).fadeOut();
	            }
	        });
	    });
	    
	    
	 	// 모바일 마이페이지 활성화 메뉴로 자동 스크롤 포커싱
	    menuFocusing();
	    
	});
	
	// 모바일 마이페이지 활성화 메뉴로 자동 스크롤 포커싱
	function menuFocusing(){
		let menuIdx = 0;
	    const myMenu = document.querySelector(".my-menu");
	    const myMenuItems = document.querySelectorAll(".my-menu > a");
		
		myMenuItems.forEach((elem, idx) => {
	    	if(elem.classList.contains("active")) menuIdx = idx;
	    });
		
		myMenu.scrollTo({
			left : myMenuItems[menuIdx].getBoundingClientRect().left - myMenuItems[menuIdx].getBoundingClientRect().width, 
			behavior : 'smooth'
		});
	}
	
	

    </script>
</body>
</html>