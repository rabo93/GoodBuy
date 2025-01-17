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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat_product.css">

<!-- JS for Page -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/product_detail.js"></script>
<script>
	// 자식 창에서 호출될 리로드 함수
// 	function reloadParent() {
// 		location.reload();
// 	}
</script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<div id="wrapper-bg"></div>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<!-- 신고 모달창 -->
				<section class="item-report-modal">
					<div class="modal-bg" onclick="toggleModal('close')"></div>
					<div class="modal-wrap">
					<h1 class="modal-subject">상품 신고</h1>
						<div class="modal-content">
							<select class="modal-sb" name="modal-sb">
								<option value="상품 설명에 불법적이거나 음란한 내용이 포함된 경우.">부적절한 상품 내용</option>
								<option value="상품 정보가 실제 상품과 다르거나 고객을 속이는 내용이 포함된 경우.">허위 또는 오해를 유발하는 정보</option>
								<option value="상품 이미지 또는 설명이 저작권을 침해한 경우.">저작권 침해</option>
								<option value="판매가 금지된 불법 상품(예: 위조품, 마약, 무기 등)을 등록한 경우.">불법 상품</option>
								<option value="동일한 상품을 여러 번 등록하여 스팸성으로 간주되는 경우.">중복 또는 스팸 상품</option>
								<option value="기타 사유를 입력해주세요.">기타</option>
							</select>
							<textarea class="modal-otherReason" readonly placeholder="기타 사유를 입력해주세요."></textarea>
						</div>
						<div class="modal-btnGroup">
							<button class="model-report-btn" type="button" id="itemReporting">
								신고하기
							</button>
							<button class="model-close-btn" type="button" onclick="toggleModal('close')">
								닫기
							</button>
						</div>
					</div>	
				</section>
				<section class="ch-report-modal">
					<div class="ch-modal-bg" onclick="toggleChatModal('close')"></div>
					<div class="ch-modal-wrap">
						<div class="ch-modal-content">
							<select class="ch-modal-sb" name="ch-modal-sb">
								<option value="다른 회원에게 욕설, 비방, 또는 부적절한 언어를 사용한 경우.">욕설 및 비방</option>
								<option value="거래 중 금전적 피해를 입히거나 사기 행위를 시도한 경우.">사기 의심</option>
								<option value="반복적으로 광고성 메시지를 보내거나 스팸 활동을 한 경우.">스팸 또는 홍보</option>
								<option value="회원 프로필 사진 또는 정보에 음란물, 폭력적인 이미지 등이 포함된 경우.">부적절한 프로필</option>
								<option value="다른 회원의 개인정보를 동의 없이 공개하거나 유포한 경우.">타인의 개인정보 노출</option>
								<option value="기타 사유를 입력해주세요.">기타</option>
							</select>
							<textarea class="ch-modal-otherReason" readonly ></textarea>
						</div>
						<div class="ch-report-btn">
							<button class="ch-model-report-btn" type="button" id="chatReporting">
								신고하기
							</button>
							<button class="ch-model-close-btn" type="button" onclick="toggleChatModal('close')">
								닫기
							</button>
						</div>
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
								<c:when test="${productSearch.product_shipping_fee != '' && productSearch.product_shipping_fee != undefined}">
									<div class="item-detail-shpping-fee">배송비:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${productSearch.product_shipping_fee} 원</div>
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
											<c:when test="${sessionScope.sId eq productSearch.mem_id}">
												<input type="button" value="상품 수정하기" class="item-detail-editItem" id="editItem">
												<input type="button" value="상품 삭제" class="item-detail-removeItem" id="removeItem">
											</c:when>
											<c:when test="${productSearch.product_status == 1}">
												<h2 class="trade-status">이 상품은 거래중인 상품입니다.</h2>
											</c:when>
											<c:when test="${productSearch.product_status == 2}">
												<h2 class="trade-status">이 상품은 예약중인 상품입니다.</h2>
												<a href="javascript:void(0)"  onclick="toggleSlideChat()">
													<input type="button" value="판매자에게 톡하기" class="item-detail-contact-seller">
												</a>
											</c:when>
											<c:when test="${productSearch.product_status == 3}">
												<h2 class="trade-status">이 상품은 판매완료된 상품입니다.</h2>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${wishSearch.wishlist_id != '' && wishSearch.wishlist_id != undefined}">
														<input type="button" value="찜 삭제하기" class="item-detail-fav" id="removeWish">
													</c:when>
													<c:otherwise>
														<input type="button" value="찜 하기" class="item-detail-fav" id="addWish">
													</c:otherwise>
												</c:choose>
												<a href="javascript:void(0)"  onclick="toggleSlideChat()">
													<input type="button" value="판매자에게 톡하기" class="item-detail-contact-seller">
												</a>
											</c:otherwise>
										</c:choose>
										<input type="hidden" id="sId" value="${sessionScope.sId}">
										<input type="hidden" id="sNick" value="${sessionScope.sNick}">
										<input type="hidden" id="receiver_id" value="${productSearch.mem_id}">
										<input type="hidden" id="product_id" value="${productSearch.product_id}">
									</c:if>
								</c:if>
							</div>
							<c:if test="${not empty sessionScope.sId && sessionScope.sId != productSearch.mem_id}">
								<button type="button" onclick="toggleModal('open')" class="item-report">
									<i class="fa-solid fa-land-mine-on"></i>&nbsp;이 상품 신고하기
								</button>
							</c:if>
						</div>
					</div>
					<div class="item-detail-seller-info" id="shop-detail" style=" cursor: pointer;">
						<img src="${productSearch.mem_profile}" class="item-detail-seller-pic">
						<input type="hidden" name="viewer-id" value="${sessionScope.sId}">
						<input type="hidden" name="wishlistCheck" value="${wishSearch.wishlist_id}">
						<div class="item-detail-seller-nick" id="item-seller-nick">${productSearch.mem_nick}</div>
						<div class="item-detail-seller-review">
							<div class="star-bg">
								<c:if test="${not empty searchSellerScore}">
							        좋아요 + ${searchSellerScore.Good}
								</c:if>
							</div>
						</div>
					</div>
					<div class="item-detail-more-item">
						<c:if test="${not empty searchSellerProduct}">
							<h1 class="sec-ttl">
							이 판매자가 판매하는 다른 물품
							<button class="more" onclick="location.href='ProductList?SEARCHKEYWORD=${productSearch.mem_nick}'"><i class="fa-solid fa-chevron-right"></i></button>
							</h1>
							<div class="product-list">
								<ul class="product-wrap">
									<!-- 8개 -->
									<c:forEach items="${searchSellerProduct}" var="list" step="1" end="3">
										<li class="product-card" onclick="location.href='ProductDetail?PRODUCT_ID=${list.PRODUCT_ID}'">
											<div class="product-thumb">
												<c:choose>
													<c:when test="${list.PRODUCT_STATUS == 1}">
														<div class="status" id="status">거래중</div>
													</c:when>
													<c:when test="${list.PRODUCT_STATUS == 2}">
														<div class="status" id="status">예약중</div>
													</c:when>
												</c:choose>
												<img src="${pageContext.request.contextPath}/resources/upload/${list.PRODUCT_PIC1}" class="card-thumb" alt="thumbnail" />
											</div>
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
													<c:if test="${list.PRODUCT_TRADE_ADR1 != ''}">
														<span class="add">${list.PRODUCT_TRADE_ADR1}</span>
													</c:if>
													<span class="name">${list.MEM_NICK}</span>
													<span class="time">
														<script type="text/javascript">
															moment.locale('ko')
															$(".time").text(moment(`${list.PRODUCT_REG_DATE}`, "YYYYMMDDhhmmss").fromNow())
														</script>
													</span>
												</div>
											</div>
										</li>	
									</c:forEach>
								</ul>
							</div>
						</c:if>
						<c:if test="${not empty searchSameCategoryProduct}">
							<h1 class="sec-ttl">
							이 상품과 비슷한 상품
							<button class="more" onclick="location.href='ProductList?SEARCHKEYWORD=${productSearch.product_category}'"><i class="fa-solid fa-chevron-right"></i></button>
							</h1>
							<div class="product-list">
								<ul class="product-wrap">
									<!-- 8개 -->
									<c:forEach items="${searchSameCategoryProduct}" var="list" step="1" end="3">
										<li class="product-card" onclick="location.href='ProductDetail?PRODUCT_ID=${list.PRODUCT_ID}'">
											<div class="product-thumb">
												<c:choose>
													<c:when test="${list.PRODUCT_STATUS == 1}">
														<div class="status" id="status">거래중</div>
													</c:when>
													<c:when test="${list.PRODUCT_STATUS == 2}">
														<div class="status" id="status">예약중</div>
													</c:when>
												</c:choose>
											</div>
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
													<c:if test="${list.PRODUCT_TRADE_ADR1 != ''}">
														<span class="add">${list.PRODUCT_TRADE_ADR1}</span>
													</c:if>
													<span class="name">${list.MEM_NICK}</span>
													<span class="time">
														<script type="text/javascript">
															moment.locale('ko')
															$(".time").text(moment(`${list.PRODUCT_REG_DATE}`, "YYYYMMDDhhmmss").fromNow())
														</script>
													</span>
												</div>
											</div>
										</li>	
									</c:forEach>
								</ul>
							</div>
						</c:if>
					</div>
				</section>
				<div class="chat-container">
					<div class="chat-area">
						<div class="extra-header">
							<button class="close-chat-button" onclick="toggleSlideChat()">
								<i class="fa-solid fa-arrow-left"></i>
							</button>
							<button class="report-chat-button" onclick="toggleChatModal('open')">
								<i class="fa-solid fa-land-mine-on"></i>&nbsp;신고하기
							</button>
						</div>
						<div class="chat-header">
			            	<a><img src="${pageContext.request.contextPath}/resources/upload/${productSearch.product_pic1}"></a>
			                <div class="chat-title">${productSearch.product_title}</div>
			                <button class="chat-item-button" onclick="requestReservation(${productSearch.product_id})">예약요청</button>
