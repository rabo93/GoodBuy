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
<!-- Include stylesheet -->
<link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet" />

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
				<a href="MyStore" class="active">나의 상점</a>
				<a href="GoodPay">굿페이</a>
				<a href="MyOrder">구매내역</a>
				<a href="MySales">판매내역</a>
				<h3>나의 정보</h3>
				<a href="MyInfo">계정정보</a>
				<a href="MyWish">관심목록</a>
				<a href="MyReview">나의 후기</a>
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
								<div>
								
								</div>
								
								<div class="set">
									<div>
										<img src="${pageContext.request.contextPath}/resources/img/user_thumb.png" id="profile_preview" height="60px"><br>
										<h3>${sessionScope.sNick}의 상점</h3><br> 
									</div>
								</div>
									
								<div class="set">
									<label>상점 소개</label>
									<input type="hidden" id = "mem_id" value="${member.mem_id}"> 
<%-- 									<input type="text" name="mem_intro" id="mem_intro" value="${member.mem_intro}"> --%>
											<textarea rows="5" cols="50" name="mem_intro" id="mem_intro">${member.mem_intro}</textarea>
									<!-- Create the editor container -->
<!-- 									<div id="editor"  name="mem_intro"> -->
<!-- 									  <p>상점소개를 입력해주세요	</p> -->
<!-- 									</div> -->
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
										<!-- 판매 상품영역	-->
										<li class="product-card">
											<c:choose>
												<c:when test="${empty product}">
													<ul>
														<li>등록된 상품이 없습니다.</li>
													</ul>
												</c:when>
												<c:otherwise>
													<c:forEach var="product" items="${product}">
														<ul>
															<li class="product-card">
																<img src="${pageContext.request.contextPath}/resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
																<div class="card-info">
																	<div class="category">
																		<span>${product.product_category }</span>
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
																			<c:when test="${product.product_status == 3 }">
																				[거래완료]
																			</c:when>
																			<c:otherwise> 
																			<!-- 널스트링 출력 -->
																			</c:otherwise>
																		</c:choose>
																		${product.product_title}
																	</div>
																	<div class="price"><fmt:formatNumber type="number" value="${product.product_price}" pattern="#,###"/>원</div>
																	<div class="card-row">
																		<span class="add">${product.product_trade_adr1 }</span>
																		<span class="name">${product.mem_nick }</span>
																		<span class="time">1분 전</span>
																	</div>
																</div>
															</li>
														</ul>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</li>
									</ul>
								</div>
							</form>
							
							<form action="" class="my-frm">
								<div>
									<h3 class="contents-ttl">나의 거래 후기 <small>(총 <span>${reviewCount}</span>건)</small><a href="MyReview"><small> 더보기></small></a></h3>
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
														            <div class="name">${review.buyerNick}</div>
														            <div class="product">${review.product_title}</div>
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
										</li>
									</ul>
									
								</div>
							</form>
						</div>
					</section>
					<!-- // contents -->
				</div>
			</div>
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
	<!-- Include the Quill library -->
	<script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
	
	<!-- Initialize Quill editor -->
	<script>
	  const quill = new Quill('#editor', {
	    theme: 'snow'
	  });
	</script>

</body>
</html>