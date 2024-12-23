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
				<section class="item-shop-section">
					<div class="item-shop-seller-info">
						<img src="../../resources/img/product_thumb.jpg" class="item-shop-seller-pic">
						<div class="item-shop-seller-nick">홍길동동이</div>
						<div class="item-shop-seller-review">
							<div class="item-shop-seller-review-title">셀러평점</div>
							<div class="item-shop-seller-review-star">★★★★★</div>
						</div>
					</div>
					<h1 class="sec-ttl">
					이 판매자가 판매하는 다른 물품
					<button class="more"><svg class="svg-inline--fa fa-chevron-right" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M310.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-192 192c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L242.7 256 73.4 86.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l192 192z"></path></svg><!-- <i class="fa-solid fa-chevron-right"></i> Font Awesome fontawesome.com --></button>
					</h1>
					<div class="product-list" style="margin-bottom: 20px">
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
					<div class="item-shop-review-list-area">
						<div class="item-shop-review-list">
							<img src="../../resources/img/product_thumb.jpg" class="item-shop-review-pic">
							<div class="item-shop-review-content-box">
								<div class="item-shop-review-content">배송도 빠르고 좋아요</div>
								<div class="item-shopreview-product">젠하이저 H3PRO HYBRID ANC</div>
							</div>
							<div class="item-shop-review-writer">홍길동동이</div>
							<div class="item-shop-review-list-star">★★★★★</div>
						</div>
						<div class="item-shop-review-list">
							<img src="../../resources/img/product_thumb.jpg" class="item-shop-review-pic">
							<div class="item-shop-review-content-box">
								<div class="item-shop-review-content">배송도 빠르고 좋아요</div>
								<div class="item-shopreview-product">젠하이저 H3PRO HYBRID ANC</div>
							</div>
							<div class="item-shop-review-writer">홍길동동이</div>
							<div class="item-shop-review-list-star">★★★★★</div>
						</div>
						<div class="item-shop-review-list">
							<img src="../../resources/img/product_thumb.jpg" class="item-shop-review-pic">
							<div class="item-shop-review-content-box">
								<div class="item-shop-review-content">배송도 빠르고 좋아요</div>
								<div class="item-shopreview-product">젠하이저 H3PRO HYBRID ANC</div>
							</div>
							<div class="item-shop-review-writer">홍길동동이</div>
							<div class="item-shop-review-list-star">★★★★★</div>
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