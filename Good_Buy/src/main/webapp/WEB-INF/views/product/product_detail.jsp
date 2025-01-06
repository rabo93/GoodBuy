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
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/product_detail.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<!-- 신고 모달창 -->
				<section class="item-report-modal">
					<div class="modal-bg" onclick="toggleModal(close)"></div>
					<div class="modal-wrap">
						<div class="modal-content">
							<select class="modal-sb" name="modal-sb">
								<option value="상품 설명에 불법적이거나 음란한 내용이 포함된 경우.">부적절한 상품 내용</option>
								<option value="상품 정보가 실제 상품과 다르거나 고객을 속이는 내용이 포함된 경우.">허위 또는 오해를 유발하는 정보</option>
								<option value="상품 이미지 또는 설명이 저작권을 침해한 경우.">저작권 침해</option>
								<option value="판매가 금지된 불법 상품(예: 위조품, 마약, 무기 등)을 등록한 경우.">불법 상품</option>
								<option value="동일한 상품을 여러 번 등록하여 스팸성으로 간주되는 경우.">중복 또는 스팸 상품</option>
								<option value="기타 사유를 입력해주세요.">기타</option>
							</select>
							<textarea class="modal-otherReason" readonly textho></textarea>
							<button class="model-report-btn" type="button" onclick="itemReporting()">
								신고하기
							</button>
						</div>
						<button class="model-close-btn" type="button" onclick="toggleModal(close)">
							닫기
						</button>
					</div>	
				</section>
				<!-- 상품 페이지 -->
				<section class="item-detail">
					<div class="item-detail-content">
						<div class="item-detail-pic">
							<div class="thumb-slide">
								<div><img src="${pageContext.request.contextPath}/resources/upload/${productSearch.product_pic1}"></div>
								<c:if test="${not empty productSearch.product_pic2}">
									<div><img src="${pageContext.request.contextPath}/resources/upload/${productSearch.product_pic2}"></div>
								</c:if>
								<c:if test="${not empty productSearch.product_pic3}">
									<div><img src="${pageContext.request.contextPath}/resources/upload/${productSearch.product_pic3}"></div>
								</c:if>
							</div>
							<a href="#" class="visu-prev"><i class="fa-solid fa-chevron-left"></i></a>
							<a href="#" class="visu-next"><i class="fa-solid fa-chevron-right"></i></a>
						</div>
						<script>
							const itemPrice = ${productSearch.product_price};
							$(document).ready(function(){
								$(".thumb-slide").slick({
									autoplay: true,         // 자동 재생 설정 (true or false)
									dots: true,             // 페이지 네비게이션 점 보이기 설정 (true or false)
									arrows: true,           // 이전/다음 버튼 보이기 설정 (true or false)
									infinite: true,         // 무한 롤링 설정 (true or false)
									speed: 500,             // 슬라이드 전환 속도 (밀리초 단위)
									slidesToShow: 1,        // 한 화면에 보여줄 슬라이드 개수
									slidesToScroll: 1,
									prevArrow : $('.visu-prev'),		// 이전 화살표 모양 설정
									nextArrow : $('.visu-next'),		// 다음 화살표 모양 설정
									draggable : true
								});
							});
						</script>
						<div class="item-detail-content-text">
							<c:if test="${productSearch.product_status == 4}">
								<div class="reporting-item">이 상품은 신고처리되었습니다.</div>
							</c:if>
							<div class="item-detail-title" id="product-title">${productSearch.product_title}</div>
							<div class="item-detail-view">
								<div class="item-detail-view-count">조회수 ${productSearch.view_count}</div>
								<div class="item-detail-fav-count">찜 <c:choose><c:when test="${wishSearch != null}">${wishSearch.wishlist_count}</c:when><c:otherwise>0</c:otherwise></c:choose></div>
							</div>
							<div class="item-detail-description">${productSearch.product_intro}</div>
							<c:choose>
								<c:when test="${productSearch.product_shpping_fee != '' && productSearch.product_shpping_fee != undefined}">
									<div class="item-detail-shpping-fee">배송비:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${productSearch.product_shpping_fee} 원</div>
								</c:when>
								<c:otherwise>
									<div class="item-detail-shpping-fee">배송비 포함</div>
								</c:otherwise>
							</c:choose>
							<div class="item-detail-price-setting">
							<c:if test="${productSearch.product_discount_status == 1}">
								<div class="item-detail-discount">가격제안 가능</div>
							</c:if>
								<div class="item-detail-price">
									<fmt:formatNumber type="number" maxFractionDigits="3" value="${productSearch.product_price}"/> 원
								</div>
							</div>
							<div class="item-detail-button-group">
								<c:if test="${productSearch.product_trade_adr1 != '' && productSearch.product_trade_adr1 != undefined}">
									<div class="item-detail-trade-adr">직거래 위치: ${productSearch.product_trade_adr1}</div>
								</c:if>
								<c:if test="${not empty sessionScope.sId}">
									<c:if test="${productSearch.product_status != 4}">
										<c:choose>
											<c:when test="${wishSearch.wishlist_id != '' && wishSearch.wishlist_id != undefined}">
												<input type="button" value="찜 삭제하기" class="item-detail-fav" id="removeWish" onclick="removeWishlist()">
											</c:when>
											<c:otherwise>
												<input type="button" value="찜 하기" class="item-detail-fav" id="addWish" onclick="addWishlist()">
											</c:otherwise>
										</c:choose>
										<a href="javascript:void(0)"  onclick="openSlideChat('${productSearch.mem_id}','${productSearch.product_id}' )">
											<input type="button" value="판매자에게 톡하기" class="item-detail-contact-seller">
										</a>
									</c:if>
								</c:if>
							</div>
							<c:if test="${not empty sessionScope.sId}">
								<a href="javascript:void(0)" onclick="toggleModal(open)" class="item-report">
									<i class="fa-solid fa-land-mine-on"></i>&nbsp;이 상품 신고하기
								</a>
							</c:if>
						</div>
					</div>
					<div class="item-detail-seller-info" onclick="location.href='ProductShop'" style=" cursor: pointer;">
						<img src="${productSearch.mem_profile}" class="item-detail-seller-pic">
						<input type="hidden" name="seller-id" value="${sessionScope.sId}">
						<input type="hidden" name="wishlistCheck" value="${wishSearch.wishlist_id}">
						<div class="item-detail-seller-nick">${productSearch.mem_nick}</div>
						<div class="item-detail-seller-review">★★★★★</div>
					</div>
					<div class="item-detail-more-item">
						<h1 class="sec-ttl">
						이 판매자가 판매하는 다른 물품
						<button class="more"><svg class="svg-inline--fa fa-chevron-right" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M310.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-192 192c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L242.7 256 73.4 86.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l192 192z"></path></svg><!-- <i class="fa-solid fa-chevron-right"></i> Font Awesome fontawesome.com --></button>
						</h1>
						<div class="product-list">
							<ul class="product-wrap">
								<!-- 8개 -->
								<c:forEach items="${searchSellerProduct}" var="list" step="1" end="3">
									<li class="product-card" onclick="location.href='ProductDetail?PRODUCT_ID=${list.PRODUCT_ID}'">
										<img src="${pageContext.request.contextPath}/resources/upload/${list.PRODUCT_PIC1}" class="card-thumb" alt="thumbnail" />
										<div class="card-info">
											<div class="category">
												<span>${list.PRODUCT_CATEGORY}</span>
												<c:if test="${list.PRODUCT_TRADE_ADR1 != ''}">
													<span class="type">직거래</span>
												</c:if>
											</div>
											<div class="ttl">${list.PRODUCT_TITLE}</div>
											<div class="price">
											 	<fmt:formatNumber var="price" value="${list.PRODUCT_PRICE}" type="number"/>
											 	${price} 원
											 </div>
											<div class="card-row">
												<span class="add">${list.PRODUCT_TRADE_ADR1}</span>
												<span class="name">${list.MEM_NICK}</span>
												<span class="time"></span>
											</div>
										</div>
									</li>	
								</c:forEach>
							</ul>
						</div>
						<h1 class="sec-ttl">
						이 상품과 비슷한 상품
						<button class="more"><svg class="svg-inline--fa fa-chevron-right" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M310.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-192 192c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L242.7 256 73.4 86.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l192 192z"></path></svg><!-- <i class="fa-solid fa-chevron-right"></i> Font Awesome fontawesome.com --></button>
						</h1>
						<div class="product-list">
							<ul class="product-wrap">
								<!-- 8개 -->
								<c:forEach items="${searchSameCategoryProduct}" var="list" step="1" end="3">
									<li class="product-card" onclick="location.href='ProductDetail?PRODUCT_ID=${list.PRODUCT_ID}'">
										<img src="${pageContext.request.contextPath}/resources/upload/${list.PRODUCT_PIC1}" class="card-thumb" alt="thumbnail" />
										<div class="card-info">
											<div class="category">
												<span>${list.PRODUCT_CATEGORY}</span>
												<c:if test="${list.PRODUCT_TRADE_ADR1 != ''}">
													<span class="type">직거래</span>
												</c:if>
											</div>
											<div class="ttl">${list.PRODUCT_TITLE}</div>
											<div class="price">
											 	<fmt:formatNumber var="price" value="${list.PRODUCT_PRICE}" type="number"/>
											 	${price} 원
											 </div>
											<div class="card-row">
												<span class="add">${list.PRODUCT_TRADE_ADR1}</span>
												<span class="name">${list.MEM_NICK}</span>
												<span class="time"></span>
											</div>
										</div>
									</li>	
								</c:forEach>
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
</html>