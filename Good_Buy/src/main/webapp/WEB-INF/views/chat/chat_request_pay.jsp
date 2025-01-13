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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontawesome/all.min.css" />
<script src="${pageContext.request.contextPath}/resources/fontawesome/all.min.js"></script>

<!-- ******************* 아래 CSS와 JS는 페이지별로 알맞게 Import 해주세요 ****************** -->
<!-- CSS for Page -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat_request.css">

<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>
</head>
<body>
	<main>
		<section class="wrapper">
			<!-- *********** 여기 안에 작업하세요. section.wrapper 건들지말기 ******** -->
		<div class="container">
			<div class="keypad-container">
				<div class="price-display" id="priceDisplay">${product_price}</div>
	        	<input type="text" id="inputField" class="input-field"> <!-- 숫자가 입력될 필드 -->
	        	<div class="keypad">
		            <button class="key" data-value="1">1</button>
		            <button class="key" data-value="2">2</button>
		            <button class="key" data-value="3">3</button>
		            <button class="key" data-value="4">4</button>
		            <button class="key" data-value="5">5</button>
		            <button class="key" data-value="6">6</button>
		            <button class="key" data-value="7">7</button>
		            <button class="key" data-value="8">8</button>
		            <button class="key" data-value="9">9</button>
		            <button class="key" data-value="clear">C</button>
		            <button class="key" data-value="0">0</button>
		            <button class="key" data-value="enter">입력</button>
		        </div>
		       	<button id="requsetBtn">송금요청</button>
		       	<input type="hidden" id="room_id" value="${room_id}">
		       	<input type="hidden" id="receiver_id" value="${receiver_id}">
		       	<input type="hidden" id="product_id" value="${product_id}">
	    	</div>
    	</div>
			<!-- *********** // 여기 안에 작업하세요. section.wrapper 건들지말기 ******** -->
		</section>
	</main>
</body>
<script src="${pageContext.request.contextPath}/resources/js/chat_main.js"></script>
</html>