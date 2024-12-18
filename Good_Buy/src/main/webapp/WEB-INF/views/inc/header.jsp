<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- header -->
<div id="hd_wrap" class="hd-wrap">
	<section class="hd-top">
		<div class="hd-logo">
			<a href="#"><h1><img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="GoodBuy"></h1></a>
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
				<a href="#" class="gnb-btn"><i class="fa-solid fa-store"></i> 판매하기</a>
				<a href="#" class="gnb-btn"><i class="fa-solid fa-comment-dots"></i> 채팅하기</a>
			</div>
			<div class="gnb-right">
				<!-- 로그인 전 -->
				<a href="#" class="gnb-btn"><i class="fa-solid fa-user"></i> 로그인</a>
				<!-- 로그인하면 -->
				<a href="#" class="gnb-btn login" style="display:none;">
					<!-- 프로필사진 있으면 그거 띄우고 없으면 기본프로필사진 대체 -->
					<img src="../resources/img/user_thumb.png" alt="기본 프로필사진">
					<b>홍길동</b> 님
				</a>
				<div class="panel" style="display:none;">
					<a href="#">내 상점</a>
					<a href="#">거래내역</a>
					<a href="#">배송관리</a>
					<a href="#">로그아웃</a>
				</div>
			</div>
		</div>
	</section>
	<section class="hd-menu">
		<nav class="hd-lnb">
			<a href="#">여성의류</a>
			<a href="#">남성의류</a>
			<a href="#">레저/스포츠</a>
			<a href="#">생활용품</a>
			<a href="#">키즈</a>
			<a href="#">도서</a>
		</nav>
	</section>
</div>