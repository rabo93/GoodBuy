<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
						<a href="MyOrder" class="active">구매내역</a>
						<a href="MySales">판매내역</a>
						<h3>나의 정보</h3>
						<a href="MyInfo">계정정보</a>
						<a href="MyWish">관심목록</a>
						<a href="MyReview">나의 후기</a>
						<a href="MySupport">1:1문의내역</a>
						<a href="">나의 광고</a>
					</aside>

					<div class="my-container">
						<div class="contents-ttl">
							<h3>구매내역<small>(총 <span>${orderCount}</span>건)</small></h3>
							<div class="product-list">
								<ul class="product-wrap">
									<!-- 2개 -->
									<li class="product-card">
										<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
										<div class="card-info">
											<div class="category">
												<span>생활용품</span>
												<span class="type">직거래</span>
											</div>
											<div class="ttl">[구매완료]젠하이저 H3PRO 팝니다</div>
											<div class="price">55,000 원</div>
										</div>
										<div>
											<button>후기보내기</button>
										</div>
									</li>
								</ul>
								<ul class="product-wrap">
									<!-- 2개 -->
									<li class="product-card">
										<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
										<div class="card-info">
											<div class="category">
												<span>생활용품</span>
												<span class="type">직거래</span>
											</div>
											<div class="ttl">[구매완료]젠하이저 H3PRO 팝니다</div>
											<div class="price">55,000 원</div>
										</div>
										<div>
											<button>후기보내기</button>
										</div>
									</li>
								</ul>
						</div>
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
</html>