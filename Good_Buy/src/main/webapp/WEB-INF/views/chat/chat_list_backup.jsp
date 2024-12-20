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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontawesome/all.min.css" />
<script src="${pageContext.request.contextPath}/resources/fontawesome/all.min.js"></script>

<!-- ******************* 아래 CSS와 JS는 페이지별로 알맞게 Import 해주세요 ****************** -->
<!-- CSS for Page -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css">

<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/product.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<div class="chat-wrapper">
					<div class="chat-list">
						<h2>전체대화</h2>
						<hr>
						<div class="chat-list-component">
							<img src="${pageContext.request.contextPath}/resources/img/testPicture.png">
							<div class="chat-list-text">
								<div class="chat-list-subject"><strong>채팅리스트</strong></div>
								<div class="chat-list-content"><strong>채팅내용 미리보기</strong></div>
							</div>
						</div>
						<div class="chat-list-component">
							<img src="${pageContext.request.contextPath}/resources/img/testPicture.png">
							<div class="chat-list-text">
								<div class="chat-list-subject"><strong>채팅리스트</strong></div>
								<div class="chat-list-content"><strong>채팅내용 미리보기</strong></div>
							</div>
						</div>
						<div class="chat-list-component">
							<img src="${pageContext.request.contextPath}/resources/img/testPicture.png">
							<div class="chat-list-text">
								<div class="chat-list-subject"><strong>채팅리스트</strong></div>
								<div class="chat-list-content"><strong>채팅내용 미리보기</strong></div>
							</div>
						</div>
					</div>
					
					<div class="chat-main">
						<h2>채팅메인</h2>
						<hr>
						<div>채팅 내역</div>
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