<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
							<h3>굿페이 > 굿페이 충전</h3>
                
                
               
                
							 <div class="goodpay-container">
							 	<div class="account-box">
						        	<div class="info">
									 	<h1>굿페이 계좌 충전 결과</h1>
									</div>
									<div class="account-header">
						                <div class="icon"><i class="fa-solid fa-building-columns"></i></div>
						                <div class="details">
						                    <span>산업 </span>
						                    <span class="account-num">${userAccount.ACCOUNT_NUM}</span>
						                </div>
							            <div class="amount">출금 <fmt:formatNumber pattern="#,###">${withdrawResult.TRAN_AMT}</fmt:formatNumber>원</div>
						            </div><!-- history-item -->
						            <div class="account-item">
						            	<div class="details">
						                    <span>거래구분</span>
						                </div>
							            <div class="amount">충전</div>
									</div>							        
						            <div class="account-item">
							            <div class="details">
						                    <span>거래일시</span>
						                </div>
	                    				<div class="amount">
	                    					<fmt:parseDate var="parsedReplyRegDate"
													value="${withdrawResult.API_TRAN_DTM}" 
													pattern="yyyy-MM-dd'T'HH:mm:ss" 
													type="both" /> 
											<fmt:formatDate value="${parsedReplyRegDate}" pattern="yy.MM.dd HH:mm" />
										</div>
						            </div>
						            <div class="account-item">
							            <div class="details">
						                    <span>충전계좌</span>
						                </div>
	                    				<div class="amount">${userAccount.BANK_NAME} ${userAccount.ACCOUNT_NUM}</div>
						            </div>
						            <div class="account-item">
							            <div class="details">
						                    <span>굿페이 잔액</span>
						                </div>
	                    				<div class="amount"><fmt:formatNumber pattern="#,###">${pay_amount}</fmt:formatNumber>원</div>
						            </div>
						            <div class="return-btn"><button onclick="location.href = document.referrer">돌아가기</button></div>
								</div><!-- account-box -->
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