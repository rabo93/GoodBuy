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
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			<!-- -->
			<h2 class="page-ttl">마이페이지</h2>
			<section class="my-wrap">
				<aside class="my-menu">
					<h3>거래 정보</h3>
					<a href="MyStore">나의 상점</a>
					<a href="GoodPay">굿페이</a>
					<a href="MyOrder">구매내역</a>
					<a href="MySales" class="active">판매내역</a>
					<h3>나의 정보</h3>
					<a href="MyInfo">계정정보</a>
					<a href="MyWish">관심목록</a>
					<a href="MyReview">나의 후기</a>
					<a href="MyReviewHistory">내가 쓴 후기</a>
					<a href="MySupport">1:1문의내역</a>
					<a href="">나의 광고</a>
				</aside>
				<div class="my-container">
					<div class="contents-ttl"><h3>판매내역 <small>(총 <span>${salesCount}</span>건)</small></h3>
						<div class="my-tabs">
							<button class="filter-btn active" data-status="all">전체</button>
							<button class="filter-btn" data-status="0">판매중</button>
			                <button class="filter-btn" data-status="1">거래중</button>
			                <button class="filter-btn" data-status="2">예약중</button>
			                <button class="filter-btn" data-status="3">거래완료</button>
			                <button class="filter-btn" data-status="4">신고처리</button>
						</div>
					</div>
				<section>
					   <div class="product-list">
					    <ul class="product-wrap">
						    <c:choose>
						        <c:when test="${empty product}">
						            <div class="product-card-empty" data-status="none">등록된 상품이 없습니다.</div>
						        </c:when>
						        <c:otherwise>
						        <ul class="product-wrap">
						            <c:forEach var="product" items="${product}">
						                <li class="product-card" data-status="${product.product_status}">
						                    <a href='ProductDetail?PRODUCT_ID=${product.product_id}'>
						                    	<img src="${pageContext.request.contextPath}/resources/upload/${product.product_pic1}" class="card-thumb" alt="thumbnail" height="180px" />
						                     </a>
						                    <div class="card-info">
						                        <div class="category">
						                            <span>${product.product_category}</span>
						                            <span class="type">직거래</span>
						                        </div>
						                        <div class="ttl">
						                            <c:choose>
						                                <c:when test="${product.product_status == 1}">[거래중]</c:when>
						                                <c:when test="${product.product_status == 2}">[예약중]</c:when>
						                                <c:when test="${product.product_status == 3}">[거래완료]</c:when>
						                                <c:when test="${product.product_status == 4}">[🚫신고처리된 게시물입니다.]${product.product_title}
						                                     <div class="price">
									                            <fmt:formatNumber value="${product.product_price}" type="number" pattern="#,###" />원
									                        </div>
									                        <div class="card-row">
									                            <span class="add">${product.product_trade_adr1}</span>
									                            <span class="name">${product.mem_nick}</span>
									                        </div>
						                                </c:when>
						                                <c:otherwise>[판매중]</c:otherwise>
						                            </c:choose>
						                            ${product.product_title}
						                        </div>
						                        <div class="price">
						                            <fmt:formatNumber value="${product.product_price}" type="number" pattern="#,###" />원
						                        </div>
						                        <div class="card-row">
						                            <span class="add">${product.product_trade_adr1}</span>
						                            <span class="name">${product.mem_nick}</span>
						                        </div>
						                    </div>
						                </li>
						            </c:forEach>
						            </ul>
						        </c:otherwise>
						    </c:choose>
						</ul>
					    
					</div>
				</section>
				</div>
			</section>
			
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
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
	});

    </script>
</body>
</html>