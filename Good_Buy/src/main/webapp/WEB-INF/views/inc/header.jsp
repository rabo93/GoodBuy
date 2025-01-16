<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- header -->
<div id="hd_wrap" class="hd-wrap">
	<section class="hd-top">
		<div class="hd-logo">
<!-- 			<a href="/"><h1><i class="fa-solid fa-basket-shopping"></i><br>Good Buy</h1></a> -->
			<a href="/"><h1><img src="${pageContext.request.contextPath}/resources/img/new_logo.svg" alt="굿바이"></h1></a>
		</div>
		<div class="hd-sch">
			<form action="ProductList" method="get">
				<input type="text" name="SEARCHKEYWORD" class="sch-input" placeholder="어떤 상품을 찾으시나요?">
				<button type="submit" class="sch-submit">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</form>
		</div>
		<div class="hd-gnb">
			<div class="gnb-left">
				<a href="ProductRegist" class="gnb-btn"><i class="fa-solid fa-shop"></i> 판매하기</a>
				<a href="javascript:void(0)" id="chat-btn" class="gnb-btn" onclick="startChat()">
					<i class="fa-regular fa-comment-dots"></i> 채팅하기
					<script type="text/javascript">
						function startChat() {
							alert("로그인이 필요합니다!");
							location.href = "MemberLogin";
						}
					</script>
				</a>
			</div>
			<div class="gnb-right">
				<c:choose>
<%-- 					<c:when test="${not empty member.mem_id}"> --%>
					<c:when test="${not empty sessionScope.sId}">
						<button type="button" class="gnb-btn" id="login-btn">
							<c:choose>
<%-- 								<c:when test="${not empty member.mem_profile}"> --%>
<%-- 									<img src="${member.mem_profile}" alt="프로필사진"><br> --%>
<%-- 								</c:when> --%>
								<c:when test="${not empty sessionScope.sProfile}">
<%-- 									<img src="${sessionScope.sProfile}?${System.currentTimeMillis()}" alt="프로필사진" class="profile-pic"> --%>
									<img src="${sessionScope.sProfile}" alt="프로필사진">
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/resources/img/user_thumb.png" alt="프로필사진">
								</c:otherwise>
							</c:choose>
<%-- 							<b>${member.mem_nick}</b> 님 --%>
							<b>${sessionScope.sNick}</b> 님
						</button>
						<div id="login-panel">
							<a href="MyStore"><i class="fa-brands fa-pagelines"></i>&nbsp;&nbsp;&nbsp;나의상점</a>
							<a href="GoodPay"><i class="fa-brands fa-paypal"></i>&nbsp;&nbsp;&nbsp;굿페이</a>
							<a href="MyInfo"><i class="fa-regular fa-user"></i>&nbsp;&nbsp;&nbsp;계정정보</a>
							<c:if test="${sessionScope.sId eq 'admin'}">
								<a href="AdmMain"><i class="fa-solid fa-gear"></i>&nbsp;&nbsp;&nbsp;관리자화면</a>
							</c:if>
							<a href="MemberLogout"><i class="fa-solid fa-arrow-right-from-bracket"></i>&nbsp;&nbsp;&nbsp;로그아웃</a>
<%-- 							<input type="hidden" id="sNick" value="${member.mem_nick}"> --%>
							<input type="hidden" id="sNick" value="${sessionScope.sNick}">
							<script src="${pageContext.request.contextPath}/resources/js/chat_header.js"></script>
						</div>
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
	        				<a href="SNSLogin" class="gnb-btn">  <i class="fa-solid fa-user-large"></i>&nbsp;&nbsp;&nbsp;로그인을 해주세요.</a>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${not empty sessionScope.sProfile}">
									<img src="${sessionScope.sProfile}">
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/resources/img/user_thumb.png">
								</c:otherwise>
							</c:choose>
								<a href="MyInfo" class="my-info"><span>${sessionScope.sId} </span> 님</a>
								<div class="m-info-row">
				        			<a href="ProductRegist" class="gnb-btn"><i class="fa-solid fa-shop"></i>&nbsp;&nbsp;&nbsp;판매</a>
									<a href="javascript:void(0)" class="gnb-btn" onclick="startChat()">
										<i class="fa-regular fa-comment-dots"></i>&nbsp;&nbsp;&nbsp;채팅
									</a>
									<a href="MemberLogout"><i class="fa-solid fa-arrow-right-from-bracket"></i>&nbsp;&nbsp;&nbsp;로그아웃</a>
								</div>
								<input type="hidden" id="sId" value="${sessionScope.sId}">
								<input type="hidden" id="sNick" value="${sessionScope.sNick}">
						</c:otherwise>				
					</c:choose>
        		</div>
				<ul class="mgnb">
					<li class="mgnb-menu">
						<ul class="mgnb-dep-01">
							<li><a href="ProductList?CODE_ID=category_01">여성의류</a></li>
							<li><a href="ProductList?CODE_ID=category_02">남성의류</a></li>
							<li><a href="ProductList?CODE_ID=category_03">레저/스포츠</a></li>
							<li><a href="ProductList?CODE_ID=category_04">생활용품</a></li>
							<li><a href="ProductList?CODE_ID=category_05">키즈</a></li>
							<li><a href="ProductList?CODE_ID=category_06">도서</a></li>
						</ul>
					</li>
<!-- 					<li><a href="BestCourse">BEST 🔥</a></li> -->
<!-- 					<li><a href="Recommend">AI 추천🤖</a></li> -->
				</ul>
			</nav>
        </div>
	</section>
	<section class="hd-menu">
		<nav class="hd-lnb" id="hd-lnb">
<!-- 			<a href="ProductList?CODE_ID=category_01">여성의류</a> -->
<!-- 			<a href="ProductList?CODE_ID=category_02">남성의류</a> -->
<!-- 			<a href="ProductList?CODE_ID=category_03">레저/스포츠</a> -->
<!-- 			<a href="ProductList?CODE_ID=category_04">생활용품</a> -->
<!-- 			<a href="ProductList?CODE_ID=category_05">키즈</a> -->
<!-- 			<a href="ProductList?CODE_ID=category_06">도서</a> -->
		</nav>
	</section>
</div>
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/top.js"></script>

