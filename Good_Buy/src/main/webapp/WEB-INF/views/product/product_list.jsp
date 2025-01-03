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
<script src="${pageContext.request.contextPath}/resources/js/product_search.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<section class="product-item-wrap">
					<!-- navbar -->
					<aside class="item-sch-area">
						<div class="sch-inner">
							<section class="sch-box">
								<h2>검색 필터</h2>
								<label class="filter-name">
									<input type="checkbox" class="trade-box" name="trade-box">
									거래가능한 상품만 보기
								</label>
							</section>
							<section class="sch-box">
								<h2>가격</h2>
								<label><input type="radio" class="ip-chk rd1" name="ip-chk" value="5000"> 5,000원 이하</label>
								<label><input type="radio" class="ip-chk rd2" name="ip-chk" value="10000"> 10,000원 이하</label>
								<label><input type="radio" class="ip-chk rd3" name="ip-chk" value="20000"> 20,000원 이하</label>
								<div class="ip-num">
									<input type="number" placeholder="부터" class="ip-num1" name="ip-num1" value="0"> ~ <input type="number" placeholder="까지" class="ip-num2" name="ip-num2" value="0">
								</div>
							</section>
							<section class="sch-box">
								<h2>지역</h2>
								<input type="text" class="ip-tt" name="regionSearch" onkeypress="addAdrEnter(event)">
								<input type="button" class="item-trade-adr-search" value="주소검색" onclick="addAdr()">
								<button type="button" class="sch-box-reset" onclick="fliterReset()">
									<i class="fa-solid fa-arrows-rotate"></i> 초기화
								</button>
							</section>
						</div>
					</aside>
					<article class="item-list-area">
						<!-- product-list -->
						<div class="product-list">
							<ul class="product-wrap" id="product-wrap">
								<!-- 8개 -->
								<c:forEach items="${searchProductList}" var="list">
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
					</article>
				</section>
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
<%-- 	<jsp:include page="/WEB-INF/views/product/product_list_script.jsp"></jsp:include> --%>
</body>
</html>