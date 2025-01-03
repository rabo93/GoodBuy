<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<!-- -->
				<h2 class="page-ttl">마이페이지</h2>
				<section class="my-wrap">
					<aside class="my-menu">
						<h3>거래 정보</h3>
						<a href="MyStore">나의 상점</a> <a href="GoodPay">굿페이</a> <a
							href="MyOrder">구매내역</a> <a href="MySales">판매내역</a>
						<h3>나의 정보</h3>
						<a href="MyInfo">계정정보</a> <a href="MyWish">관심목록</a> <a
							href="MyReview">나의 후기</a> <a href="MyReviewHistory">내가 쓴 후기</a> <a
							href="MySupport" class="active">1:1문의내역</a> <a href="">나의 광고</a>
					</aside>
					<div class="my-container">
						<div class="contents-ttl">1:1문의 게시판</div>
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<!-- contents -->
				<section class="inq-wrap">
					<div class="inq-tops">
						<button class="btn-inq" onclick="location.href='/MySupportWrite'">문의
							남기기</button>
					</div>
					<div class="tb-wrap">
						<table class="tb-01 tb-inq">
							<tbody>
								<c:choose>
									<c:when test="${empty support}">
										<tr>
											<td class="empty" colspan="4">작성한 문의내역이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="support" items="${support}">
											<tr>
												<td class="board_num" style="display: none;">${support.support_id}</td>
												<td><c:if test="${support.support_category == 1}">
													이용문의
												</c:if> <c:if test="${support.support_category == 2}">
													결제문의
												</c:if> <c:if test="${support.support_category == 3}">
													기타
												</c:if></td>
												<td class="subject">${support.support_subject} <c:if
														test="${support.support_answer_date != null}">
														<span class="inq-reply">답변완료 <i
															class="fa-solid fa-reply"></i></span>
													</c:if>
												</td>
												<td>${support.mem_id}</td>
												<td>${support.support_date}</td>
											</tr>

										</c:forEach>
									</c:otherwise>
								</c:choose>
								<!-- 									<tr class="reply"> -->
								<!-- 										<td>└</td> -->
								<!-- 										<td>답변</td> -->
								<!-- 										<td class="subject">안녕하세요. 런온 입니다.</td> -->
								<!-- 										<td>관리자</td> -->
								<!-- 										<td>2024-11-06</td> -->
								<!-- 									</tr> -->
							</tbody>
						</table>
					</div>
					</div>
				</section>
				</section>
				</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>

	<script type="text/javascript">
			$(".subject").on("click", function(event) {
				let parent = $(event.target).parent();
				let board_num = $(parent).find(".board_num");
				console.log(board_num.text());
				location.href = "MySupportDetail?support_id=" + board_num.text();
			});
	</script>





</body>
</html>