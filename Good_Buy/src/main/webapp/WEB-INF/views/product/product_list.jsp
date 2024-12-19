<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css">

<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/product.js"></script>

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
							<h2>검색 필터</h2>
							<ul class="sch-box-line"></ul>
							<ul class="sch-box">
								<li><input type="checkbox" class="">거래가능한 상품만 보기</li>
							</ul>
							<ul class="sch-box-line"></ul>
							<ul class="sch-box">
								<li class="filter-name">정렬</li>
								<li><input type="radio" class="ip-radio" name="sch-regi-date">최신순</li>
								<li><input type="radio" class="ip-radio" name="sch-regi-date">오래된순</li>
							</ul>
							<ul class="sch-box-line"></ul>
							<ul class="sch-box">
								<li class="filter-name">가격</li>
								<li><input type="checkbox" class="ip-chk">나눔</li>
								<li><input type="checkbox" class="ip-chk">5,000원 이하</li>
								<li><input type="checkbox" class="ip-chk">10,000원 이하</li>
								<li><input type="checkbox" class="ip-chk">20,000원 이하</li>
								<li class="ip-num-box"><input type="number" placeholder="부터" class="ip-num ip-num1"> ~ <input type="number" placeholder="까지" class="ip-num ip-num2"></li>
							</ul>
							<ul class="sch-box-line"></ul>
							<ul class="sch-box">
								<li class="filter-name">지역</li>
								<li><input type="text" class="ip-tt"></li>
							</ul>
							<input type="button" class="sch-box-reset" value="초기화">
						</div>
					</aside>
					<article class="item-list-area">
						<!-- product-list -->
						<div class="product-list">
							<ul class="product-wrap">
								<!-- 8개 -->
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li><li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								<li class="product-card">
									<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
									<div class="card-info">
										<div class="category">
											<span>생활용품</span>
											<span class="type">직거래</span>
										</div>
										<div class="ttl">젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다 젠하이저 H3PRO 팝니다 제목은 두줄까지 가능합니다</div>
										<div class="price">55,000 원</div>
										<div class="card-row">
											<span class="add">부산 해운대구</span>
											<span class="name">홍길동동이</span>
											<span class="time">1분 전</span>
										</div>
									</div>
								</li>
								
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
</body>
</html>