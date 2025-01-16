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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css">

<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<section class="wrapper">
			<!-- *********** 여기 안에 작업하세요. section.wrapper 건들지말기 ******** -->
			
			<!-- section01. 메인 비주얼 배너 -->
			<section id="sec01" class="sec-full">
				<div class="sec-inner">
					<div class="visual-area">
						<div class="main-visual">
<%-- 							<div><img src="${pageContext.request.contextPath}/resources/img/main_visual_01.jpg" alt="배너1"></div> --%>
<%-- 							<div><img src="${pageContext.request.contextPath}/resources/img/main_visual_02.jpg" alt="배너1"></div> --%>
<%-- 							<div><img src="${pageContext.request.contextPath}/resources/img/main_visual_03.jpg" alt="배너1"></div> --%>
							<div>
								<section class="ban-wrap">
									<div class="ban-text">
										<span class="ttl">가까운 이웃은 직접 만나서, 먼 곳은 택배로 간편하게!</span>
										<span class="subttl">쉽고 간편한 중고 거래를 시작해보세요.</span>
									</div>
									<img src="${pageContext.request.contextPath}/resources/img/ban_01.png">
								</section>
							</div>
							<div>
								<section class="ban-wrap">
									<div class="ban-text">
										<span class="ttl">굿바이 페이를 이용해 수수료 없이 편하게 거래해보세요!</span>
										<span class="subttl">언제 어디서든, 손쉽게 거래할 수 있어요!</span>
									</div>
									<img src="${pageContext.request.contextPath}/resources/img/ban_02.png">
								</section>
							</div>
						</div>
						<a href="#" class="visu-prev"><i class="fa-solid fa-chevron-left"></i></a>
						<a href="#" class="visu-next"><i class="fa-solid fa-chevron-right"></i></a>
					</div>
					<input type="hidden" value="${member.mem_profile}" id="hide">
				</div>
				<script>
					$(document).ready(function(){
						console.log($("#hide").val());
						// section01. 메인 비주얼 슬라이드
						$(".main-visual").slick({
							infinite : true, 
							autoplay: true,
							autoplaySpeed : 5000,
							dots: true,
							speed : 400,	
							arrows : true,
							prevArrow : $('.visu-prev'),		// 이전 화살표 모양 설정
							nextArrow : $('.visu-next'),		// 다음 화살표 모양 설정
							pauseOnHover : false,
							draggable : true
						});
					});
				</script>
			</section>
			<!-- section02. 실시간 인기 클래스 -->
			<section id="sec02" class="sec">
				<div class="sec-inner">
					<h1 class="sec-ttl">
						굿바이 추천 상품
						<button class="more" type="button" onclick="location.href='ProductList'"><i class="fa-solid fa-chevron-right"></i></button>
					</h1>
					<div class="product-list">
						<ul class="product-wrap" id="product-wrap">
							<!-- 8개 -->
							<c:forEach items="${recommeded}" var="list" step="1" end="7">
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
				</div>
			</section>
			<section id="sec03" class="sec">
				<div class="sec-inner">
					<h1 class="sec-ttl">
						굿바이 상품 모아보기
						<button class="more" type="button" onclick="location.href='ProductList'"><i class="fa-solid fa-chevron-right"></i></button>
					</h1>
					<div class="product-list">
						<ul class="product-wrap" id="product-wrap2">
						</ul>
					</div>
				</div>
			</section>
			<!-- *********** // 여기 안에 작업하세요. section.wrapper 건들지말기 ******** -->
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>
</html>