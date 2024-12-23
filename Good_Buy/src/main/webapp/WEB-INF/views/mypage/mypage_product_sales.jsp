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
					<a href="MySupport">1:1문의내역</a>
					<a href="">나의 광고</a>
				</aside>
				<div class="my-container">
					<div class="contents-ttl"><h3>판매내역 <small>(총 <span>${salesCount}</span>건)</small></h3><div class="my-tabs">
						<button>전체</button>
						<button>거래중</button>
						<button>거래완료</button>
						<button>취소/환불</button>
					</div>
					</div>
				<section>
					<div>
					
					<c:choose>
						<c:when test="${empty product}">
							<ul>
								<li>판매내역이 없습니다.</li>
							</ul>
						</c:when>
						<c:otherwise>
							<c:forEach var="product" items="${product}">
								<li class="product-card">
											<img src="${pageContext.request.contextPath}/resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" height="180px"/>
											<div class="card-info">
												<div class="category">
													<span>생활용품</span>
													<span class="type">직거래</span>
												</div>
												<div class="ttl">
													<c:choose>
														<c:when test="${product.product_status == 1 }">
															[거래중]
														</c:when>
														<c:when test="${product.product_status == 2 }">
															[예약중]
														</c:when>
														<c:otherwise>
															[거래완료]
														</c:otherwise>
													</c:choose>
													${product.product_title}
												</div>
												<div class="price">
													<fmt:formatNumber  value="${product.product_price}" type="number" pattern="#,###" />원
												</div>
												<div class="card-row">
													<span class="add">부산 해운대구</span>
													<span class="name">${product.mem_nick}</span>
												</div>
											</div>
										</li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					
					<!-- ================================================================ -->
<!-- 						<h3>진행중</h3>		 -->
<!-- 						<div class="product-list"> -->
<!-- 							<ul class="product-wrap"> -->
<!-- 								8개 -->
<!-- 								<li class="product-card"> -->
<!-- 									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" /> -->
<!-- 									<div class="card-info"> -->
<!-- 										<div class="category"> -->
<!-- 											<span>생활용품</span> -->
<!-- 											<span class="type">직거래</span> -->
<!-- 										</div> -->
<!-- 										<div class="ttl">[예약중]젠하이저 H3PRO 팝니다</div> -->
<!-- 										<div class="price">55,000 원</div> -->
<!-- 										<div class="card-row"> -->
<!-- 											<span class="add">부산 해운대구</span> -->
<!-- 											<span class="name">홍길동동이</span> -->
<!-- 											<span class="time">1분 전</span> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</li> -->
<!-- 							</ul> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<h3>거래완료</h3> -->
<!-- 					<div class="product-list"> -->
<!-- 							<ul class="product-wrap"> -->
<!-- 								8개 -->
<!-- 								<li class="product-card"> -->
<!-- 									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" /> -->
<!-- 									<div class="card-info"> -->
<!-- 										<div class="category"> -->
<!-- 											<span>생활용품</span> -->
<!-- 											<span class="type">직거래</span> -->
<!-- 										</div> -->
<!-- 										<div class="ttl">[거래완료]젠하이저 H3PRO 팝니다</div> -->
<!-- 										<div class="price">55,000 원</div> -->
<!-- 										<div class="card-row"> -->
<!-- 											<span class="add">부산 해운대구</span> -->
<!-- 											<span class="name">홍길동동이</span> -->
<!-- 											<span class="time">1분 전</span> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</li> -->
<!-- 							</ul> -->
<!-- 						</div> -->
					
<!-- 					<div> -->
<!-- 					<h3>취소/환불</h3> -->
<!-- 											<div class="product-list"> -->
<!-- 							<ul class="product-wrap"> -->
<!-- 								8개 -->
<!-- 								<li class="product-card"> -->
<!-- 									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" /> -->
<!-- 									<div class="card-info"> -->
<!-- 										<div class="category"> -->
<!-- 											<span>생활용품</span> -->
<!-- 											<span class="type">직거래</span> -->
<!-- 										</div> -->
<%-- 										<div class="ttl">${productlist.product_title}</div> --%>
<%-- 										<div class="price">${productlist.product_price}</div> --%>
<!-- 										<div class="card-row"> -->
<!-- 											<span class="add">부산 해운대구</span> -->
<!-- 											<span class="name">홍길동동이</span> -->
<!-- 											<span class="time">1분 전</span> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</li> -->
<!-- 							</ul> -->
<!-- 						</div> -->
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
	






</body>
</html>