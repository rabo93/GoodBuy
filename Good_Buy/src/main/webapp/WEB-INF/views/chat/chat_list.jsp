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
				<section class="ch-report-modal">
					<div class="ch-modal-bg" onclick="toggleChatModal('close')"></div>
					<div class="ch-modal-wrap">
						<div class="ch-modal-content">
							<select class="ch-modal-sb" name="ch-modal-sb">
								<option value="다른 회원에게 욕설, 비방, 또는 부적절한 언어를 사용한 경우.">욕설 및 비방</option>
								<option value="거래 중 금전적 피해를 입히거나 사기 행위를 시도한 경우.">사기 의심</option>
								<option value="반복적으로 광고성 메시지를 보내거나 스팸 활동을 한 경우.">스팸 또는 홍보</option>
								<option value="회원 프로필 사진 또는 정보에 음란물, 폭력적인 이미지 등이 포함된 경우.">부적절한 프로필</option>
								<option value="다른 회원의 개인정보를 동의 없이 공개하거나 유포한 경우.">타인의 개인정보 노출</option>
								<option value="기타 사유를 입력해주세요.">기타</option>
							</select>
							<textarea class="ch-modal-otherReason" readonly ></textarea>
							<button class="ch-model-report-btn" type="button" id="chatReporting">
								신고하기
							</button>
						</div>
						<button class="ch-model-close-btn" type="button" onclick="toggleChatModal('close')">
							닫기
						</button>
					</div>
				</section>
				<div class="container chat-list">
				<%-- 채팅방 리스트 영역 --%>
			        <div class="sidebar"> 
			        	<c:forEach items="${chatRoomList}" var="chatRoom" varStatus="status">
				            <div class="sidebar-item ${chatRoom.room_id}" data-index="${status.index}">
				                <a><img src="${pageContext.request.contextPath}/upload/${product[status.index].product_pic1}" alt="item"></a>
				                <div class="item-container">
				                	<input type="hidden" id="room_id${status.index}" value="${chatRoom.room_id}">
				                	<input type="hidden" id="title${status.index}" value="${chatRoom.title}">
				                	<input type="hidden" id="receiver_id${status.index}" value="${chatRoom.receiver_id}">
				                	<input type="hidden" id="product_id${status.index}" value="${chatRoom.product_id}">
				                	<input type="hidden" id="grade${status.index}" value="${chatRoom.grade}">
				                	<input type="hidden" id="mem_nick${status.index}" value="${member[status.index].mem_nick}">
				                	<input type="hidden" id="mem_profile${status.index}" value="${member[status.index].mem_profile}">
				                	<input type="hidden" id="product_img${status.index}" value="${product[status.index].product_pic1}">
					                <div class="item"><strong>${chatRoom.title}</strong>
					                	<c:if test="${chatMessageCnt[status.index] ne '0' }">
						                	<span id="messageStatus${status.index}" class="unread_msg">${chatMessageCnt[status.index]}</span>
					                	</c:if>
					                </div>
					                <c:forEach items="${chatMessageList}" var="chatMessage">
					                	<c:if test="${chatRoom.room_id eq chatMessage.room_id}">
							                <div class="item-chat item-chat${status.index}" data-message="${chatMessage.message}">
							                	${chatMessage.message}
							                	<span class="item-send-time${status.index}">${chatMessage.send_time}</span>
							                </div>
					                	</c:if>
					                </c:forEach>
				                </div>
				            </div>
			        	</c:forEach>
			        </div>
			        <div class="chat-area">
		        	<%-- 채팅창 영역 --%>
			        </div>
			        <div class="requestPay">
			        <%-- 송금요청 --%>
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
	<script>
		const imgURL = ${pageContext.request.contextPath} + "/resources/img/testPicture.png";
		
	</script>
</body>
</html>