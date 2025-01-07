<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
							<h3>굿페이 > 이용내역</h3>
							
							
							
							<div class="goodpay-container">
							 	<div class="account-box">
							 		<div class="use-buttons">
						                <button class="all-btn">전체</button>
						                <button class="use-transfer-btn">송금</button>
						                <button class="use-charge-btn">충전</button>
						            </div>
						            <c:forEach var="item" items="${recieverTransactionInfo}">
				            			<div class="history-item">
				            				<div class="icon"><i class="fa-solid fa-building-columns"></i></div>
							                <div class="details">
							                    <span>산업 ${item.RECEIVER_FINTECH_USE_NUM }</span>
							                    <span class="date" >
							                    	<fmt:parseDate var="parsedReplyRegDate"
																		value="${item.API_TRAN_DTM}" 
																		pattern="yyyy-MM-dd'T'HH:mm:ss" 
																		type="both" /> 
														<fmt:formatDate value="${parsedReplyRegDate}" pattern="yy.MM.dd" /> 
													| 송금
							                    </span>
							                </div>
							                <div class="amount">+ <fmt:formatNumber pattern="#,###">${item.TRAN_AMT}</fmt:formatNumber></div>
				            			</div>	
			            			</c:forEach>	
				            		<c:forEach var="item" items="${transactionInfo}" varStatus="status">
				            			<c:if test="${item.TRANSACTION_TYPE eq 'WI'}">
				            				<c:set var="classify" value="충전"/>
				            				<c:set var="symbol" value="+"/>
				            			</c:if>
				            			<c:if test="${item.TRANSACTION_TYPE eq 'TR'}">
				            				<c:set var="classify" value="송금"/>
				            				<c:set var="symbol" value="-"/>
				            			</c:if>
				            			<c:if test="${item.TRANSACTION_TYPE eq 'DE'}">
				            				<c:set var="classify" value="환불"/>
				            				<c:set var="symbol" value="-"/>
				            			</c:if>

				            			<div class="history-item">
							                <div class="icon"><i class="fa-solid fa-building-columns"></i></div>
							                <div class="details">
							                    <span>산업 ${item.FINTECH_USE_NUM }</span>
							                    <span class="date" >
							                    	<fmt:parseDate var="parsedReplyRegDate"
																		value="${item.API_TRAN_DTM}" 
																		pattern="yyyy-MM-dd'T'HH:mm:ss" 
																		type="both" /> 
														<fmt:formatDate value="${parsedReplyRegDate}" pattern="yy.MM.dd" /> 
													| ${classify}
							                    </span>
							                </div>
							                <div class="amount">${symbol} <fmt:formatNumber pattern="#,###">${item.TRAN_AMT}</fmt:formatNumber></div>
							            </div>
				            		</c:forEach>
						            <!-- 굿페이 이용 내역 -->
<!-- 							        <div class="history"> -->
<!-- 							            <h3>2024년 12월</h3> -->
<!-- 							            <div class="history-item"> -->
<!-- 							                <div class="icon"></div> -->
<!-- 							                <div class="details"> -->
<!-- 							                    <span>쌀국수</span> -->
<!-- 							                    <span class="date">12.03 12:10 | 송금</span> -->
<!-- 							                </div> -->
<!-- 							                <div class="amount">-5,000원</div> -->
<!-- 							            </div> -->
<!-- 							            <div class="history-item"> -->
<!-- 							                <div class="icon"></div> -->
<!-- 							                <div class="details"> -->
<!-- 							                    <span>믹스커피</span> -->
<!-- 							                    <span class="date">12.03 12:10 | 송금</span> -->
<!-- 							                </div> -->
<!-- 							                <div class="amount">-15,000원</div> -->
<!-- 							            </div> -->
<!-- 							            <div class="history-item"> -->
<!-- 							                <div class="icon"></div> -->
<!-- 							                <div class="details"> -->
<!-- 							                    <span>우체국 1234</span> -->
<!-- 							                    <span class="date">12.03 12:10 | 충전</span> -->
<!-- 							                </div> -->
<!-- 							                <div class="amount">+100,000원</div> -->
<!-- 								    	</div>         -->
<!-- 							        </div>history   -->
							 	</div>
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