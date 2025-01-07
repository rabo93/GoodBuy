<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
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
							<h3>굿페이 메인</h3>
							<div class="goodpay-container">
						        <!-- 상단: 계좌 정보 -->
						        <div class="account-box">
						        	<div class="info">
							        	<h1><i class="fa-solid fa-money-bill"></i>&nbsp;&nbsp;굿페이</h1>
						            	<button class="my-account" onclick="location.href='MyAccount'">내 계좌</button>
						        	</div>
						            <div class="balance">
						                <h1><fmt:formatNumber pattern="#,###">${pay_amount}</fmt:formatNumber> 원</h1>
						                <i class="fa-solid fa-arrow-rotate-right"></i>
						            </div>
						            <div class="buttons">
						                <button class="charge-btn"  onclick="openModal('charge')">+ 충전 </button>
						                <button class="refund-btn"  onclick="openModal('refund')">- 환불 </button>
<!-- 						                <button class="transfer-btn" onclick="location.href='PayTransfer'">￦계좌송금</button> -->
						                <%-- 환불버튼 모달창 시작 --%>
						                <div id="pay-refund-modal" class="pay-account-modal">
											<div class="pay-account-modal-content">
												<div class="pay-account-modal-header">
													<span class="pay-account-modal-close " onclick="closeModal('refund')">&times;</span>
													<h2>굿페이 환불</h2>
												</div>
												<div class="pay-account-modal-body">
													어느계좌로 환불하시겠습니까?
													<c:forEach var="account" items="${bankUserInfo.res_list}" varStatus="status">
														<form action="PayAccountDetail" method="POST" id="PayAccountDetail-${account.fintech_use_num}">
														        <input type="hidden" name="fintech_use_num" value="${account.fintech_use_num}">
														        <input type="hidden" name="account_holder_name" value="${account.account_holder_name}">
														        <input type="hidden" name="account_num_masked" value="${account.account_num_masked}">
														</form>
														<a href="#" 
															       title="${account.account_num_masked}계좌의 상세정보 보기" 
															       data-form-id="PayAccountDetail-${account.fintech_use_num}" 
															       onclick="submitForm(this);">
													        <div class="linked-account">
													            <div class="account-info">
													                <div class="icon"><i class="fa-solid fa-building-columns"></i></div>
													                <span class="account-number">${account.bank_name}<strong>${account.account_num_masked}</strong></span>
													            </div>
													            <c:choose>
								  										<c:when test="${account.fintech_use_num eq fintech_use_num}">
														            	<button class="primary-account-btn">대표계좌</button>
															        </c:when>
															        <c:otherwise>
															    		<form action="PayRegistRepresentAccount" method="POST" id="PayRegistRepresentAccount">
																			<input type="hidden" name="fintech_use_num" value="${account.fintech_use_num}">
																			<input type="hidden" name="account_holder_name" value="${account.account_holder_name}">
																			<input type="hidden" name="account_num_masked" value="${account.account_num_masked}">
																		</form>    
															        </c:otherwise>
															    </c:choose>
													        </div>
													    </a>
											        </c:forEach>
													
												</div>
											</div>
										</div>
										<%-- 환불버튼 모달창 끝 --%>
						                
						                <%-- 충전버튼 모달창 시작 --%>
						                <div id="pay-account-modal" class="pay-account-modal">
											<div class="pay-account-modal-content">
												<div class="pay-account-modal-header">
													<span class="pay-account-modal-close " onclick="closeModal('charge')">&times;</span>
													<h2>굿페이 충전</h2>
												</div>
												<div class="pay-account-modal-body">
													<form action="PayWithdraw" method="post">
														<select class="account-select"  name="withdraw_client_fintech_use_num">
															<c:forEach var="account" items="${bankUserInfo.res_list}" varStatus="status">
																<option value="${account.fintech_use_num}" <c:if test="${account.fintech_use_num eq fintech_use_num}">selected</c:if>>
														                ${account.bank_name} &nbsp;&nbsp; ${account.account_num_masked}
													           		<c:if test="${account.fintech_use_num eq fintech_use_num}">
																		( 대표계좌 )
																	</c:if>
																	<c:set var="withdraw_client_name" value="${account.account_holder_name}" />
																</option>
															</c:forEach>
														</select>
													
														<input type="hidden" name="withdraw_client_name" value="${withdraw_client_name}">
														<input type="hidden" name="tran_amt" value="5000">	
													
														<div class="input-section">
<!-- 															거래금액 <input type="text" name="tran_amt" value="5000">  -->
											            	<input type="text" class="input-label" placeholder="금액을 입력해 주세요" id="total-amount">
										        		</div>
											            <div class="balance-info">굿페이 잔액: <strong>${pay_amount} 원</strong></div>
											            <div class="amount-btns">
												            <input type="button" class="amount-btn" onclick="addAmount(10000)" value="+ 1만원">
												            <input type="button" class="amount-btn" onclick="addAmount(50000)" value="+ 5만원">
												            <input type="button" class="amount-btn" onclick="addAmount(100000)" value="+ 10만원">
												        </div>
												        <div class="recharge-button">
												            <button class="recharge-btn">충전하기</button>
												        </div>
													</form>
												</div><!-- pay-account-modal-body -->
											</div><!-- pay-account-modal-CONTENT -->
						            	</div><%-- 충전버튼 모달창 끝 --%>
						       		 </div><!-- buttons -->
						
						        <!-- 최근 이용 내역 -->
							        <div class="history">
<<<<<<< HEAD
							        
							            <h3>최근 이용내역 <a href="pay_use_list.jsp" class="see-all">전체보기 ></a></h3>
							            ${empty recieverTransactionInfo }
							            ${empty transactionInfo }
=======
							            <h3>최근 이용내역 <a href="AllPayList" class="see-all">전체보기 ></a></h3>
>>>>>>> branch 'main' of https://github.com/jhk727/good_buy.git
							            <c:choose>
							            	<c:when test="${empty transactionInfo and empty recieverTransactionInfo}">
								            	<div class="history-item empty-text">
								            	굿페이 이용내역이 없습니다.
								            	</div>
							            	</c:when>
							            	
							            	
							            	
							            	
							            	
							            	
							            	
							            	
							            	
							            	
							            	
							            	
							            	
							            	
							            	
							            	<c:otherwise>
							            	
							            	
							            	
							            	
							            	
							            	
							            	
							            	
							            	여기가안됨!!!!!!!!!
								            		<c:forEach var="item" items="${recieverTransactionInfo}">
									            		<c:if test="${recieverTransactionInfo}">
										            			${item }
									            		</c:if>
							            			</c:forEach>	
							            			
							            			
							            			
							            			
							            			
							            			
							            			
							            			
							            			
							            			
							            			
							            			
							            			
							            			
							            			
							            			
							            			
							            			
							            			
							            		<c:forEach var="item" items="${transactionInfo}">
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
<%-- 							            			receiver_fintech_use_num : ${receiver_fintech_use_num eq fintech_use_num } --%>
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
								            </c:otherwise>
							            </c:choose>
							        </div><!-- history -->
						    	</div><!-- account-box -->
							</div><!-- goodpay-container -->	
						</div>
					</div>
				</section><!-- my-wrap -->	
				
				
				
			
			<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>

</html>