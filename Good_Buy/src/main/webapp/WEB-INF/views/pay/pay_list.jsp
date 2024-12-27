<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<!-- font-awesome -->
<link rel="stylesheet" href="../../resources/fontawesome/all.min.css" />
<script src="../../resources/fontawesome/all.min.js"></script>

<!-- ******************* 아래 CSS와 JS는 페이지별로 알맞게 Import 해주세요 ****************** -->
<!-- CSS for Page -->
<link rel="stylesheet" href="../../resources/css/product.css">
<link rel="stylesheet" href="../../resources/css/pay.css">
<!-- JS for Page -->
<script src="../../resources/js/product.js"></script>
<script src="../../resources/js/pay.js"></script>


</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
                <h2 class="page-title">굿페이 > 홈</h2>
                
				 <div class="goodpay-container">
				 
			        <!-- 상단: 계좌 정보 -->
			        <div class="account-box">
			        	<div class="info">
				        	<h1><i class="fa-solid fa-money-bill"></i>&nbsp;&nbsp;굿페이</h1>
				        	<c:if test="${not empty token}">  
				            	<button class="my-account" onclick="location.href='MyAccount'">내 계좌</button>
				            </c:if>
				            <c:if test="${empty token}">
				              	<button class="my-account" onclick="linkAccount()">계좌인증</button>
				            </c:if>
				            <c:if test=""></c:if>
			        	</div>
			            <div class="balance">
			                <h1>30,000원</h1>
			                <i class="fa-solid fa-arrow-rotate-right"></i>
			            </div>
			            <div class="buttons">
<!-- 			                <button class="charge-btn" onclick="location.href='pay_charge.jsp'">+ 충전</button> -->
			                <button class="charge-btn"  onclick="openModal()">+ 충전</button>
			                <button class="transfer-btn" onclick="location.href='pay_remit.jsp'">￦계좌송금</button>
			                
			                <div id="pay-account-modal" class="pay-account-modal">
								<div class="pay-account-modal-content">
									<span class="pay-account-modal-close" onclick="closeModal()">&times;</span>
									bankUserInfo : ${bankUserInfo} <br>
									fintech_use_num : ${fintech_use_num} <br>
									<p>충전 페이지로 이동하시겠습니까?</p>
									<form action="PayWithdraw" method="post">
										<%-- 출금 계좌가 복수개일 경우 구분을 위해 핀테크 이용번호도 출금 요청 시 전송 --%>
										<%-- 만약, 대표계좌 1개만 사용하여 입출금 구현 시 DB 에서 조회를 통해 핀테크 이용번호 조회 --%>
										<input type="hidden" name="withdraw_client_fintech_use_num" value="${accountDetail.fintech_use_num}">
										<%-- 예금주명도 핀테크 이용번호와 동일함 --%>
										<input type="hidden" name="withdraw_client_name" value="${account_holder_name}">
										<%-- 실제 거래금액은 상품 결정되면 해당 상품의 거래금액을 사용 --%>
										<%-- 현재는 임시로 거래금액 텍스트박스를 통해 입력(임의의 기본값 입력) --%>
										거래금액 <input type="text" name="tran_amt" value="5000"> 
										<input type="submit" value="충전하기">
									</form>
<!-- 									<button onclick="location.href='pay_charge.jsp'">이동</button> -->
								</div>
							</div>
			            </div>
			        </div>
			
			        <!-- 최근 이용 내역 -->
			        <div class="history">
			            <h3>최근 이용내역 <a href="pay_use_list.jsp" class="see-all">전체보기 ></a></h3>
			            <div class="history-item">
			                <div class="icon"></div>
			                <div class="details">
			                    <span>쌀국수</span>
			                    <span class="date">12.03 12:10 | 송금</span>
			                </div>
			                <div class="amount">-5,000원</div>
			            </div>
			            <div class="history-item">
			                <div class="icon"></div>
			                <div class="details">
			                    <span>믹스커피</span>
			                    <span class="date">12.03 12:10 | 송금</span>
			                </div>
			                <div class="amount">-15,000원</div>
			            </div>
			            <div class="history-item">
			                <div class="icon"></div>
			                <div class="details">
			                    <span>겨울코드</span>
			                    <span class="date">12.03 12:10 | 송금</span>
			                </div>
			                <div class="amount">-50,000원</div>
			            </div>
			            <div class="history-item">
			                <div class="icon"></div>
			                <div class="details">
			                    <span>우체국 1234</span>
			                    <span class="date">12.03 12:10 | 충전</span>
			                </div>
			                <div class="amount">+100,000원</div>
			            </div>
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