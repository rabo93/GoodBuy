<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
				<a href="MyInfo">계정정보</a>
				<a href="MyStore">나의 상점</a>
				<a href="">굿페이</a>
				<a href="">나의 광고</a>
				<a href="MyWish">관심목록</a>
				<a href="MyOrder">구매내역</a>
				<a href="MySales">판매내역</a>
				<a href="MyReview" class="active">나의 후기</a>
				<a href="MySupport">1:1문의내역</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">나의 후기 <small>(총 <span>${reviewCount}</span>건)</small></div>
				<div class="contents">
					<!-- contents -->
					<section class="my-rev-wrap">
						<div class="my-rev-li">
						
						이제 작성해야함!!!!!!!!!!
						<c:choose>
								<c:when test="${empty myReview}">
									<div class="empty">작성된 수강평이 없습니다.</div>
								</c:when>
								<c:otherwise>	
									<div class="review-rating">
						                <span class="rating-score">${course[0].review_score}</span><br>
						                <span class="stars"><i class="fa-solid fa-star"></i></span>
						            </div>
						            <c:forEach var="review" items="${myReview}" varStatus="status">
						            	<div class="review">
										    <div class="r_header">
										        <div class="profile-icon"></div>
										        <div class="user-info">
										            <div class="name">${review.mem_id}</div>
										            <div class="date">${review.review_date}</div>
										        </div>
										    </div>
								            <div class=rating>
												<i class="fa-solid fa-star" ></i>
												<span><b>${review.review_score}</b></span>
											</div>
										    <div class="review-text">${review.review_content}</div>
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