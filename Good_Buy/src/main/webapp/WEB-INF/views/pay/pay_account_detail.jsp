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





</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				
				
				
				
				
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
							<h3>굿페이 > ${account_holder_name} 고객님의 계좌 상세정보</h3>
							<br>	
				
				
				 
							<div class="linked-account">
					            <div class="account-info">
					                <div class="icon"><i class="fa-solid fa-building-columns"></i></div>
					                <span class="account-number">
					                		${accountDetail.bank_name}<strong>&nbsp;&nbsp;&nbsp;&nbsp;${account_num_masked}</strong>
					                		( ￦ <fmt:formatNumber pattern="#,###">${accountDetail.wd_limit_remain_amt}</fmt:formatNumber> 원 )	
					                </span>
					            </div>
					            <button class="primary-account-btn">대표계좌</button>
					        </div>
							
							
							
				
							<div align="center">
								<input type="button" value="돌아가기" onclick="history.back()">
								<hr>
								<%-- 2.6. 계좌이체 서비스 - 2.6.2. 입금이체 API 서비스 요청 폼 --%>
								<%-- 거래 요청 고객(입금계좌 예금주) 정보(핀테크이용번호, 예금주명, 입금금액) 전달 --%>
								<form action="PayDeposit" method="post">
									<input type="hidden" name="deposit_client_fintech_use_num" value="${accountDetail.fintech_use_num}">
									<input type="hidden" name="deposit_client_name" value="${account_holder_name}">
									<%-- 실제 거래금액은 상품 결정되면 해당 상품의 거래금액을 사용 --%>
									<%-- 현재는 임시로 거래금액 텍스트박스를 통해 입력(임의의 기본값 입력) --%>
									거래금액 <input type="text" name="tran_amt" value="33000"> 
									<input type="submit" value="환불하기">
								</form>
								
								<hr><hr>
								<%-- 
									P2P 송금(이체) 요청(출금이체 + 입금이체)사람이 한명 더 필요하므로 가입을 더 해야함. 
								--%>
								<%-- 거래 요청 고객(입금계좌 예금주) 정보(핀테크이용번호, 예금주명, 입금금액) 전달 --%>
								<form action="PayTransfer" method="post">
									<input type="text" name="receiver_id" placeholder="상대방 아이디 입력">
									거래금액 <input type="text" name="tran_amt" value="2000"> 
									<input type="submit" value="송금">
								</form>
								
								
							</div>
						</div>
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
</html>
