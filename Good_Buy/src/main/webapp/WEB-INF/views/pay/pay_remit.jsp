<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>굿바이 - 중고거래, 이웃과 함께 더 쉽게!</title>

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/g_favicon.ico" type="image/x-icon">
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/g_favicon.ico" type="image/x-icon">

<!-- default -->
<link rel="stylesheet" href="../../resources/css/common.css">
<link rel="stylesheet" href="../../resources/css/default.css">
<script src="../../resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet" href="../../resources/fontawesome/all.min.css" />
<script src="../../resources/fontawesome/all.min.js"></script>

<!-- ******************* 아래 CSS와 JS는 페이지별로 알맞게 Import 해주세요 ****************** -->
<!-- CSS for Page -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pay.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">

<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/product.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/pay.js"></script>



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
<!-- 				<div class="goodpay-container"> -->
			        
		        <h2 class="page-ttl">마이페이지</h2>
				<section class="my-wrap">
					<aside class="my-menu">
						<h3>거래 정보</h3>
						<a href="MyStore">나의 상점</a>
						<a href="GoodPay" class="active">굿페이</a>
						<a href="MyOrder">구매내역</a>
						<a href="MySales">판매내역</a>
						<h3>나의 정보</h3>
						<a href="MyInfo">계정정보</a>
						<a href="MyWish">관심목록</a>
						<a href="MyReview">나의 후기</a>
						<a href="MySupport">1:1문의내역</a>
						<a href="">나의 광고</a>
					</aside>
		        
		        
		        
		        	<div class="my-container">
						<div class="contents-ttl">
							<h3>굿페이 > 계좌송금</h3>
		        			<h1>계좌송금은 채팅창에서 상대방 아이디 눌러서 계좌송금하는 방식이다. 바로 보내는 방식이 아님. </h1>
		        
		        
		        
					
					        <!-- 입력 안내 -->
					        <div class="input-section">
					            <input type="text" class="input-label" placeholder="계좌번호를 입력하세요">
					            <input type="text" class="input-label" placeholder="은행을 선택하세요">
					        </div>
					
					         <!-- 충전하기 버튼 -->
					        <div class="recharge-button">
					            <button class="recharge-btn">다음</button>
					        </div>
					        
					         <!-- 계좌내역 -->
					        <div class="accounts">
					            <h3>내 계좌</h3>
					            <!-- 연결된 계좌 -->
						        <div class="linked-account">
						            <div class="account-info">
						                <div class="icon"></div>
						                <span class="account-number">우체국 <strong>1234567890123</strong></span>
						            </div>
						            <button class="primary-account-btn">주계좌</button>
						        </div>
					       </div>
					        <!-- 추천계좌 버튼 -->
					        <div class="recommend-button">
					            <button class="recommend-btn">우리은행 1234567890123 (으)로 송금
					            	<span><i class="fa-solid fa-x"></i></span>
					            </button>
					        </div>
		    			</div>
		    		</div>
		    	</section>
			    
			    
<!-- 			    </div> -->
			    
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>
</html>