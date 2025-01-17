<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
				<a href="MyWish" class="active">관심목록</a>
				<a href="MyReview">나의 후기</a>
				<a href="MyReviewHistory">내가 쓴 후기</a>
				<a href="MySupport">1:1문의내역</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">관심목록 <small>(총 <span>${wishlistCount}</span>건)</small></div>
				<div class="wish-contents">
					<!-- contents -->
					<section class="my-rev-wrap">
						<div class="my-rev-li">
							<c:choose>
							<c:when test="${empty wishlist}">
								<div class="product-card-empty">관심상품이 없습니다.</div>
							</c:when>
							<c:otherwise>
								<ul class="myproduct-wrap">
									<c:forEach var="wish" items="${wishlist}">
<!-- 										<li> -->
<!-- 											<div class="thumb-area"> -->
<%-- <%-- 												<img src="${pageContext.request.contextPath}/resources/upload/${wish.class_pic}" class="card-thumb" alt="thumbnail" onclick="location.href='CourseDetail?class_id=${wish.class_id}'"/> --%> 
<%-- <%-- 												<img src="${pageContext.request.contextPath}/resources/images/thumb_01.webp" class="card-thumb" alt="thumbnail" onclick="location.href='CourseDetail?class_id=${wish.class_id}'" /> --%>
<!-- <!-- 												<form action="MyFavDel" method="post" class="MyFavDelFrm"> --> 
<%-- <%-- 													<input type="hidden" name="class_id" value="${wish.class_id}"> --%>
<!-- <!-- 													<button type="button" class="fav-on" onclick="confirmDeleteWishItem()"><i class="fa-solid fa-heart"></i></button> --> 
<!-- <!-- 												</form> -->
<!-- 											</div> -->
<!-- 											<div class="card-info" onclick=""> -->
<!-- 												<div class="category"> -->
<%-- <%-- 													<span>${wish.class_category}</span> --%>
<!-- 												</div> -->
<%-- 												<div class="ttl">${wish.product_title}</div> --%>
<!-- 												<div class="rating"> -->
<!-- <!-- 													<i class="fa-solid fa-star"></i> --> 
<%-- <%-- 													<span>${wish.review_score}</span> --%> 
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</li> -->
										<li class="product-card">
											<img src="${pageContext.request.contextPath}/resources/upload/${wish.product_pic1}" class="card-thumb" alt="thumbnail" height="180px"/>
											<form action="MyWishDel" method="post" class="MyWishDelFrm">
												<input type="hidden" name="wishlist_id" value="${wish.wishlist_id}">
												<button type="button" class="fav-on" onclick="confirmDeleteWishItem(this)"><i class="fa-solid fa-heart"></i></button>
											</form>
											<div class="card-info">
												<div class="category">
													<span>${wish.product_category}</span>
													<span class="type">직거래</span>
												</div>
												<div class="ttl">${wish.product_title}</div>
												<div class="price">
													<fmt:formatNumber value="${wish.product_price}" type="number" pattern="#,###" />원
												</div>
												<div class="card-row">
													<span class="add">${wish.product_trade_adr1}</span>
													<span class="name">${wish.seller_nickname}</span>
												</div>
											</div>
										</li>
									</c:forEach>
								</ul>							
							</c:otherwise>
							</c:choose>
						</div>
					</section>
					<!-- // contents -->
				</div>
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
	<script>
		function confirmDeleteWishItem(button) {
		    if (confirm("관심상품에서 삭제하시겠습니까?")) {
		        button.closest(".MyWishDelFrm").submit();
		    }
		}
	</script>
	
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