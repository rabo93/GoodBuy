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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>


<!-- font-awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontawesome/all.min.css" />
<script src="${pageContext.request.contextPath}/resources/fontawesome/all.min.js"></script>

<!-- ******************* 아래 CSS와 JS는 페이지별로 알맞게 Import 해주세요 ****************** -->
<!-- CSS for Page -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

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
				<div id="nt_commandArea">
					<div class="nt-head">
						<h2>공지사항</h2>
					</div>
					<section>
						<div class="tb-wrap">
							<table class="nt-table tb-01">
								<colgroup>
									<col width="60%">
									<col width="20%">
									<col width="20%">
								</colgroup>
									<tr>
										<th class="nt-title">제목</th>
										<th>작성자</th>
										<th>날짜</th>
									</tr>
									<c:forEach items="${noticeList}" var="noticeBoard">
										<tr>
											<td class="nt_id" hidden>${noticeBoard.notice_id}</td>
											<td class="nt_subject">${noticeBoard.notice_subject}</td>
											<td>${noticeBoard.mem_id}</td>
											<td>${noticeBoard.notice_date}</td>
										</tr>
<%-- 										<input type="hidden" class="nt_id" name="notice_id" value="${noticeBoard.notice_id}"> --%>
									</c:forEach>
							</table>
						</div>
					</section>
		<!--  ==============================    페이지처리영역		================================ -->
<!-- 				<section id="nt_pagingArea"> -->
<!-- 					<button -->
<%-- 					onclick="location.href='NoticeList?pageNum=${pageInfo.startPage - pageInfo.pageListLimit}&sort=${sort}&searchType=${searchType}&searchKeyword=${searchKeyword}'" --%>
<%-- 					<c:if test="${pageInfo.startPage eq 1}">disabled</c:if>> --%>
<!-- 						<i class="fa-solid fa-angles-left"></i> -->
<!-- 					</button> -->
<!-- 					<button -->
<%-- 					onclick="location.href='NoticeList?pageNum=${pageNum - 1}&sort=${sort}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'" --%>
<%-- 					<c:if test="${pageNum eq 1}">disabled</c:if>> --%>
<!-- 						<i class="fa-solid fa-angle-left"></i> -->
<!-- 					</button> -->
<%-- 					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}"> --%>
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${i eq pageNum}"> --%>
<%-- 								<strong>${i}</strong> --%>
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
<%-- 								<a href="NoticeList?pageNum=${i}&sort=${sort}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">${i}</a> --%>
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose> --%>
<%-- 					</c:forEach> --%>
					
<!-- 					<button -->
<%-- 					onclick="location.href='NoticeList?pageNum=${pageNum + 1}&sort=${sort}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'" --%>
<%-- 					<c:if test="${pageNum eq pageInfo.maxPage}">disabled</c:if>> --%>
<!-- 						<i class="fa-solid fa-angle-right"></i> -->
<!-- 					</button> -->
<!-- 				   	<button -->
<%-- 				   	onclick="location.href='NoticeList?pageNum=${pageInfo.startPage + pageInfo.pageListLimit}&sort=${sort}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}'" --%>
<%-- 					<c:if test="${pageInfo.endPage eq pageInfo.maxPage}">disabled</c:if>> --%>
<!-- 				   		<i class="fa-solid fa-angles-right"></i> -->
<!-- 				   	</button> -->
<!-- 				</section> -->
					<c:if test="${sessionScope.sGrade eq '관리자'}">
						<div class="nt-writebtn">
							<input type="button" value="글쓰기" onclick="location.href='NoticeWrite'">
						</div>
					</c:if>
			</div>
			<!-- *********** // 여기 안에 작업하세요. section.wrapper 건들지말기 ******** -->
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>
<script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>
<script type="text/javascript">
	if (performance.navigation.type === 1) {
		location.href= "NoticeMain";
	}
</script>
</html>