<%-- 			                <c:if test="${productSearch.product_status == 3}"> --%>
<!-- 			               		<button class="chat-item-button" style="background-color: var(--gray)">판매완료된 상품</button> -->
<%-- 			               	</c:if> --%>
<%-- 			               	<c:if test="${productSearch.product_status != 3}"> --%>
<%-- 			                <button class="chat-item-button" onclick="openPayWindow('${productSearch.product_id}' , '${productSearch.mem_id}')">구매하기</button> --%>
<!-- 							<button class="report-chat-button" onclick="toggleChatModal('open')"> -->
<!-- 								<i class="fa-solid fa-land-mine-on"></i>&nbsp;신고하기 -->
<!-- 							</button> -->
<%-- 		                	<button class="chat-item-button" onclick="openPayWindow('${productSearch.product_id}' , '${productSearch.mem_id}')">구매하기</button> --%>
			            </div>
			            <div class="chat-body">
			            </div>
			            <div class="chat-footer">
			            	<input type="hidden" id="chat-mem-nick" value="${productSearch.mem_nick}">
			            	<input type="hidden" id="chat-mem-profile" value="${productSearch.mem_profile}">
			            	<!-- hidden 작업 생각중 -->
			            	<span class="fileArea">
					           	<label for="chatFile"><i class="fa-solid fa-circle-plus"></i></label>
					           	<input type="file" id="chatFile" onchange="sendFile()" accept="image/*">
				           	</span>
			                <input type="text" class="chatMessage" placeholder="메시지를 입력하세요...">
			                <button class="btnSend">전송</button>
			            </div>
					</div>
				</div>
				<script src="${pageContext.request.contextPath}/resources/js/chat_product.js"></script>
<!-- 				<script type="text/javascript"> -->
<!-- // 					function requestReservation(product_id) { -->
<!-- // 						alert(product_id); -->
<!-- // 					} -->
<!-- 				</script> -->
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>
</html>