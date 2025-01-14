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
					</aside>
					<div class="my-container">
						<div class="contents-ttl">나의 상점</div>
						<div class="contents">
							<!-- contents -->
							<article class="mypage-wrap">
								<div class="st-box">
									<section class="st-top">
										<div class="st-profile">
											<c:choose>
									            <c:when test="${not empty sessionScope.sProfile}">
									            	<img src="${sessionScope.sProfile}?${System.currentTimeMillis()}" id="profile_preview"><br>
									            </c:when>
									            <c:otherwise>
									                <!-- member.memProfile이 비어 있으면 기본 이미지 출력 -->
									                <img src="${pageContext.request.contextPath}/resources/img/user_thumb.png" id="profile_preview"><br>
									            </c:otherwise>
									        </c:choose>
										</div>
										<div class="st-info">
											<div class="st-ttl">${sessionScope.sNick}의 상점</div>
											<c:if test="${not empty scoreCount}">
												<div class="st-review">
													<c:forEach var="score" items="${scoreCount}">
													    <c:if test="${score['REVIEW_SCORE'] == 2}">
													       <span class="score score01">최고예요 🥳 ${score['count']}</span>
													    </c:if>
													    <c:if test="${score['REVIEW_SCORE'] == 1}">
													        <span class="score score02">좋아요 ❤️‍🔥 ${score['count']}</span> 
													    </c:if>
													    <c:if test="${score['REVIEW_SCORE'] == 0}">
													        <span class="score score03">별로예요 👿 ${score['count']}</span>
													    </c:if>
													</c:forEach>
												</div>
											</c:if>
										</div>
									</section>
								</div>
								<div class="st-box">
									<div class="st-ttl">상점 소개</div>
									<input type="hidden" id = "mem_id" value="${member.mem_id}">
									<div class="store-intro"> 
										<textarea rows="5" cols="50" name="mem_intro" id="mem_intro">${storeIntro.mem_intro}</textarea>
										<button id="submitBtn">저장</button>
									</div>
								</div>
								<div class="st-box">
									<h3 class="st-ttl">등록한 상품목록 <small>(총 <span>${salesCount}</span>건)</small> <a href="MySales" class="more-btn">더보기</a></h3>
									<div class="product-list">
									    <ul class="myproduct-wrap">
									        <c:choose>
									            <c:when test="${empty product}">
									                <li>등록된 상품이 없습니다.</li>
									            </c:when>
									            <c:otherwise>
									                <c:forEach var="product" items="${product}">
									                    <a href='ProductDetail?PRODUCT_ID=${product.product_id}'>
									                    <li class="product-card">
									                        <img src="${pageContext.request.contextPath}/resources/img/${product.product_pic1}" 
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
									                    </a>
									                </c:forEach>
									            </c:otherwise>
									        </c:choose>
									    </ul>
									</div>
								</div>
								<div class="st-box">
									<h3 class="st-ttl">나의 거래 후기 <small>(총 <span class="review-count">${reviewCount}</span>건)</small><a href="MyReview" class="more-btn">더보기</a></h3>
									<!-- 후기 영역 -->
									<ul class="review-wrap">
										<li class="reviewInfo-wrap">
											<c:choose>
												<c:when test="${empty review}">
													<div class="empty">작성된 후기가 없습니다.</div>
												</c:when>
												<c:otherwise>	
										            <c:forEach var="review" items="${review}" varStatus="status">
										            	<div class="review-box">
													        <div class="user-info">
													        	<div class="user-thumb">
														            <c:choose>
															            <c:when test="${not empty sessionScope.sProfile}">
															            	<img src="${sessionScope.sProfile}?${System.currentTimeMillis()}" id="profile_preview">
								<%-- 							                <img src="${member.mem_profile}" id="profile_preview"><br> --%>
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
												            	<c:if test="${review.review_score == '2'}"><span id="score" name="score">최고예요🥳</span></c:if>
													            <c:if test="${review.review_score == '1'}"><span id="score" name="score">좋아요💕</span></c:if>
													            <c:if test="${review.review_score == '0'}"><span id="score" name="score">별로예요👿</span></c:if>
												            </div>
														    <div class="review-text">${review.review_content}</div>
												            <div class="review-score-option">
												            	<%-- 리뷰 옵션 --%>
																<c:if test="${fn:contains(review.review_options, '1')}"><span id="score" name="score">배송이 빨라요🚚</span></c:if>
																<c:if test="${fn:contains(review.review_options, '2')}"><span id="score" name="score">친절해요💖</span></c:if>
																<c:if test="${fn:contains(review.review_options, '3')}"><span id="score" name="score">물건상태가 좋아요✨</span></c:if>
																<c:if test="${fn:contains(review.review_options, '4')}"><span id="score" name="score">또 거래하고 싶어요💰</span></c:if>
																<c:if test="${fn:contains(review.review_options, '5')}"><span id="score" name="score">배송이 느려요😵‍💫</span></c:if>
																<c:if test="${fn:contains(review.review_options, '6')}"><span id="score" name="score">채팅 답장이 느려요😫</span></c:if>
																<c:if test="${fn:contains(review.review_options, '7')}"><span id="score" name="score">물건 상태가 사진과 달라요💣</span></c:if>
												            </div>
												            <div class="product"><a href='ProductDetail?PRODUCT_ID=${review.product_id}'><b>거래상품</b><span>${review.product_title}</span></a></div>
														</div>
										            </c:forEach>
												</c:otherwise>
											</c:choose>	
										</li>
									</ul>
									
								</div>
							</article>
							
									
							
							
							
								
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
	<script type="text/javascript">
	$(document).ready(function () {
		$("#submitBtn").click(function () {
			//debugger;
			//상점소개 변경하기
			let mem_intro = $("#mem_intro").val();
			console.log(">>>>>>>>>>>"+mem_intro);
			$.ajax({
				url : "MyStoreIntro",
				type : "post",
				dataType : "json",
				data :{mem_intro : mem_intro},
				success: function (response) {
					alert(response);
					// location.reload();
				},
			});
		});
	});
	
	</script>
</body>
</html>