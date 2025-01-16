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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
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
						</div>
						<div class="contents">
							<div class="goodpay-container">
							 	<div class="account-box">
							 		<div class="use-buttons">
						                <button class="all-btn selected" onclick="listToggleButton('all')">전체</button>
						                <button class="use-transfer-btn" onclick="listToggleButton('transfer')">송금</button>
						                <button class="use-charge-btn" onclick="listToggleButton('charge')">충전</button>
						                <button class="use-refund-btn" onclick="listToggleButton('refund')">환불</button>
						            </div>
						            

						            
						            <c:choose>
						            	<c:when test="${empty getPayInfo}">
							            	<div class="history-item empty-text">
							            	굿페이 이용내역이 없습니다.
							            	</div>
						            	</c:when>
						            	<c:otherwise>
						            		<c:forEach var="item" items="${getPayInfo}" varStatus="status">
						            			<c:set var="dataType" value="all"/>
						            			<c:if test="${item.TRANSACTION_TYPE eq 'WI'}">
						            				<c:set var="dataType" value="charge"/>
						            				<c:set var="detail" value="${item.BANK_NAME} ${item.ACCOUNT_NUM} "/>
						            				<c:set var="classify" value="충전"/>
						            				<c:set var="symbol" value="+"/>
						            			</c:if>
						            			<c:if test="${item.TRANSACTION_TYPE eq 'DE'}">
						            				<c:set var="dataType" value="refund"/>
						            				<c:set var="detail" value="${item.BANK_NAME} ${item.ACCOUNT_NUM} "/>
						            				<c:set var="classify" value="환불"/>
						            				<c:set var="symbol" value="-"/>
						            			</c:if>
						            			<c:if test="${item.TRANSACTION_TYPE eq 'TR'}">
						            				<c:set var="dataType" value="transfer"/>
						            				<c:set var="detail" value="${item.productName }"/>
						            				<c:set var="classify" value="송금"/>
						            				<c:if test="${item.RECEIVER_ID != sId }">
						            					<c:set var="symbol" value="-"/>
						            				</c:if>
						            				<c:if test="${item.RECEIVER_ID eq sId}">
						            					<c:set var="symbol" value="+"/>
						            				</c:if>
						            			</c:if>
									            <div class="use-history-item active" data-type="${dataType}">
													<div class="icon"><i class="fa-solid fa-building-columns"></i></div> 
									                <div class="details">
									                    <span class="his-ttl">${detail }</span>
									                    <span class="date" >
									                    	<fmt:parseDate var="parsedReplyRegDate"
																				value="${item.API_TRAN_DTM}" 
																				pattern="yyyy-MM-dd'T'HH:mm" 
																				type="both" /> 
																<fmt:formatDate value="${parsedReplyRegDate}" pattern="yy.MM.dd" /> 
															| ${classify}
									                    </span>
									                </div>
							                		<div class="amount">${symbol} <fmt:formatNumber pattern="#,###">${item.TRAN_AMT}</fmt:formatNumber></div>
							           			 </div>
						            		</c:forEach>
						            	</c:otherwise>
						            </c:choose>
						            <c:set var="pageNum" value="1" />
				            		<c:if test="${not empty param.pageNum}">
										<c:set var="pageNum" value="${param.pageNum}" />
									</c:if>
						            <section id="pageList">
						            	<input type="button" value="&lt;&lt;" 
											onclick="location.href='AllPayList?pageNum=${pageInfo.startPage - pageInfo.pageListLimit}'"
											<c:if test="${pageInfo.startPage eq 1}">disabled</c:if>
										>
										<%-- [이전] 버튼 클릭 시 이전 페이지 글목록 요청(파라미터로 현재 페이지번호 - 1 전달) --%>
										<%-- 현재 페이지가 1 페이지일 경우 비활성화(disabled) --%>
										<input type="button" value="이전" 
											onclick="location.href='AllPayList?pageNum=${pageNum - 1}'"
											<c:if test="${pageNum eq 1}">disabled</c:if>
										>
										
										<%-- 계산된 페이지 번호가 저장된 PageInfo 객체(pageInfo)를 통해 페이지번호 출력 --%>
										<%-- startPage 부터 endPage 까지 1씩 증가하면서 페이지번호 표시 --%>
										<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
											<%-- 각 페이지마다 하이퍼링크 설정(BoardList) => 페이지번호를 파라미터로 전달 --%>
											<%-- 단, 현재 페이지(i값과 pageNum 파라미터값이 동일)는 하이퍼링크 없이 굵게 표시 --%>
											<c:choose>
												<c:when test="${i eq pageNum}">
													<strong>${i}</strong>
												</c:when>
												<c:otherwise>
													<%-- 페이지번호 클릭 시 해당 페이지 번호를 파라미터로 전달 --%>
													<a href="AllPayList?pageNum=${i}">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										
										<%-- [다음] 버튼 클릭 시 다음 페이지 글목록 요청(파라미터로 현재 페이지번호 + 1 전달)--%>
										<%-- 현재 페이지가 전체 페이지 수와 동일할 경우 비활성화(disabled) --%>
										<input type="button" value="다음" 
											onclick="location.href='AllPayList?pageNum=${pageNum + 1}'"
											<c:if test="${pageNum eq pageInfo.maxPage}">disabled</c:if>
										>
										<%-- 현재 목록의 시작페이지번호에서 페이지 번호 갯수를 더한 페이지 요청 --%>
										<%-- 끝 페이지가 전체 페이지 수와 동일할 경우 비활성화(disabled) --%>
										<input type="button" value="&gt;&gt;" 
											onclick="location.href='AllPayList?pageNum=${pageInfo.startPage + pageInfo.pageListLimit}'"
											<c:if test="${pageInfo.endPage eq pageInfo.maxPage}">disabled</c:if>
										>
						            </section>
						            
<!-- 				            		<div class="return-btn"><button onclick="location.href = document.referrer">돌아가기</button></div>		 -->
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