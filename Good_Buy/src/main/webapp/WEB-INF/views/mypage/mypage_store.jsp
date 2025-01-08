<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		<section class="wrapper"><!-- wrapper -->
			<div class="page-inner">
			<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			
			
				<!-- 계정설정 -->
				<h2 class="page-ttl">마이페이지</h2>
				<section class="my-wrap">
					<aside class="my-menu">
						<h3>거래 정보</h3>
						<a href="MyStore" class="active">나의 상점</a>
						<a href="GoodPay">굿페이</a>
						<a href="MyOrder">구매내역</a>
						<a href="MySales">판매내역</a>
						<h3>나의 정보</h3>
						<a href="MyInfo">계정정보</a>
						<a href="MyWish">관심목록</a>
						<a href="MyReview">나의 후기</a>
						<a href="MyReviewHistory">내가 쓴 후기</a>
						<a href="MySupport">1:1문의내역</a>
						<a href="">나의 광고</a>
					</aside>
					<div class="my-container">
						<div class="contents-ttl">나의 상점
						<div class="contents">
							<!-- contents -->
							<section class="my-rev-wrap">
								<div>
									<form action="MyStore" class="my-frm" method="post">
										<div class="set">
											<div>
												<div class="box">
													<c:choose>
											            <c:when test="${not empty sessionScope.sProfile}">
											            	<img src="${sessionScope.sProfile}?${System.currentTimeMillis()}" id="profile_preview"><br>
