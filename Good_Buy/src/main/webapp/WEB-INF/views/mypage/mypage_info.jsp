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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontawesome/all.min.css" />
<script src="${pageContext.request.contextPath}/resources/fontawesome/all.min.js"></script>

<!-- ******************* 아래 CSS와 JS는 페이지별로 알맞게 Import 해주세요 ****************** -->
<!-- CSS for Page -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">

<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<!-- 계정설정 -->
		<h2 class="page-ttl">마이페이지</h2>
		<section class="my-wrap">
			<aside class="my-menu">
				<h3>거래 정보</h3>
				<a href="MyStore">나의 상점</a>
				<a href="GoodPay">굿페이</a>
				<a href="MyOrder">구매내역</a>
				<a href="MySales">판매내역</a>
				<h3>나의 정보</h3>
				<a href="MyInfo" class="active">계정정보</a>
				<a href="MyWish">관심목록</a>
				<a href="MyReview">나의 후기</a>
				<a href="MySupport">1:1문의내역</a>
				<a href="">나의 광고</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">계정설정</div>
				<div class="contents">
					<!-- contents -->
						<section class="info-set-wrap">
						<form action="MyInfo" name="myImfo" method="post" enctype="multipart/form-data" class="my-frm">
							<div class="set">
								<label>프로필 사진</label>
								<div>
									<img src="${pageContext.request.contextPath}/resources/img/user_thumb.png" id="preview_profile" height="60px"><br>
									<input type="file" name="mem_profil" id="mem_profile" value="변경"><br>
								</div>
							</div>
							
							<div class="set">
								<label>닉네임</label>
								<div>
									<input type="text" name="mem_name" id="mem_name" onblur=""><br>
								</div>
							</div>
							
							<div class="set">
								<label>비밀번호</label>
								<div>	
									<input type="password" name="mem_passwd" id="mem_passwd"><br>
								</div>
							</div>
							
							<div class="set">
								<label>비밀번호 확인</label>
								<div>
									<input type="password" name="mem_passwd2" id="mem_passwd2"><br>
								</div>
							</div>
							
							<div class="set">
								<label>비밀번호 변경 확인</label>
								<div>
									<input type="password" name="mem_passwd3" id="mem_passwd3"><br>
								</div>
							</div>
							
							<div class="set">
								<label>이메일</label>
								<div>
									<input type="text" name="mem_email" id="mem_email"><br>
								</div>
							</div>
							
							<div class="set">
								<label>전화번호</label>
								<div>
									<input type="text" name="mem_phone" id="mem_phone"><br>
								</div>
							</div>
							
							<div class="set">
								<label>주소</label>
								<div>
									<input type="text" name="mem_address1" id="mem_address1">
									<input type="text" name="mem_post_code" id="mem_post_code" size="7">
									<input type="button" value="주소 찾기"><br>
									<input type="text" name="mem_address2" id="mem_address2"><br>
								</div>
							</div>
							
							<div class="btns">
								<input type="submit" value="수정완료">
								<input type="button" value="취소">
							</div>						
						</form>
						<a href="MemberWithdraw" class="withdraw-link">회원탈퇴</a>
					</section>
					<!-- // contents -->
				</div>
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
	






</body>
</html>