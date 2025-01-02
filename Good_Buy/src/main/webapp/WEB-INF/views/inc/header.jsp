<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- header -->
<div id="hd_wrap" class="hd-wrap">
	<section class="hd-top">
		<div class="hd-logo">
<!-- 			<a href="/"><h1><i class="fa-solid fa-basket-shopping"></i><br>Good Buy</h1></a> -->
			<a href="/"><h1><img src="${pageContext.request.contextPath}/resources/img/new_logo.svg" alt="굿바"></h1></a>
		</div>
		<div class="hd-sch">
			<form action="" method="get">
				<input type="text" name="" class="sch-input" placeholder="어떤 상품을 찾으시나요?">
				<button type="submit" class="sch-submit">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</form>
		</div>
		<div class="hd-gnb">
			<div class="gnb-left">
				<a href="ProductRegist" class="gnb-btn"><i class="fa-solid fa-store"></i> 판매하기</a>
				<a href="ChatMain" class="gnb-btn"><i class="fa-solid fa-comment-dots"></i> 채팅하기</a>
			</div>
			<div class="gnb-right">
				<c:choose>
<%-- 					<c:when test="${not empty member.mem_profile}"> --%>
					<c:when test="${not empty sessionScope.sId}">
						<button type="button" class="gnb-btn" id="login-btn">
							<c:choose>
<%-- 								<c:when test="${not empty member.mem_profile}"> --%>
<%-- 									<img src="${member.mem_profile}" alt="프로필사진"><br> --%>
<%-- 								</c:when> --%>
								<c:when test="${not empty sessionScope.sProfile}">
									<img src="${sessionScope.sProfile}?${System.currentTimeMillis()}" alt="프로필사진" class="profile-pic">
<%-- 									<img src="${sessionScope.sProfile}" alt="프로필사진"> --%>
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/resources/img/user_thumb.png" alt="프로필사진">
								</c:otherwise>
							</c:choose>
							<b>${sessionScope.sNick}</b> 님
						</button>
						<div id="login-panel">
							<a href="MyStore">나의상점</a>
							<a href="GoodPay">굿페이</a>
							<a href="MyInfo">계정정보</a>
							<a href="MemberLogout">로그아웃</a>
							<input type="hidden" id="sId" value="${sessionScope.sId}">
							<script src="${pageContext.request.contextPath}/resources/js/chat_header.js"></script>
						</div>
						<script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
					</c:when>
					<c:otherwise>
						<a href="SNSLogin" class="gnb-btn"><i class="fa-solid fa-user"></i> 로그인</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="m-menu">
          <button class="hamburger hamburger--spin" type="button">
            <span class="hamburger-box">
            <span class="hamburger-inner"></span>
            </span>
          </button>
        </div>
		
		<div class="m-menu-wrap">
        	<div class="m-menu-bg">
        	
        	</div>
        	<nav id="m_nav">
        		<div class="m-info">
        			<c:choose>
						<c:when test="${empty sessionScope.sId}">
	        				<a href="SNSLogin" class="gnb-btn"><i class="fa-solid fa-user"></i> 로그인</a>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${not empty sessionScope.sProfile}">
									<img src="${sessionScope.sProfile}" alt="프로필사진">
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/resources/img/user_thumb.png" alt="프로필사진" clas>
								</c:otherwise>
							</c:choose>
								<a href="MyInfo" class="my-info"><span>${sessionScope.sId} </span> 님</a>
			        			<a href="ProductRegist" class="gnb-btn"><i class="fa-solid fa-store"></i> 판매하기</a>
								<a href="ChatMain" class="gnb-btn"><i class="fa-solid fa-comment-dots"></i> 채팅하기</a>
								<a href="MemberLogout">로그아웃</a>
								<input type="hidden" id="sId" value="${sessionScope.sId}">
<%-- 								<script src="${pageContext.request.contextPath}/resources/js/chat_header.js"></script> --%>
						</c:otherwise>				
					</c:choose>
        		</div>
				<ul class="mgnb">
					<li class="mgnb-menu">
						<ul class="mgnb-dep-01">
							<li><a href="ProductList?PRODUCT_CATEGORY=여성의류">여성의류</a></li>
							<li><a href="ProductList?PRODUCT_CATEGORY=남성의류">남성의류</a></li>
							<li><a href="ProductList?PRODUCT_CATEGORY=레저/스포츠">레저/스포츠</a></li>
							<li><a href="ProductList?PRODUCT_CATEGORY=생활용품">생활용품</a></li>
							<li><a href="ProductList?PRODUCT_CATEGORY=키즈">키즈</a></li>
							<li><a href="ProductList?PRODUCT_CATEGORY=도서">도서</a></li>
						</ul>
					</li>
<!-- 					<li><a href="BestCourse">BEST 🔥</a></li> -->
<!-- 					<li><a href="Recommend">AI 추천🤖</a></li> -->
				</ul>
			</nav>
        </div>
	</section>
	<section class="hd-menu">
		<nav class="hd-lnb">
			<a href="ProductList?PRODUCT_CATEGORY=여성의류">여성의류</a>
			<a href="ProductList?PRODUCT_CATEGORY=남성의류">남성의류</a>
			<a href="ProductList?PRODUCT_CATEGORY=레저/스포츠">레저/스포츠</a>
			<a href="ProductList?PRODUCT_CATEGORY=생활용품">생활용품</a>
			<a href="ProductList?PRODUCT_CATEGORY=키즈">키즈</a>
			<a href="ProductList?PRODUCT_CATEGORY=도서">도서</a>
		</nav>
	</section>
</div>
<script src="${pageContext.request.contextPath}/resources/js/top.js"></script>