<%-- 											            	<img src="${member.mem_profile}?${System.currentTimeMillis()}" id="profile_preview"><br> --%>
											            </c:when>
											            <c:otherwise>
											                <!-- member.memProfile이 비어 있으면 기본 이미지 출력 -->
											                <img src="${pageContext.request.contextPath}/resources/img/user_thumb.png" id="profile_preview"><br>
											            </c:otherwise>
											        </c:choose>
												</div>
												<h3 class="my-store">${sessionScope.sNick}의 상점</h3><br>
												<div class="main-review-score">
												<c:choose>
													<c:when test="${empty scoreCount}"></c:when>
													<c:otherwise>
														<c:forEach var="score" items="${scoreCount}">
														    <c:if test="${score['REVIEW_SCORE'] == 2}">
														       최고예요👍+${score['count']} 
														    </c:if>
														    <c:if test="${score['REVIEW_SCORE'] == 1}">
														        좋아요💕+${score['count']} 
														    </c:if>
														    <c:if test="${score['REVIEW_SCORE'] == 0}">
														        별로예요🥲+${score['count']} 
														    </c:if>
														</c:forEach>
													</c:otherwise>
												</c:choose>
												</div>
											</div>
										</div>
											
										<div class="set">
											<label>상점 소개</label>
											<input type="hidden" id = "mem_id" value="${member.mem_id}"> 
		<%-- 									<input type="text" name="mem_intro" id="mem_intro" value="${member.mem_intro}"> --%>
													<textarea rows="5" cols="50" name="mem_intro" id="mem_intro">${storeIntro.mem_intro}</textarea>
											<div>
												<input type="submit" value="저장"> 
											</div>
										</div>
									</form>
									<form action="" class="my-frm" method="get">
										<div>
											<h3 class="contents-ttl">등록한 상품목록 <small>(총 <span>${salesCount}</span>건)</small> <a href="MySales"><small> 더보기></small></a></h3>
										</div>
										<div class="product-list">
										    <ul class="product-wrap">
										        <c:choose>
										            <c:when test="${empty product}">
										                <li>등록된 상품이 없습니다.</li>
										            </c:when>
										            <c:otherwise>
										                <c:forEach var="product" items="${product}">
										                    <li class="product-card">
										                        <img src="${pageContext.request.contextPath}/resources/img/product_thumb.jpg" 
										                             class="card-thumb" 
										                             alt="thumbnail" />
										                        <div class="card-info">
										                            <div class="category">
										                                <span>${product.product_category}</span>
										                                <span class="type">직거래</span>
										                            </div>
										                            <div class="ttl">
										                                <c:choose>
										                                    <c:when test="${product.product_status == 1}">
										                                        [거래중]
										                                    </c:when>
										                                    <c:when test="${product.product_status == 2}">
										                                        [예약중]
										                                    </c:when>
										                                    <c:when test="${product.product_status == 3}">
										                                        [거래완료]
										                                    </c:when>
										                                    <c:when test="${product.product_status == 4}">
										                                    [🚫신고처리된 게시물입니다.]${product.product_title}
										                                     <div class="price">
													                            <fmt:formatNumber value="${product.product_price}" type="number" pattern="#,###" />원
													                        </div>
													                        <div class="card-row">
													                            <span class="add">${product.product_trade_adr1}</span>
													                            <span class="name">${product.mem_nick}</span>
													                        </div>
						                            					    </c:when>
										                                </c:choose>
										                                ${product.product_title}
										                            </div>
										                            <div class="price">
										                                <fmt:formatNumber type="number" value="${product.product_price}" pattern="#,###"/>원
										                            </div>
										                            <div class="card-row">
										                                <span class="add">${product.product_trade_adr1}</span>
										                                <span class="name">${product.mem_nick}</span>
										                                <span class="time">1분 전</span>
										                            </div>
										                        </div>
										                    </li>
										                </c:forEach>
										            </c:otherwise>
										        </c:choose>
										    </ul>
										</div>
										
									</form>
									
									<form action="" class="my-frm">
										<div>
											<h3 class="contents-ttl">나의 거래 후기 <small>(총 <span class="review-count">${reviewCount}</span>건)</small><a href="MyReview"><small> 더보기></small></a></h3>
											<!-- 후기 영역 -->
											<ul class="review-wrap">
												<li class="reviewInfo-wrap">
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
																    <div class="r_header">
																        <div class="profile-icon"></div>
																        <div class="user-info">
																            <img src="${pageContext.request.contextPath}/resources/img/user_thumb.png" id="profile_preview" height="60px"><br>
																            <div class="name">${review.buyerNick} | ${review.review_date}</div>
																            <div class="product">${review.product_title}</div>
																        </div>
																    </div>
																	<div class="review-score">
														            	<c:if test="${review.review_score == '2'}">
														            		<span id="score" name="score">최고예요👍</span>
															            	<!-- <input type="button" id="score" name="score" value="최고예요👍">
					 -->										            </c:if>
															            <c:if test="${review.review_score == '1'}">
														            		<span id="score" name="score">좋아요💕</span>
															            	<!-- <input type="button" id="score"  name="score" value="좋아요💕"> -->
															            </c:if>
															            <c:if test="${review.review_score == '0'}">
														            		<span id="score" name="score">별로예요🥲</span>
															           		<!-- <input type="button" id="score"  name="score" value="별로예요🥲"> -->
														           	 	</c:if>
														            </div>
														            <div class="review-score-option">
														            	<%-- 리뷰 옵션 --%>
																		<c:if test="${fn:contains(review.review_options, '1')}">
																			<span id="score" name="score">배송이 빨라요🚚</span>
																			<!-- <input type="button" id="score" name="score" value="배송이 빨라요🚚"> -->
																		</c:if>
																		<c:if test="${fn:contains(review.review_options, '2')}">
																			<span id="score" name="score">친절해요😊</span>
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
																    <div class="review-text">${review.review_content}</div>
																</div>
												            </c:forEach>
														</c:otherwise>
													</c:choose>	
												</li>
											</ul>
											
										</div>
									</form>
								</div>
							</section>
							<!-- // contents -->
						</div>
					</div>
					</div><!-- my-container -->
				</section><!-- my-wrap -->
			</div>
			<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
		</section>	
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>
</html>