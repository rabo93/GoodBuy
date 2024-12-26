<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/faq.css">

<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<section class="wrapper">
			<!-- *********** 여기 안에 작업하세요. section.wrapper 건들지말기 ******** -->
			<div id="faq_commandArea">
				<section>
					<div class="faq-container">
						<c:if test="${sessionScope.sGrade eq '관리자'}">
							<div class="faq-writebtn">
								<input type="button" value="글쓰기" onclick="location.href='FaqWrite'">
							</div>
						</c:if>
						<div class="faq-head">
							<h2>FAQ</h2>
						</div>
						<div class="faq-buttons">
							<button class="faq-button" onclick="showFAQ('policy')">운영정책</button>
							<button class="faq-button" onclick="showFAQ('memberAccount')">회원/계정</button>
							<button class="faq-button" onclick="showFAQ('payment')">전용페이</button>
							<button class="faq-button" onclick="showFAQ('etc')">기타</button>
						</div>
						<div class="faq-list" id="policy">
							<ul>
								<c:forEach items="${faqList}" var="faqBoard">
									<c:if test="${faqBoard.faq_cate eq 1}">
										<li>
											<button class="faq-item" onclick="toggleAnswer(this)">${faqBoard.faq_subject}</button>
											<div class="answer">${fn:replace(faqBoard.faq_content, '\\n', '<br>')}</div>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
						<div class="faq-list" id="memberAccount">
							<ul>
								<c:forEach items="${faqList}" var="faqBoard">
									<c:if test="${faqBoard.faq_cate eq 2}">
										<li>
											<button class="faq-item" onclick="toggleAnswer(this)">${faqBoard.faq_subject}</button>
											<div class="answer">
												${faqBoard.faq_content}
											</div>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
						<div class="faq-list" id="payment">
							<ul>
								<c:forEach items="${faqList}" var="faqBoard">
									<c:if test="${faqBoard.faq_cate eq 3}">
										<li>
											<button class="faq-item" onclick="toggleAnswer(this)">${faqBoard.faq_subject}</button>
											<div class="answer">
												${faqBoard.faq_content}
											</div>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
						<div class="faq-list" id="etc">
							<ul>
								<c:forEach items="${faqList}" var="faqBoard">
									<c:if test="${faqBoard.faq_cate eq 4}">
											<li>
												<button class="faq-item" onclick="toggleAnswer(this)">${faqBoard.faq_subject}</button>
												<div class="answer">
													${faqBoard.faq_content}
												</div>
											</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</div>
				</section>
			</div>
			<!-- *********** // 여기 안에 작업하세요. section.wrapper 건들지말기 ******** -->
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
	<script src="${pageContext.request.contextPath}/resources/js/faq.js"></script>
</body>
</html>