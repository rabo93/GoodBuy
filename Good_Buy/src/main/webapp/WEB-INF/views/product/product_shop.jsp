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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css">

<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/product_shop.js"></script>

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
						<img src="${searchSeller.MEM_PROFILE}" class="item-shop-seller-pic">
						<div class="item-shop-seller-nick">${searchSeller.MEM_NICK}</div>
						<div class="item-shop-seller-review">
							<div class="item-shop-seller-review-title">셀러평점</div>
							<div class="item-shop-seller-review-star">
								<c:if test="${not empty searchSellerScore}">
									최고예요 + ${searchSellerScore.Best} |
									좋아요 + ${searchSellerScore.Good} |
									별로예요 + ${searchSellerScore.Bad}
								</c:if>
							</div>
						</div>
					</div>
					<button class="more">
						<h1 class="sec-ttl">
						이 판매자가 판매하는 물품
						<i class="fa-solid fa-chevron-right"></i>
						</h1>
					</button>
					<div class="product-list" style="margin-bottom: 20px">
						<ul class="product-wrap">
							<!-- 8개 -->
							<c:forEach items="${searchSellerProduct}" var="list" step="1" end="3">
								<li class="product-card" onclick="location.href='ProductDetail?PRODUCT_ID=${list.product_id}'">
									<img src="${pageContext.request.contextPath}/resources/upload/${list.product_pic1}" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>${list.product_category}</span>
											<c:if test="${list.product_trade_adr1 != ''}">
												<span class="type">직거래</span>
											</c:if>
										</div>
										<div class="ttl">${list.product_title}</div>
										<div class="price">
										 	<fmt:formatNumber var="price" value="${list.product_price}" type="number"/>
										 	${price} 원
										 </div>
										<div class="card-row">
											<span class="add">${list.product_trade_adr1}</span>
											<span class="name">${list.mem_nick}</span>
											<span class="time">
												<script type="text/javascript">
													moment.locale('ko')
													$(".time").text(moment(`${list.product_reg_date}`, "YYYYMMDDhhmmss").fromNow())
												</script>
											</span>
										</div>
									</div>
								</li>	
							</c:forEach>
						</ul>
					</div>
					<div class="item-shop-review-list-area">
						<c:forEach items="${searchSellerReview}" var="review" step="1" end="4">
							<div class="item-shop-review-list">
								<img src="${pageContext.request.contextPath}/resources/upload/${review.PRODUCT_PIC1}" class="item-shop-review-pic">
								<div class="item-shop-review-content-box">
									<div class="item-shop-review-content">${review.REVIEW_CONTENT}</div>
									<div class="item-shopreview-product">${review.PRODUCT_TITLE}</div>
								</div>
								<div class="item-shop-review-writer">${review.REVIEWER}</div>
								<div class="item-shop-review-list-star">
									<c:choose>
										<c:when test="${review.REVIEW_SCORE == 0}">
											별로에요
										</c:when>
										<c:when test="${review.REVIEW_SCORE == 1}">
											좋아요
										</c:when>
										<c:otherwise>
											최고에요
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</c:forEach>
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