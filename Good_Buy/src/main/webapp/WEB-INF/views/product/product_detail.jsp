<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css">

<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/product.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<section class="item-detail">
					<div class="item-detail-content">
						<div class="item-detail-pic">
							<div class="thumb-slide">
								<div><img src="../../resources/img/product_thumb.jpg"></div>
								<div><img src="../../resources/img/product_thumb.jpg"></div>
								<div><img src="../../resources/img/product_thumb.jpg"></div>
							</div>
							<button class="thumb-left"></button>
							<button class="thumb-right"></button>
						</div>
						<script src="${pageContext.request.contextPath}/resources/js/slick.js" defer></script>
						<script defer>
							$(document).ready(function(){
								$(".thumb-slide").slick({
									infinite : true, 
									autoplay: true,
									autoplaySpeed : 5000,
									dots: true,
									speed : 400,	
									arrows : true,
									prevArrow : $('.thumb-left'),		// 이전 화살표 모양 설정
									nextArrow : $('.thumb-right'),		// 다음 화살표 모양 설정
									pauseOnHover : false,
									draggable : true
								});
							});
						</script>
						<div class="item-detail-content-text">
							<div class="item-detail-title">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
							<div class="item-detail-view">
								<div class="item-detail-view-count">조회수 50</div>
								<div class="item-detail-fav-count">찜 8</div>
							</div>
							<div class="item-detail-description">상품 설명 상품 설명 상품 설명 상품 설명 상품 설명 상품 설명 상품 설명 상품 설명 상품 설명 상품 설명 상품 설명 상품 설명</div>
							<div class="item-detail-shpping-fee">배송비:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4,000 원</div>
							<div class="item-detail-price-setting">
								<div class="item-detail-discount">가격제안 가능</div>
								<div class="item-detail-price">60,000 원</div>
							</div>
							<div class="item-detail-button-group">
								<div class="item-detail-trade-adr">직거래 위치: 부산진구</div>
								<input type="button" value="찜하기" class="item-detail-fav">
								<a href="javascript:void(0)"  onclick="openSlideChat('admin')">
									<input type="button" value="판매자에게 톡하기" class="item-detail-contact-seller">
								</a>
							</div>
						</div>
					</div>
					<div class="item-detail-seller-info" onclick="location.href='ProductShop'" style=" cursor: pointer;">
						<img src="../../resources/img/product_thumb.jpg" class="item-detail-seller-pic">
						<div class="item-detail-seller-nick">홍길동동이</div>
						<div class="item-detail-seller-review">★★★★★</div>
					</div>
<!-- 					<div class="item-detail-seller-info"> -->
<!-- 						<img src="../../resources/img/product_thumb.jpg" class="item-detail-seller-profile-pic"> -->
<!-- 						<div class="item-detail-seller-name">판매자 이름</div> -->
<!-- 						<div class="item-detail-seller-review">★★★★★</div> -->
<!-- 					</div> -->
					<div class="item-detail-more-item">
						<h1 class="sec-ttl">
						이 판매자가 판매하는 다른 물품
						<button class="more"><svg class="svg-inline--fa fa-chevron-right" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M310.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-192 192c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L242.7 256 73.4 86.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l192 192z"></path></svg><!-- <i class="fa-solid fa-chevron-right"></i> Font Awesome fontawesome.com --></button>
						</h1>
						<div class="product-list">
							<ul class="product-wrap">
								<!-- 8개 -->
								<li class="product-card">
									<img src="/resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail">
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="/resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail">
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="/resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail">
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="/resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail">
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
							</ul>
						</div>
						<h1 class="sec-ttl">
						이 상품과 비슷한 상품
						<button class="more"><svg class="svg-inline--fa fa-chevron-right" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M310.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-192 192c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L242.7 256 73.4 86.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l192 192z"></path></svg><!-- <i class="fa-solid fa-chevron-right"></i> Font Awesome fontawesome.com --></button>
						</h1>
						<div class="product-list">
							<ul class="product-wrap">
								<!-- 8개 -->
								<li class="product-card">
									<img src="/resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail">
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="/resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail">
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="/resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail">
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="/resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail">
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</section>
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script type="text/javascript">

	
</script>
</html>