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
<link rel="stylesheet" href="../../resources/css/common.css">
<link rel="stylesheet" href="../../resources/css/default.css">
<script src="../../resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet" href="../../resources/fontawesome/all.min.css" />
<script src="../../resources/fontawesome/all.min.js"></script>

<!-- ******************* 아래 CSS와 JS는 페이지별로 알맞게 Import 해주세요 ****************** -->
<!-- CSS for Page -->
<link rel="stylesheet" href="../../resources/css/product.css">
<link rel="stylesheet" href="../../resources/css/pay.css">

<!-- JS for Page -->
<script src="../../resources/js/product.js"></script>


<style>


</style>











</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<div class="goodpay-container">
			        
			        
			        
			
			        <!-- 계좌 선택 -->
			        <div class="account-dropdown">
			            <select class="account-select">
			                <option>🏦 우체국 1234567890123</option>
			            </select>
			        </div>
			         <!-- 입력 안내 -->
			        <div class="input-section">
			            <input type="text" class="input-label" placeholder="금액을 입력해 주세요">
			            <div class="balance-info">굿페이 잔액: <strong>30,000 원</strong></div>
			        </div>
			
			        <!-- 금액 버튼 -->
			        <div class="amount-btns">
			            <button class="amount-btn">+ 1만원</button>
			            <button class="amount-btn">+ 5만원</button>
			            <button class="amount-btn">+ 10만원</button>
			        </div>
			        <!-- 숫자 키패드 -->
			        <div class="keypad">
			            <div class="key-row">
			                <button class="key">1</button>
			                <button class="key">2</button>
			                <button class="key">3</button>
			            </div>
			            <div class="key-row">
			                <button class="key">4</button>
			                <button class="key">5</button>
			                <button class="key">6</button>
			            </div>
			            <div class="key-row">
			                <button class="key">7</button>
			                <button class="key">8</button>
			                <button class="key">9</button>
			            </div>
			            <div class="key-row">
			                <button class="key">00</button>
			                <button class="key">0</button>
			                <button class="key delete">←</button>
			            </div>
			        </div>
						        
			        
			        
			        
			         <!-- 충전하기 버튼 -->
			        <div class="recharge-button">
			            <button class="recharge-btn">충전하기</button>
			        </div>
			    </div>
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>
</html>