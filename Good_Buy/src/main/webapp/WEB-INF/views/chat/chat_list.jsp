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
<!-- 	<header> -->
<%-- 		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include> --%>
<!-- 	</header> -->
	<main>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<div class="container">
			        <div class="sidebar"> 
<!-- 				            <div class="sidebar-item" onclick="testOpenChat(1)"> -->
<%-- 				                <a><img src="${pageContext.request.contextPath}/resources/img/testPicture.png" alt="item"></a> --%>
<!-- 				                <div class="item-container"> -->
<!-- 					                <div class="item"><strong>아기 유아 어그부츠 150cm</strong></div> -->
<!-- 					                <div class="item-chat">상품 구매하고 싶어요 <span>&nbsp; · &nbsp; 2024.12.30 12:40</span></div> -->
<!-- 				                </div> -->
<!-- 				            </div> -->
<!-- 				            <div class="sidebar-item"> -->
<%-- 				                <img src="${pageContext.request.contextPath}/resources/img/testPicture.png" alt="item"> --%>
<!-- 				                컨버스 소형 더플백 -->
<!-- 				            </div> -->
<!-- 				            <div class="sidebar-item"> -->
<%-- 				                <img src="${pageContext.request.contextPath}/resources/img/testPicture.png" alt="item"> --%>
<!-- 				                파워레인저 정글포스 -->
<!-- 				            </div> -->
<!-- 				            <div class="sidebar-item"> -->
<%-- 				                <img src="${pageContext.request.contextPath}/resources/img/testPicture.png" alt="item"> --%>
<!-- 				                백팩 인형 백팩 -->
<!-- 				            </div> -->
			        </div>
		        
		        
			        <div class="chat-area">
<!-- 			            <div class="chat-header"> -->
<%-- 			            	<a><img src="${pageContext.request.contextPath}/resources/img/testPicture.png" alt="item"></a> --%>
<!-- 			                <div class="title">아기 유아 어그부츠 150cm</div> -->
<!-- 			                <button class="item-button" onclick="location.href='PayTransferRequest'">구매하기</button> -->
<!-- 			            </div> -->
<!-- 			            <div class="chat-body"> -->
<!-- 			                <div class="message user"> -->
<!-- 			                    <div class="bubble">안녕하세요.</div> -->
<!-- 			                </div> -->
<!-- 			                <div class="message other"> -->
<!-- 			                    <div class="bubble">안녕하세요.</div> -->
<!-- 			                </div> -->
<!-- 			                <div class="message user"> -->
<!-- 			                    <div class="bubble">상품 구매하고 싶어요</div> -->
<!-- 			                </div> -->
<!-- 			            </div> -->
<!-- 			            <div class="chat-footer"> -->
<!-- 			                <input type="text" class="chatMessage" placeholder="메시지를 입력하세요..."> -->
<!-- 			                <button class="btnSend">전송</button> -->
<!-- 			            </div> -->
			        </div>
		    	</div>
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
<!-- 	<footer> -->
<%-- 		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include> --%>
<!-- 	</footer> -->
<%-- 	<script src="${pageContext.request.contextPath}/resources/js/chat_header.js"></script> --%>
	<script src="${pageContext.request.contextPath}/resources/js/chat_main.js"></script>
</body>
</html>