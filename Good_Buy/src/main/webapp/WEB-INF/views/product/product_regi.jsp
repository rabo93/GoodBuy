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
						<h2>상품 등록</h2>
						<ul class="item-regi-line"></ul>
						<form action="item-regi-submit" method="post">
							<ul class="item-regi-img">
								<li class="item-regi-name">상품이미지</li>
								<li class="item-regi-img-count">(0/3)</li>
								<li class="item-thumb">
									<button class="item-thumb-upload" type="button" onclick="onClickUpload1()">
										<img src="../../resources/img/product_thumb.jpg" id="item-thumb-preview1">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn1" >
								</li>
								<li class="item-thumb">
									<button class="item-thumb-upload" type="button" onclick="onClickUpload2()">
										<img src="../../resources/img/product_thumb.jpg" id="item-thumb-preview2">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn2" >
								</li>
								<li class="item-thumb">
									<button class="item-thumb-upload" type="button" onclick="onClickUpload3()">
										<img src="../../resources/img/product_thumb.jpg" id="item-thumb-preview3">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn3" >
								</li>
								<li class="item-regi-name">첫번째 상품 이미지는 썸네일로 보여져요.</li>
							</ul>
							<ul class="item-regi-title">
								<li class="item-regi-name">상품명</li>
								<li><input type="text" class="item-regi-title-text"></li>
								<li class="item-regi-title-byte">(0/50)</li>
							</ul>
							<ul class="item-regi-title-banlist"><a href="#">거래금지 품목 보기</a></ul>
							<ul class="item-regi-description">
								<li class="item-regi-name">상품설명</li>
								<li><textarea class="item-regi-description-text"></textarea></li>
								<li class="item-regi-description-byte">(0/2000)</li>
							</ul>
							<ul class="item-regi-category">
								<li class="item-regi-name">카테고리 & 태그</li>
								<li class="item-regi-category-box">
									<select>
										<option>여성의류</option>
										<option>남성의류</option>
										<option>레저/스포츠</option>
										<option>생활용품</option>
										<option>키즈</option>
										<option>도서</option>
									</select>
								</li>
								<li><input type="text" class="item-regi-category-tag"></li>
							</ul>
							<ul class="item-regi-trade-adr">
								<li class="item-regi-name">상품설명</li>
								<li><input type="radio" name="trade-adr-val" id="trade-enable"><label for="trade-enable">직거래 가능</label></li>
								<li><input type="radio" name="trade-adr-val" id="trade-disable"><label for="trade-disable">직거래 불가능</label></li>
								<li><input type="text" class="item-trade-adr-main"></li>
								<li><input type="button" class="item-trade-adr-search" value="주소검색"></li>
								<li><input type="text" class="item-trade-adr-sub"></li>
							</ul>
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