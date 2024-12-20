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
				<a href="MyInfo" class="active">계정정보</a>
				<a href="MyStore">나의 상점</a>
				<a href="GoodPay">굿페이</a>
				<a href="">나의 광고</a>
				<a href="MyWish">관심목록</a>
				<a href="MyOrder">구매내역</a>
				<a href="MySales">판매내역</a>
				<a href="MyReview">나의 후기</a>
				<a href="MySupport">1:1문의내역</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">나의 상점
				<div class="contents">
					<!-- contents -->
					<section class="my-rev-wrap">
						<div>
							<form action="MyStore" class="my-frm">
								<div>
								<h3>${session.sId}홍길동의 상점</h3><br> 
								</div>
								
								<div class="set">
									<label>프로필 사진</label>
									<div>
									<img src="../../resources/img/profile_default.png" id="preview_profile" height="60px"><br>
										<input type="file" name="memProfile" id="memProfile" value="변경"><br>
									</div>
								</div>
									
								<div class="set">
									<label>상점 소개</label>
									<!-- Create the editor container -->
									<div id="editor">
									  <p>상점소개를 입력해주세요	</p>
									</div>
								</div>
							</form>
							<form action="" class="my-frm">
								<div>
									<h3 class="contents-ttl">등록한 상품목록 <small>(총 <span>${reviewCount}</span>건)</small> <a href=""><small> 더보기></small></a></h3>
								</div>
								<div class="product-list">
									<ul class="product-wrap">
										<!-- 3개 -->
										<li class="product-card">
											<img src="../../resources/img/product_thumb.jpg" class="card-thumb" alt="thumbnail" />
											<div class="card-info">
												<div class="category">
													<span>생활용품</span>
													<span class="type">직거래</span>
												</div>
												<div class="ttl">젠하이저 H3PRO 팝니다</div>
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
												<div class="ttl">222</div>
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
												<div class="ttl">333</div>
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
												<div class="ttl">444</div>
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
							</form>
							
							<form action="" class="my-frm">
								<div>
									<h3 class="contents-ttl">나의 거래 후기 <small>(총 <span>${reviewCount}</span>건)</small><a href=""><small> 더보기></small></a></h3>
									<!-- 후기 3개 -->
									<ul class="review-wrap">
										<li class="reviewInfo-wrap">
											<img src="../../resources/img/user_thumb.png" class="card-thumb" alt="thumbnail" />
											<div class="user-info">
									            <div class="name">홍길동</div>
									            <div class="date">24/12/18</div>
									      	</div>
									        <div class="content">친절한 응대 감사합니다.</div>
										</li>
										
										<li class="reviewInfo-wrap">
											<img src="../../resources/img/user_thumb.png" class="card-thumb" alt="thumbnail" />
											<div class="user-info">
									            <div class="name">푸바오</div>
									            <div class="date">24/12/18</div>
									      	</div>
									        <div class="content">친절한 응대 감사합니다.</div>
										</li>
										
										<li class="reviewInfo-wrap">
											<img src="../../resources/img/user_thumb.png" class="card-thumb" alt="thumbnail" />
											<div class="user-info">
									            <div class="name">송강</div>
									            <div class="date">24/12/18</div>
									      	</div>
									        <div class="content">친절한 응대 감사합니다.</div>
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