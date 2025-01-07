<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script src="${pageContext.request.contextPath}/resources/js/product_regi.js"></script>

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
						<form action="ProductRegist" method="post" enctype="multipart/form-data">
							<section class="item-regi-img">
								<h2 class="item-regi-name">상품이미지</h2>
								<div class="item-thumb">
										<i class="fa-light fa-image"></i>
									<button class="item-thumb-upload" type="button">
										<img id="item-thumb-preview1">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn1" name="pic1">
								</div>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button">
										<img id="item-thumb-preview2">
										
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn2" name="pic2">
								</div>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button">
										<img id="item-thumb-preview3">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn3" name="pic3">
								</div>
								<h2 class="item-thumb-description">첫번째 상품 이미지는 썸네일로 보여져요.</h2>
							</section>
							<section class="item-regi-section">
								<h2 class="item-regi-name">상품명</h2>
								<div class="item-regi-box">
									<input type="text" name="product_title" class="item-regi-title-text" id="item-regi-title-text" >
									<a href="ProductBanedItem">거래금지 품목 보기</a>
								</div>
								<h6 class="item-regi-name-byte" id="item-regi-name-byte">(0 / 100)</h6>
							</section>
							<section class="item-regi-section">
								<h2 class="item-regi-name">상품설명</h2>
									<div><textarea class="item-regi-description-text" id="item-regi-description-text" name="product_intro"></textarea>
								</div>
								<h6 class="item-regi-description-byte" id="item-regi-description-byte">(0 / 2000)</h6>
							</section>
							<section class="item-regi-category">
								<h6 class="item-regi-category-name">카테고리 & 태그</h6>
								<select class="item-regi-category-box" name="product_category">
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
									<label><input type="radio" name="trade-adr-val" id="trade-enable" value="1" checked>직거래 가능</label>
									<label><input type="radio" name="trade-adr-val" id="trade-disable" value="0">직거래 불가능</label>
									<div class="item-trade-adr-box" id="item-trade-adr-box">
										<div>
											<input type="text" class="item-trade-adr-sub" id="item-trade-adr-sub" name="product_trade_adr1" readonly>
											<input type="button" class="item-trade-adr-search" value="주소검색" onclick="searchAdr()">
										</div>
									</div>
								</div>	
							</section>
							<section class="item-regi-price">
								<h6 class="item-regi-name">상품설명</h6>
								<div class="item-regi-price-box">
									<label><input type="radio" name="shipping-fee" id="shipping-fee-enable"  value="0" checked>택배비 미포함</label>
									<label><input type="radio" name="shipping-fee" id="shipping-fee-disable" value="1">택배비 포함</label>
									<div class="item-regi-price-number">
										<input type="hidden" name="product_shpping_fee" value="0">
										<input type="number" class="shipping-fee-price" id="shipping-fee-price" name="product_shpping_fee" placeholder="택배비를 입력해주세요.">
										<div><input type="number" class="item-price" name="product_price" placeholder="상품 가격을 입력해주세요."></div>
										<input type="hidden" name="product_discount_status" value="0">
										<label class="item-discount-box"><input type="checkbox" class="item-discount" name="product_discount_status" value="1">가격 제안 가능</label>
									</div>
								</div>
							</section>
							<div class="item-regi-submit-group">
								<input type="button" class="item-backpage" onclick="history.back()" value="뒤로 가기">
								<input type="submit" class="item-submit" value="상품 등록">
							</div>
						</form>
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function searchAdr() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.sido + " " + data.sigungu;
                
                document.getElementById("item-trade-adr-sub").value = addr;
            }
        }).open();
    }
</script>
</html>