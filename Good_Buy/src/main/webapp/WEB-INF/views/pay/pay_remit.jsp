<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
<script src="${pageContext.request.contextPath}/resources/js/chat_main.js"></script>

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
	<main>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
	        	<div class="my-container">
					<div class="contents-ttl">
						<h3>굿페이 > 계좌송금</h3><br>
				        <div class="input-section">
				        	구매물품 : ${productSearch.product_title}<br>
							<br>
							'${param.receiver_id}' 님에게 <fmt:formatNumber pattern="#,###">${productSearch.product_price}</fmt:formatNumber>원을 송금합니다.
							<br><br>
							<div class="balance-info">굿페이 잔액: <strong>${pay_amount} 원</strong></div>
							<form action="PayTransfer" method="post">
								<input type="hidden" name="receiver_id" placeholder="상대방 아이디 입력" value="${param.receiver_id}">
								<input type="hidden" name="tran_amt" value="2000">
						        <div class="recharge-button">
						            <button class="transfer-btn-chat">송금하기</button>
						        </div> 
							</form>
				        </div>
				        <!-- 계좌내역 -->
				        <div class="accounts">
				            <h3>내 계좌</h3>
				            
							<select class="account-select"  name="withdraw_client_fintech_use_num">
								<c:forEach var="account" items="${bankUserInfo.res_list}" varStatus="status">
									<option value="${account.fintech_use_num}" <c:if test="${account.fintech_use_num eq fintech_use_num}">selected</c:if>>
							                ${account.bank_name} &nbsp;&nbsp; ${account.account_num_masked}
						           		<c:if test="${account.fintech_use_num eq fintech_use_num}">
											( 대표계좌 )
										</c:if>
									</option>
								</c:forEach>
							</select>
				            <br>
				       	</div>
					</div>
			    </div>
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
</body>
</html>