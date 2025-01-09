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
				<a href="">나의 광고</a>
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
											            	<img src="${sessionScope.sProfile}?${System.currentTimeMillis()}" id="profile_preview">
											            </c:when>
											            <c:otherwise>
											                <!-- member.memProfile이 비어 있으면 기본 이미지 출력 -->
											                <img src="${pageContext.request.contextPath}/resources/img/user_thumb.png" id="profile_preview">
											            </c:otherwise>
											        </c:choose>
										        </div>
										        <div class="name">${review.buyerNick} <span class="date">${review.review_date}</span></div>
										    </div>
								            <div class="review-score">
								            	<c:if test="${review.review_score == '2'}">
								            		<span id="score" name="score">최고예요🥳</span>
									            	<!-- <input type="button" id="score" name="score" value="최고예요👍">
-->										            </c:if>
									            <c:if test="${review.review_score == '1'}">
								            		<span id="score" name="score">좋아요💕</span>
									            	<!-- <input type="button" id="score"  name="score" value="좋아요💕"> -->
									            </c:if>
									            <c:if test="${review.review_score == '0'}">
								            		<span id="score" name="score">별로예요👿</span>
									           		<!-- <input type="button" id="score"  name="score" value="별로예요🥲"> -->
								           	 	</c:if>
								            </div>
										    <div class="review-text">${review.review_content}</div>
								            <div class="review-score-option">
								            	<%-- 리뷰 옵션 --%>
												<c:if test="${fn:contains(review.review_options, '1')}">
													<span id="score" name="score">배송이 빨라요🚚</span>
													<!-- <input type="button" id="score" name="score" value="배송이 빨라요🚚"> -->
												</c:if>
												<c:if test="${fn:contains(review.review_options, '2')}">
													<span id="score" name="score">친절해요💖</span>
													<!-- <input type="button" id="score" name="score" value="친절해요😊"> -->
												</c:if>
												<c:if test="${fn:contains(review.review_options, '3')}">
													<span id="score" name="score">물건상태가 좋아요✨</span>
													<!-- <input type="button" id="score" name="score" value="물건상태가 좋아요✨"> -->
												</c:if>
												<c:if test="${fn:contains(review.review_options, '4')}">
													<span id="score" name="score">또 거래하고 싶어요💰</span>
													<!-- <input type="button" id="score" name="score" value="또 거래하고 싶어요💰"> -->
												</c:if>
								            </div>
								            <div class="product"><b>거래상품</b> <span>${review.product_title}</span></div>
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
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>
</html>