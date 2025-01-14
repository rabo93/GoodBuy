<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
							<h3>굿페이 > 내 연결계좌 관리</h3>
		        
		        
							<div class="account-container">
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
														<input type="hidden" name="bank_code_std" value="${account.bank_code_std}">
														<input type="hidden" name="bank_name" value="${account.bank_name}">
														<input type="submit" value="대표계좌로설정" class="PayRegistRepresentAccount">
													</form>    
										        </c:otherwise>
										    </c:choose>
								        </div>
								    </a>
						        </c:forEach>
						        <div class="add-account">
						            <button class="add-account-btn" onclick="linkAccount()">+ 연결계좌 추가하기</button>
						        </div>
						    </div><!-- account-container 끝  -->
						        <div class="return-btn"><button onclick="location.href = document.referrer">돌아가기</button></div>
						</div>
					</div>
				</section><!-- my-wrap -->
			    
			    
			    
			    
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
	<script>
		if(!'${fintech_use_num}') alert('대표계좌 버튼을 눌러 대표계좌를 설정하세요.');
	</script>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>
</html>