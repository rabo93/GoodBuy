<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
				
				<div class="account-container">
			        <!-- 페이지 제목 -->
			        <h2 class="page-title">굿페이 - 내 연결계좌 관리</h2>
			        
			        <%-- 세션 객체의 "token" 속성이 비어있을 경우 계좌 미인증 회원으로 계좌연결 버튼 표시 --%>
					<%-- 아니면, 계좌관리 기능에 대한 버튼 표시 --%>
					<c:choose>
						<c:when test="${empty sessionScope.token}">
							<div class="account-box">
					        	<div class="info">
						        	<h1>
						        		계좌 미인증 회원입니다.<br>
										계좌 인증을 먼저 수행한 후 서비스 이용이 가능합니다!<br>
						        	</h1>
<!-- 						            <button class="my-account" onclick="location.href='MyAccount'">내 계좌</button> -->
						            <button type="button" class="my-account"onclick="linkAccount()">계좌연결</button>
						            
					        	</div>
					    	</div>    	
						</c:when>
						
			        
						<c:otherwise>
					        <!-- 연결된 계좌 -->
<%-- 					        은행이름 : ${bankUserInfo.bank_name } --%>
<%-- 					        객체 : ${bankUserInfo.res_list} --%>
<%-- 					        <c:forEach var="account" items="${bankUserInfo.res_list}"> --%>
<%-- 					        	${account.bank_name} --%>
<%-- 					        	${account.account_num_masked} --%>
<%-- 					        </c:forEach> --%>
					        
					        
					        <c:forEach var="account" items="${bankUserInfo.res_list}">
						        <a href="#" title="${account.account_num_masked}계좌의 상세정보 보기"  onclick="document.getElementById('PayAccountDetail').submit();">
							        <div class="linked-account">
							            <div class="account-info">
							                <div class="icon"><i class="fa-solid fa-building-columns"></i></div>
							                <span class="account-number">${account.bank_name}<strong>${account.account_num_masked}</strong></span>
							            </div>
							            <button class="primary-account-btn">주계좌</button>
							        </div>
							    </a>
							    <form action="PayAccountDetail" method="POST" id="PayAccountDetail">
									<input type="hidden" name="fintech_use_num" value="${account.fintech_use_num}">
									<input type="hidden" name="account_holder_name" value="${account.account_holder_name}">
									<input type="hidden" name="account_num_masked" value="${account.account_num_masked}">
								</form>
					        </c:forEach>
					        <div class="add-account">
					            <button class="add-account-btn">+ 연결계좌 추가하기</button>
					        </div>
					        
					        
					        
				        </c:otherwise>
					</c:choose>
			    </div><!-- account-container 끝  -->
			    
			    
			    
			    
			    
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>
</html>