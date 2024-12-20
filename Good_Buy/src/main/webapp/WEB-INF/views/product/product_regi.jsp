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
				<section class="item-regi">
					<div>
						<h2 class="page-title">상품 등록</h2>
						<form action="item-regi-submit" method="post">
							<section class="item-regi-img">
								<h2 class="item-regi-name">상품이미지</h2>
								<div class="item-thumb">
										<i class="fa-light fa-image"></i>
									<button class="item-thumb-upload" type="button" onclick="onClickUpload1()">
										<img id="item-thumb-preview1">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn1" >
								</div>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button" onclick="onClickUpload2()">
										<img id="item-thumb-preview2">
										
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn2" >
								</div>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button" onclick="onClickUpload3()">
										<img id="item-thumb-preview3">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn3" >
								</div>
								<h2 class="item-thumb-description">첫번째 상품 이미지는 썸네일로 보여져요.</h2>
							</section>
							<section class="item-regi-section">
								<h2 class="item-regi-name">상품명</h2>
								<div class="item-regi-box">
									<input type="text" class="item-regi-title-text">
									<a href="#">거래금지 품목 보기</a>
								</div>
								<h6 class="item-regi-name-byte">(0/50)</h6>
							</section>
							<section class="item-regi-section">
								<h2 class="item-regi-name">상품설명</h2>
									<div><textarea class="item-regi-description-text"></textarea>
								</div>
								<h6 class="item-regi-description-byte">(0/2000)</h6>
							</section>
							<section class="item-regi-category">
								<h6 class="item-regi-category-name">카테고리 & 태그</h6>
								<select class="item-regi-category-box">
									<option>여성의류</option>
									<option>남성의류</option>
									<option>레저/스포츠</option>
									<option>생활용품</option>
									<option>키즈</option>
									<option>도서</option>
								</select>
							</section>
							<section class="item-regi-trade-adr">
								<h6 class="item-regi-name">직거래 주소 설정</h6>
								<div class="item-regi-trade-active">
									<label><input type="radio" name="trade-adr-val" id="trade-enable">직거래 가능</label>
									<label><input type="radio" name="trade-adr-val" id="trade-disable">직거래 불가능</label>
									<div class="item-trade-adr-box">
										<input type="text" class="item-trade-adr-main">
										<div>
											<input type="text" class="item-trade-adr-sub">
											<input type="button" class="item-trade-adr-search" value="주소검색">
										</div>
									</div>
								</div>	
							</section>
							<ul class="item-regi-price">
								<li class="item-regi-name">상품설명</li>
								<li><input type="radio" name="shipping-fee" id="shipping-fee-disable"><label for="shipping-fee-disable">택배비 포함</label></li>
								<li><input type="radio" name="shipping-fee" id="shipping-fee-enable"><label for="shipping-fee-enable">택배비 미포함</label></li>
								<li><input type="number" class="shipping-fee-price"></li>
								<li><input type="number" class="item-price"></li>
								<li><input type="checkbox" class="item-discount">가격 제안 가능</li>
							</ul>
						</form>
						<input type="button" class="item-backpage">
						<input type="submit" class="item-submit">
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

<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$("#item-thumb-upload-btn1").on("change", function(event) {
	
	    var file = event.target.files[0];
	
	    var reader = new FileReader(); 
	    reader.onload = function(e) {
	
	        $("#item-thumb-preview1").attr("src", e.target.result);
	    }
	
	    reader.readAsDataURL(file);
	});
	$("#item-thumb-upload-btn2").on("change", function(event) {
	
	    var file = event.target.files[0];
	
	    var reader = new FileReader(); 
	    reader.onload = function(e) {
	
	        $("#item-thumb-preview2").attr("src", e.target.result);
	    }
	
	    reader.readAsDataURL(file);
	});
	$("#item-thumb-upload-btn3").on("change", function(event) {
	
	    var file = event.target.files[0];
	
	    var reader = new FileReader(); 
	    reader.onload = function(e) {
	
	        $("#item-thumb-preview3").attr("src", e.target.result);
	    }
	
	    reader.readAsDataURL(file);
	});
</script>
</html>