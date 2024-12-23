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
			<div id="nt_dt_form">
				<h2>공지사항</h2>
				<section class="tb-con">
					<div class="tb-hd">
						<h3 class="ttl">${notice.notice_subject}</h3>
						작성자 : <span class="author">${notice.mem_id}</span>
						작성일자 : <span class="date">${notice.notice_date}</span>
						조회수 : <span class="count">${notice.notice_read_count}</span>
					</div>
					<div class="tb-details">
						${notice.notice_content}
					</div>
					<div class="tb-files">
						<c:if test="${not empty notice.notice_file}">
						 	<div>
						 		<i class="fa-solid fa-paperclip"></i> ${originalFile}
						 		<a href="${pageContext.request.contextPath}/resources/upload/${notice.notice_file}"
						 		   download="${originalFile}">
					 			<input type="button" value="다운로드">
						 		</a>
						 	</div>
						 </c:if>
					</div>
				</section>
				<section class="tb-btns">
					<c:if test="${sessionScope.sGrade eq '관리자'}">
						<button class="btn-02" onclick="noticeDelete()">삭제</button>
						<button class="btn-03" onclick="noticeModify()">수정</button>
					</c:if>
					<button class="btn-03" onclick="location.href='NoticeMain'">목록</button>
				</section>
			</div>
			<!-- *********** // 여기 안에 작업하세요. section.wrapper 건들지말기 ******** -->
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>
<script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>
</html>